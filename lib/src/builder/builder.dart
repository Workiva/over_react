// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

import './util.dart';
import 'codegen.dart';
import 'parsing.dart';

Builder overReactBuilder(BuilderOptions options) => OverReactBuilder();

class OverReactBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': [outputExtension],
  };

  /// The generation order of boilerplate declarations.
  ///
  /// Changing the order of this iterable changes the order in which
  /// the builder will write the generated code to the output file.
  static const generationOrder = [
    DeclarationType.classComponentDeclaration,
    DeclarationType.legacyClassComponentDeclaration,
    DeclarationType.propsMixinDeclaration,
    DeclarationType.stateMixinDeclaration,
    DeclarationType.propsMapViewOrFunctionComponentDeclaration,
    DeclarationType.legacyAbstractPropsDeclaration,
    DeclarationType.legacyAbstractStateDeclaration,
  ];

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final source = await buildStep.readAsString(buildStep.inputId);
    final libraryUnit = _tryParseCompilationUnit(source, buildStep.inputId);
    if (libraryUnit == null) {
      return;
    }
    if (isPart(libraryUnit)) {
      return;
    }

    final outputs = <String>[];
    void generateForFile(String source, AssetId id, CompilationUnit unit) {
      if (!mightContainDeclarations(source)) {
        return;
      }
      final sourceFile = SourceFile.fromString(
        source, url: idToPackageUri(id));

      //
      // Set up error collection, logging, and utilities to be used by parsing and codegen.
      //

      // A local flag to help determine if a specific call resulted in errors.
      // Should be reset before using.
      var hadErrors = false;
      final errorCollector = ErrorCollector.callback(sourceFile,
        onError: (message, [span]) {
          log.severe(span?.message(message) ?? message);
          hadErrors = true;
        },
        onWarning: (message, [span]) {
          log.warning(span?.message(message) ?? message);
        },
      );

      //
      // Parse boilerplate members and group them into declarations.
      //

      final members = detectBoilerplateMembers(unit);
      final declarations = getBoilerplateDeclarations(members, errorCollector).toList()
        ..sort((a, b) {
          return generationOrder.indexOf(a.type).compareTo(generationOrder.indexOf(b.type));
        });

      //
      // Validate boilerplate declarations and generate if there aren't any errors.
      //

      final generator = ImplGenerator(log, sourceFile);

      for (final declaration in declarations) {
        hadErrors = false;
        declaration.validate(errorCollector);
        if (!hadErrors) {
          generator.generate(declaration);
        } else {
          // Log the declaration that had issues for debugging purposes.
          log.severe('The above error(s) are associated with $declaration');
          log.fine('Members:');
          for (final member in declaration.members) {
            log.fine(member.debugString);
          }
        }
      }

      final generatedOutput = generator.outputContentsBuffer.toString().trim();
      if (generatedOutput.isNotEmpty) {
        outputs.add(generatedOutput);
      }
    }

    // Collect all of the part files for this library.
    final parts = getNonGeneratedParts(libraryUnit);

    // Generate over_react code for the input library.
    generateForFile(source, buildStep.inputId, libraryUnit);


    final outputId = buildStep.inputId.changeExtension(outputExtension);
    final expectedPart = p.basename(outputId.path);

    bool hasOutputPartDirective() {
      final partUris = libraryUnit.directives
        .whereType<PartDirective>()
        .map((p) => p.uri.stringValue);
      return partUris.contains(expectedPart);
    }

    // Generate over_react code for each part file of the input library.
    for (final part in parts) {
      final partId = AssetId.resolve(
        Uri.parse(part.uri.stringValue),
        from: buildStep.inputId);
      if (!await buildStep.canRead(partId)) {
        continue;
      }
      final partSource = await buildStep.readAsString(partId);
      final partUnit = _tryParseCompilationUnit(partSource, partId);
      if (partUnit == null) {
        continue;
      }
      generateForFile(partSource, partId, partUnit);
    }

    if (outputs.isNotEmpty) {
      // Verify that the library file has an `.over_react.g.dart` part.
      if (!hasOutputPartDirective()) {
        log.severe('Missing "part \'$expectedPart\';".');
      }

      // Generated part files must have matching language version comments, so copy them over if they exist.
      // TODO use CompilationUnit.languageVersionToken instead of parsing this manually once we're sure we can get on analyzer version 0.39.5 or greater
      final languageVersionCommentMatch = RegExp(r'//\s*@dart\s*=\s*.+').firstMatch(source);
      await _writePart(buildStep, outputId, outputs, languageVersionComment: languageVersionCommentMatch?.group(0));
    } else {
      if (hasOutputPartDirective()) {
        log.warning('An over_react part directive was found in ${buildStep.inputId.path}, '
            'but no code was generated. The part directive may be unnecessary if the file '
            'does not contain any concrete components or abstract state/props classes.');
      }
    }
  }

  static final _headerLine = '// '.padRight(77, '*');

  static final _formatter = DartFormatter();

  static CompilationUnit _tryParseCompilationUnit(String source, AssetId id) {
    final result = parseString(content: source, path: id.path, throwIfDiagnostics: false);

    if (result.errors.isEmpty) return result.unit;

    log.fine('Analysis errors encountered when parsing compilation unit for file "$id":');
    // Warn and not severe in case parsing failed on an unrelated file due to an outdated
    // analyzer version in this builder.
    result.errors.forEach(log.warning);

    return null;
  }

  static FutureOr<void> _writePart(BuildStep buildStep, AssetId outputId, Iterable<String> outputs, {String languageVersionComment}) async {
    final partOf = "'${p.basename(buildStep.inputId.uri.toString())}'";

    final buffer = StringBuffer();
    if (languageVersionComment != null) {
      buffer.writeln(languageVersionComment);
    }
    buffer
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln()
      ..writeln('// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators')
      ..writeln('part of $partOf;')
      ..writeln()
      ..writeln(_headerLine)
      ..writeln('// OverReactBuilder (package:over_react/src/builder.dart)')
      ..writeln(_headerLine);

    for (final item in outputs) {
      buffer
        ..writeln()
        ..writeln(item);
    }

    var output = buffer.toString();
    // Output the file even if formatting fails, so that it can be used to debug the issue.
    try {
      output = _formatter.format(buffer.toString());
    } catch (e, st) {
      log.severe('Error formatting generated code', e, st);
    }
    await buildStep.writeAsString(outputId, output);
  }
}
