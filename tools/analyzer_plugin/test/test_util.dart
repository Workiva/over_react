import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart' show DriverBasedAnalysisContext;
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

// Reuse an analysis context across multiple calls,
// which is much faster than spinning up a new one each time
// when resolving files.
var _hasInitializedSharedCollection = false;
late AnalysisContextCollection _sharedCollection;
late OverlayResourceProvider _sharedResourceProvider;

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
  const pathPrefix = '/fake_in_memory_path';

  String transformPath(String path) => p.join(pathPrefix, path);

  final dartSourcesByAbsolutePath = dartSourcesByPath.map((key, value) => MapEntry(transformPath(key), value));

  if (!_hasInitializedSharedCollection) {
    _sharedResourceProvider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);

    // Create a fake in memory package that opts out of null safety
    // TODO clean this up, perhaps use SharedAnalysisContextCollection from over_react_codemod
    const packageName = 'package_depending_on_over_react';
    _sharedResourceProvider.setOverlay(transformPath('pubspec.yaml'),
        content: '''
  name: $packageName
  publish_to: none
  environment:
    # Opt out of null safety since it gets in our way for these tests
    sdk: '>=2.11.0 <3.0.0'
  dependencies:
    over_react: ^4.3.1
  ''',
        modificationStamp: 0);
    // Steal the packages file from this project, which depends on over_react
    final currentPackageConfig = File('.dart_tool/package_config.json').readAsStringSync();
    final updatedConfig = jsonDecode(currentPackageConfig) as Map;
    (updatedConfig['packages'] as List).cast<Map>()
      // Need to get rid of this config so its rootUri doesn't cause it to get used for this package.
      ..removeSingleWhere((package) => package['name'] == 'over_react_analyzer_plugin')
      ..add(<String, String>{
        "name": packageName,
        "rootUri": "../",
        "packageUri": "lib/",
        // Opt out of null safety since it gets in our way for these tests
        "languageVersion": "2.7",
      });
    _sharedResourceProvider.setOverlay(transformPath('.dart_tool/package_config.json'),
        content: jsonEncode(updatedConfig), modificationStamp: 0);

    _sharedCollection = AnalysisContextCollection(
      includedPaths: dartSourcesByAbsolutePath.keys.toList(),
      resourceProvider: _sharedResourceProvider,
    );
    _hasInitializedSharedCollection = true;
  }

  dartSourcesByAbsolutePath.forEach((absolutePath, source) {
    _sharedResourceProvider.setOverlay(
      absolutePath,
      content: source,
      modificationStamp: 0,
    );
  });

  try {
    final results = <String, ResolvedUnitResult>{};
    for (final path in dartSourcesByPath.keys) {
      final absolutePath = transformPath(path);
      final context = _sharedCollection.contextFor(absolutePath);
      final result = await context.currentSession.getResolvedUnit2(absolutePath) as ResolvedUnitResult;
      final lineInfo = result.lineInfo;
      final filteredErrors =
          filterIgnores(result.errors, lineInfo, () => IgnoreInfo.forDart(result.unit!, result.content!))
              // only fail for error severity errors.
              .where((error) => error.severity == Severity.error);
      if (filteredErrors.isNotEmpty) {
        final source = dartSourcesByPath[path];
        throw ArgumentError('Parse errors in source "$path":\n${filteredErrors.join('\n')}\nFull source:\n$source');
      }
      results[path] = result;
    }
    return results;
  } finally {
    // Clean up files overlays
    dartSourcesByAbsolutePath.forEach((absolutePath, source) {
      _sharedResourceProvider.removeOverlay(absolutePath);
      // Make sure the driver doesn't cache this file for subsequent calls to this function using files of the same name.
      (_sharedCollection.contextFor(absolutePath) as DriverBasedAnalysisContext).driver.removeFile(absolutePath);
    });
  }
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
Future<Expression> parseExpression(
  String expression, {
  String imports = '',
  bool isResolved = false,
}) async {
  late CompilationUnit unit;
  // Wrap the expression in parens to ensure this is interpreted as an expression
  // for ambiguous cases (e.g, a map literal that could be interpreted as an empty block).
  final source = '''
    $imports
    void wrapperFunction() {
      ($expression);
    }
  ''';
  if (isResolved) {
    final result = await parseAndGetResolvedUnit(source);
    unit = result.unit!;
  } else {
    unit = parseString(content: source).unit;
  }
  final parsedFunction = unit.childEntities.whereType<FunctionDeclaration>().last;
  final body = parsedFunction.functionExpression.body as BlockFunctionBody;
  final statement = body.block.statements.single as ExpressionStatement;
  // Unwrap the expression. Don't use `.unparenthesized` since it unwraps all sets of parentheses.
  return (statement.expression as ParenthesizedExpression).expression;
}

extension<E> on List<E> {
  E removeSingleWhere(bool Function(E) test) {
    final firstIndex = indexWhere(test);
    if (firstIndex == -1) throw StateError('No matching item found');

    final lastIndex = lastIndexWhere(test);
    if (lastIndex != firstIndex) throw StateError('More than one matching item found');

    return removeAt(firstIndex);
  }
}
