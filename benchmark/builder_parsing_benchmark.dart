import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:over_react/src/builder/parsing.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

/// A basic benchmark for parsing over_react declarations.
class ParseDeclarationsBenchmark extends BenchmarkBase {
  ParseDeclarationsBenchmark() : super('ParseDeclarations');

  static void main() {
    ParseDeclarationsBenchmark().report();
  }

  late List<ErrorCollector> errorCollectors;
  late List<CompilationUnit> units;

  // The benchmark code.
  @override
  void run() {
    for (var i = 0; i < units.length; i++) {
      final unit = units[i];
      final errorCollector = errorCollectors[i];
      // This returns a lazy iterable, so trigger full processing of it.
      parseDeclarations(unit, errorCollector).toList();
    }
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    print('setup: finding files...');
    // Just grab a bunch of files that probably have over_react declarations and use that as our test data.
    final filePaths = Glob('{example,lib,web,tools/analyzer_plugin/playground/web}/**.dart')
        .listSync()
        .whereType<File>()
        // This is the same check the builder uses when discovering files.
        .where((f) => mightContainDeclarations(f.readAsStringSync()))
        .map((f) => f.path)
        .map(p.canonicalize)
        .toList();

    print('setup: parsing AST...');
    final contextCollection = AnalysisContextCollection(includedPaths: filePaths);

    units = [];
    errorCollectors = [];
    for (final filePath in filePaths) {
      final result = contextCollection.contextFor(filePath).currentSession.getParsedUnit(filePath);
      if (result is! ParsedUnitResult) {
        throw Exception('Error parsing file $filePath: $result');
      }
      units.add(result.unit);
      errorCollectors
          .add(ErrorCollector.callback(SourceFile.fromString(result.content, url: result.uri)));
    }
    print('setup: done. units.length: ${units.length}');
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() {}
}

void main() {
  ParseDeclarationsBenchmark.main();
}
