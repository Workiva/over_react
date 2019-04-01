import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/generation/impl_generation.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

import './util.dart';

Builder overReactBuilder(BuilderOptions options) => new OverReactBuilder();

class OverReactBuilder extends Builder {
  static final _headerLine = '// '.padRight(77, '*');

  static final _formatter = new DartFormatter();

  static final RegExp _overReactPartDirective = new RegExp(
    r'''['"].*\.over_react\.g\.dart['"]''',
  );

  static bool _mightContainDeclarations(String source) {
    return ParsedDeclarations.key_any_annotation.hasMatch(source) ||
      _overReactPartDirective.hasMatch(source);
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final source = await buildStep.readAsString(buildStep.inputId);
    if (!_mightContainDeclarations(source)) {
      return;
    }

    CompilationUnit libraryUnit;
    try {
      libraryUnit = parseCompilationUnit(
        source,
        name: buildStep.inputId.path,
        suppressErrors: false,
        parseFunctionBodies: true);
    } catch (error, stackTrace) {
      log.severe('There was an error parsing the compilation unit for file: ${buildStep.inputId}');
      log.fine(error);
      log.fine(stackTrace);
      return;
    }

    if (isPart(libraryUnit)) {
      return;
    }

    final librarySourceFile = new SourceFile.fromString(
      source,
      url: idToPackageUri(buildStep.inputId));
    final libraryDeclarations = new ParsedDeclarations(
      libraryUnit,
      librarySourceFile,
      log);
    if (libraryDeclarations.hasErrors) {
      log.severe('There was an error parsing the file declarations for file: ${buildStep.inputId}');
      return;
    }

    final outputs = <String>[];
    final libraryGenerator = new ImplGenerator(log, librarySourceFile)
      ..generate(libraryDeclarations);
    outputs.add(libraryGenerator.outputContentsBuffer.toString());

    final parts = libraryUnit.directives
      .whereType<PartDirective>()
      // Ignore `.over_react.g.dart` parts - that's what we're generating.
      .where((part) => !part.uri.stringValue.endsWith(outputExtension));

    for (final part in parts) {
      final partId = new AssetId.resolve(
        part.uri.stringValue,
        from: buildStep.inputId);
      final partSource = await buildStep.readAsString(partId);
      final partSourceFile = new SourceFile.fromString(
        partSource,
        url: idToPackageUri(partId));
      CompilationUnit partUnit;
      try {
        partUnit = parseCompilationUnit(
          partSource,
          name: partId.path,
          suppressErrors: false,
          parseFunctionBodies: true);
      } catch (error, stackTrace) {
        log.severe('There was an error parsing the compilation unit for file: $partId');
        log.fine(error);
        log.fine(stackTrace);
        return;
      }
      final partDeclarations = new ParsedDeclarations(partUnit, partSourceFile, log);
      if (partDeclarations.hasErrors) {
        log.severe('There was an error parsing the file declarations for file: ${buildStep.inputId}');
        return;
      }
      final partGenerator = new ImplGenerator(log, partSourceFile)
        ..generate(partDeclarations);
      outputs.add(partGenerator.outputContentsBuffer.toString());
    }

    final nonEmptyOutputs = outputs
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty);
    if (nonEmptyOutputs.isEmpty) {
      return;
    }

    await _writePart(buildStep, nonEmptyOutputs);
  }

  FutureOr<void> _writePart(BuildStep buildStep, Iterable<String> outputs) async {
    final outputId = buildStep.inputId.changeExtension(outputExtension);
    final partOf = "'${p.basename(buildStep.inputId.uri.toString())}'";

    final buffer = new StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln()
      ..writeln('part of $partOf;')
      ..writeln()
      ..writeln(_headerLine)
      ..writeln('// OverReactGenerator')
      ..writeln(_headerLine);

    for (final item in outputs) {
      buffer
        ..writeln()
        ..writeln(item);
    }

    final output = _formatter.format(buffer.toString());
    await buildStep.writeAsString(outputId, output);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': [outputExtension],
  };
}