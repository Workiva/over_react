import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

import './util.dart';
import 'generation/codegen.dart';
import 'generation/parsing.dart';

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
    DeclarationType.propsMapViewDeclaration,
    DeclarationType.legacyAbstractPropsDeclaration,
    DeclarationType.legacyAbstractStateDeclaration,
    DeclarationType.functionComponentDeclaration,
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

      var hasErrors = false;
      final errorCollector = ErrorCollector.callback(sourceFile,
        onError: (message, [span]) {
          log.severe(span?.message(message) ?? message);
          hasErrors = true;
        },
        onWarning: (message, [span]) {
          log.warning(span?.message(message) ?? message);
        },
      );

      final generator = ImplGenerator(log, sourceFile);

      final members = BoilerplateMembers.detect(unit);
      final declarations = getBoilerplateDeclarations(members, errorCollector).toList()
        ..sort((a, b) {
          return generationOrder.indexOf(a.type).compareTo(generationOrder.indexOf(b.type));
        });

      if (hasErrors) {
        // Log the members that weren't grouped into declarations.
        members.allMembers.forEach(log.info);
        hasErrors = false;
      }

      for (final declaration in declarations) {
        hasErrors = false;
        declaration.validate(errorCollector);
        if (!hasErrors) {
          generator.generate([declaration]);
        } else {
          log.info(declaration);
          declaration.members.forEach(log.info);
          hasErrors = false;
        }
      }

      final generatedOutput = generator.outputContentsBuffer.toString().trim();
      if (generatedOutput.isNotEmpty) {
        outputs.add(generatedOutput);
      }
    }

    // Collect all of the part files for this library.
    final parts = libraryUnit.directives
      .whereType<PartDirective>()
      // Ignore all generated `.g.dart` parts.
      .where((part) => !part.uri.stringValue.endsWith('.g.dart'));

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
        part.uri.stringValue,
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

      await _writePart(buildStep, outputId, outputs);
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
    try {
      return parseCompilationUnit(
        source,
        name: id.path,
        suppressErrors: false,
        parseFunctionBodies: true);
    } catch (error, stackTrace) {
      log
        ..fine('There was an error parsing the compilation unit for file: $id')
        ..fine(error)
        ..fine(stackTrace);
      return null;
    }
  }

  static FutureOr<void> _writePart(BuildStep buildStep, AssetId outputId, Iterable<String> outputs) async {
    final partOf = "'${p.basename(buildStep.inputId.uri.toString())}'";

    final buffer = StringBuffer()
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

    final output = _formatter.format(buffer.toString());
    await buildStep.writeAsString(outputId, output);
  }
}
