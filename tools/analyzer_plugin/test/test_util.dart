import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';
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
Future<ResolvedUnitResult> parseAndGetResolvedUnit(String dartSource, {String path = 'dartSource.dart'}) async {
  final results = await parseAndGetResolvedUnits({path: dartSource});
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
Future<Map<String, ResolvedUnitResult>> parseAndGetResolvedUnits(Map<String, String> dartSourcesByPath) async {
  // Must be absolute.
  // Hack: use a path inside this project directory so that we end up in the same context as the current package,
  // and can resolve imports for all dependencies (including over_react, react, etc.)
  final pathPrefix = p.absolute('_fake_in_memory_path');

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
    final lineInfo = result.unit.lineInfo;
    final filteredErrors =
        filterIgnores(result.errors, lineInfo, () => IgnoreInfo.forDart(result.unit, result.content));
    if (filteredErrors.isNotEmpty) {
      throw ArgumentError('Parse errors in source "$path":\n${filteredErrors.join('\n')}');
    }
    results[path] = result;
  }
  return results;
}

List<AnalysisError> filterIgnores(List<AnalysisError> errors, LineInfo lineInfo, IgnoreInfo Function() lazyIgnoreInfo) {
  if (errors.isEmpty) {
    return errors;
  }

  return _filterIgnored(errors, lazyIgnoreInfo(), lineInfo);
}

List<AnalysisError> _filterIgnored(List<AnalysisError> errors, IgnoreInfo ignoreInfo, LineInfo lineInfo) {
  if (errors.isEmpty || !ignoreInfo.hasIgnores) {
    return errors;
  }

  bool isIgnored(AnalysisError error) {
    final errorLine = lineInfo.getLocation(error.offset).lineNumber;
    final errorCode = error.errorCode.name.toLowerCase();
    return ignoreInfo.ignoredAt(errorCode, errorLine);
  }

  return errors.where((e) => !isIgnored(e)).toList();
}

/// Returns [expression] parsed as AST.
///
/// This is accomplished it by including the [expression] as a statement within a wrapper function
/// with any necessary [imports] at the top of the source. As a result, the offset of the
/// returned expression will not be 0.
///
/// To return resolved AST, set [isResolved] to true.
///
/// Returns null if [expression] is not an [InvocationExpression].
Future<InvocationExpression> parseExpression(
  String expression, {
  String imports = '',
  bool isResolved = false,
}) async {
  CompilationUnit unit;
  final source = '''
    $imports
    void wrapperFunction() {
      $expression;
    }
  ''';
  if (isResolved) {
    final result = await parseAndGetResolvedUnit(source);
    unit = result.unit;
  } else {
    unit = parseString(content: source).unit;
  }
  final parsedFunction = unit.childEntities.whereType<FunctionDeclaration>().last;
  final body = parsedFunction.functionExpression.body as BlockFunctionBody;
  final statement = body.block.statements.single as ExpressionStatement;
  final invocationExpression = statement.expression;
  if (invocationExpression is InvocationExpression) {
    return invocationExpression;
  }
  return null;
}
