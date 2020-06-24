import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:path/path.dart' as p;

/// Parses [dartSource] and returns the unresolved AST, throwing if there are any syntax errors.
CompilationUnit parseAndGetUnit(String dartSource) {
  final result = parseString(
    content: dartSource,
    throwIfDiagnostics: false,
    path: 'dart source from string',
  );
  // `throwIfDiagnostics: true` throws, but does not include the actual errors in the exception.
  // We'll handle throwing when there are errors.
  if (result.errors.isNotEmpty) {
    throw ArgumentError('Parse errors in source:\n${result.errors.join('\n')}');
  }
  return result.unit;
}

/// Parses [dartSource] and returns the first node of type [T].
///
/// Useful for easily creating a node of a certain type for tests.
///
/// Throws if a matching node is not found.
///
/// Example:
/// ```dart
/// final body = parseAndGetNode<BlockFunctionBody>(r'''
///   myFunction() {
///     // ...
///   }
/// ''');
/// ```
T parseAndGetNode<T extends AstNode>(String dartSource) => allDescendantsOfType<T>(parseAndGetUnit(dartSource)).first;

/// Parses [dartSource] as an expression and returns the first component usage. Since we need a valid
/// compilation unit to parse code, be sure to wrap the usage in a function body, variable, or other node.
///
/// Useful for easily creating a component usage certain type for tests.
///
/// Throws if a usage is not found for the first invocationExpression.
///
/// Example:
/// ```dart
/// final usage1 = parseAndGetComponentUsage(r'''
///   render() => Dom.div()();
/// ''');
///
/// final usage2 = parseAndGetComponentUsage(r'''
///   var foo = Dom.div()();
/// ''');
/// ```
FluentComponentUsage parseAndGetComponentUsage(String dartSource) {
  final usage = getComponentUsage(parseAndGetNode<InvocationExpression>(dartSource));
  if (usage == null) throw ArgumentError('Source did not contain component usage');
  return usage;
}

/// Parses [dartSource] and returns the resolved AST, throwing if there are any static analysis errors.
Future<ResolvedUnitResult> parseAndGetResolvedUnit(
  String dartSource, {
  String path = 'dartSource.dart',
  bool shouldThrowErrors = true,
}) async {
  final results = await parseAndGetResolvedUnits({path: dartSource}, shouldThrowErrors: shouldThrowErrors);
  return results.values.single;
}

/// Parses a collection of Dart sources and returns the resolved ASTs,
/// throwing if there are any static analysis errors.
///
/// Useful when you need multiple files that reference each other.
///
/// Example:
/// ```dart
///  final results = await parseAndGetResolvedUnits({
///    'foo.dart': r'''
///      class Foo {}
///    ''',
///
///    'bar.dart': r'''
///      import 'foo.dart';
///      class Bar extends Foo {}
///    ''',
///  });
///
///  final barResolveResult = results['bar.dart'];
///  final barElement = barResolveResult.unit.declaredElement.getType('Bar');
///  print(barElement.allSupertypes); // [Foo, Object]
/// ```
Future<Map<String, ResolvedUnitResult>> parseAndGetResolvedUnits(
  Map<String, String> dartSourcesByPath, {
  bool shouldThrowErrors = true,
}) async {
  // Must be absolute
  const pathPrefix = '/_fake_in_memory_path/';

  String transformPath(String path) => p.join(pathPrefix, path);

  final resourceProvider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  dartSourcesByPath.forEach((path, source) {
    resourceProvider.setOverlay(
      transformPath(path),
      content: source,
      modificationStamp: 0,
    );
  });

  final collection = AnalysisContextCollection(
    includedPaths: dartSourcesByPath.keys.map(transformPath).toList(),
    resourceProvider: resourceProvider,
  );

  final results = <String, ResolvedUnitResult>{};
  for (final path in dartSourcesByPath.keys) {
    final context = collection.contextFor(transformPath(path));
    final result = await context.currentSession.getResolvedUnit(transformPath(path));
    if (shouldThrowErrors && result.errors.isNotEmpty) {
      throw ArgumentError('Parse errors in source "$path":\n${result.errors.join('\n')}');
    }
    results[path] = result;
  }
  return results;
}
