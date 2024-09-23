import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ignore_info.dart';

import 'util/shared_analysis_context.dart';

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
Future<ResolvedUnitResult> parseAndGetResolvedUnit(String dartSource, {String? path}) async {
  final sharedContext = SharedAnalysisContext.overReact;
  final testFilePath = SharedAnalysisContext.overReact.createTestFile(dartSource, filename: path);
  final result = await sharedContext.collection.contextFor(testFilePath).currentSession.getResolvedUnit(testFilePath)
      as ResolvedUnitResult;

  final lineInfo = result.lineInfo;
  final filteredErrors =
      filterIgnoresForErrors(result.errors, lineInfo, () => IgnoreInfo.forDart(result.unit, result.content))
          // only fail for error severity errors.
          .where((error) => error.severity == Severity.error);
  if (filteredErrors.isNotEmpty) {
    throw ArgumentError('Parse errors in source "$path":\n${filteredErrors.join('\n')}\nFull source:\n$dartSource');
  }
  return result;
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
  // Put the closing paren on its own line so that end-of-line comments don't comment it out,
  // and the opening paren on its own line so any ignore comments aren't treated as end-of-line comments.
  final source = '''
    $imports
    void wrapperFunction() {
      (
        $expression
      );
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
  // Unwrap the expression. Don't use `.unparenthesized` since it unwraps all sets of parentheses.
  return (statement.expression as ParenthesizedExpression).expression;
}
