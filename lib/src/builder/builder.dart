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
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:package_config/package_config.dart' as pc;
import 'package:source_span/source_span.dart';

import './util.dart';
import 'codegen.dart';
import 'parsing.dart';

Builder overReactBuilder(BuilderOptions? options) => OverReactBuilder();

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

    String nullSafetyReason;
    bool nullSafety;
    {
      final languageVersionToken = libraryUnit.languageVersionToken;
      if (languageVersionToken != null) {
        // If there's a language version comment, honor that.
        nullSafety = languageVersionToken.supportsNullSafety;
        nullSafetyReason = 'because of language version comment in main library of '
            "'${languageVersionToken.major}.${languageVersionToken.minor}'";
      } else {
        // Otherwise, read the language version from the package config.
        //
        // Normally, builders would do this via (await buildStep.inputLibrary).languageVersion,
        // but that would trigger resolved analysis which we don't want to do for this builder,
        // for performance reasons.
        final packageName = buildStep.inputId.package;

        // Catch any errors coming from our implementation of `$packageConfig`.
        // We can remove this once we switch to build 2.4.0's `packageConfig`
        // (see `$packageConfig` doc comment for more info).
        pc.LanguageVersion? packageConfigLanguageVersion;
        try {
          packageConfigLanguageVersion = (await buildStep.$packageConfig)
              .packages
              .firstWhereOrNull((p) => p.name == packageName)
              ?.languageVersion;
        } catch (e, st) {
          log.warning('Error reading package config', e, st);
        }

        if (packageConfigLanguageVersion != null) {
          nullSafety = packageConfigLanguageVersion.supportsNullSafety;
          nullSafetyReason =
              "because of $packageName\'s language version of '$packageConfigLanguageVersion'.";
        } else {
          // If we don't have any information to go off of, opt out of null safety in 2.x,
          // and opt in for newer versions (Dart 3+).
          // It should be pretty unlikely that we don't have access to the package config,
          // or that the file being generated doesn't have an associated package.
          final platformOnlySupportsNullSafety = !Platform.version.startsWith('2.');
          nullSafety = platformOnlySupportsNullSafety;
          nullSafetyReason =
              'because null safety could not be inferred from language version comments'
                      ' or package config, and the current Dart SDK version ' +
                  (platformOnlySupportsNullSafety
                      ? 'only supports null safety'
                      : 'does not support null safety by default');
        }
      }
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

      final generator = ImplGenerator(log, sourceFile, nullSafety: nullSafety);

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
        Uri.parse(part.uri.stringValue!),
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

      final nullSafetyCommentText = 'Using null safety: $nullSafety, $nullSafetyReason';

      // Generated part files must have matching language version comments, so copy them over if they exist.
      // TODO use CompilationUnit.languageVersionToken instead of parsing this manually once we're sure we can get on analyzer version 0.39.5 or greater
      final languageVersionCommentMatch = RegExp(r'//\s*@dart\s*=\s*.+').firstMatch(source);
      await _writePart(buildStep, outputId, outputs,
          nullSafetyCommentText: nullSafetyCommentText,
          languageVersionComment: languageVersionCommentMatch?.group(0));
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

  static CompilationUnit? _tryParseCompilationUnit(String source, AssetId id) {
    final result = parseString(content: source, path: id.path, throwIfDiagnostics: false);

    if (result.errors.isEmpty) return result.unit;

    log.fine('Analysis errors encountered when parsing compilation unit for file "$id":');
    // Warn and not severe in case parsing failed on an unrelated file due to an outdated
    // analyzer version in this builder.
    result.errors.forEach(log.warning);

    return null;
  }

  static FutureOr<void> _writePart(BuildStep buildStep, AssetId outputId, Iterable<String> outputs,
      {required String nullSafetyCommentText, String? languageVersionComment}) async {
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
      ..writeln('// OverReactBuilder (package:over_react/src/builder.dart)');
    // Omit this for now for filed from over_react so it doesn't show up as a diff in golds and
    // checked in files in the conditional null safety generation PR.
    // TODO re-enable after that merges.
    if (outputId.package != 'over_react') {
      buffer
        ..writeln('//')
        ..write(lineComment(nullSafetyCommentText));
    }
    buffer.writeln(_headerLine);

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

bool languageVersionSupportsNullSafety(int major, int minor) => major > 2 || (major == 2 && minor >= 12);

extension on LanguageVersionToken {
  bool get supportsNullSafety => languageVersionSupportsNullSafety(major, minor);
}

extension on pc.LanguageVersion {
  bool get supportsNullSafety => languageVersionSupportsNullSafety(major, minor);
}

extension on BuildStep {
  // Cache the result so we don't read and parse the package config for every file.
  //
  // This value should be safe to reuse globally within an isolate.
  static pc.PackageConfig? _cachedPackageConfig;

  /// Polyfill for build 2.4.0's BuildStep.packageConfig, which only seems to be resolvable in Dart 3.
  /// From: https://github.com/dart-lang/build/issues/3492#issuecomment-1533455176
  ///
  /// We could name this `packageConfig` and have it get shadowed by the real implementation from
  /// `BuildStep` when 2.4.0 is resolved to, but that feels unnecessarily risky, and we can just
  /// follow up later to remove this extension and use the real implementation instead.
  Future<pc.PackageConfig> get $packageConfig async {
    return _cachedPackageConfig ??= await pc.loadPackageConfigUri((await Isolate.packageConfig)!);
  }
}
