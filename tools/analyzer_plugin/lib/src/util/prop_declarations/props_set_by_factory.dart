import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

Set<String>? getPropsSetByFactory(Element factoryElement) {
  // We'll use the name offset/length to find the AST node that declares this element.
  final factoryNameOffset = factoryElement.nameOffset;
  if (factoryNameOffset == -1) return null;

  final factoryNameLength = factoryElement.nameLength;
  if (factoryNameLength == 0) return null;

  //
  // Get the AST for the file that declares factoryElement.

  final factoryFileSource = factoryElement.source;
  if (factoryFileSource == null) return null;

  final session = factoryElement.session;
  if (session == null) return null;

  // We don't need resolved AST, so get unresolved AST with getParsedUnit since it's synchronous.
  // Unfortunately it looks like there's no caching in the current implementation, so this will parse the file from
  // scratch. This isn't ideal, but shouldn't be too bad from a performance perspective.
  final result = session.getParsedUnit(factoryFileSource.fullName);
  if (result is! ParsedUnitResult) return null;

  //
  // Look up the factory and retrieve its return value.
  //

  final factoryDeclaration =
      NodeLocator2(factoryNameOffset, factoryNameOffset + factoryNameLength).searchWithin(result.unit);

  FunctionBody? factoryBody;
  if (factoryDeclaration is MethodDeclaration) {
    factoryBody = factoryDeclaration.body;
  } else if (factoryDeclaration is FunctionDeclaration) {
    factoryBody = factoryDeclaration.functionExpression.body;
  } else if (factoryDeclaration is VariableDeclaration) {
    factoryBody = factoryDeclaration.initializer?.unParenthesized.tryCast<FunctionExpression>()?.body;
  }
  if (factoryBody == null) return null;

  final returnValue = factoryBody.returnExpressions.singleOrNull;
  if (returnValue == null) return null;

  //
  // Return the props set on any returned builder
  //

  // Since it's a factory, we're returning a UiProps, so any cascaded properties on the return value
  // are most likely also be props being set.
  final cascadedProps = returnValue
      // Consumers often wrap in unnecessary parentheses, so make sure to strip these off.
      .unParenthesized
      .tryCast<CascadeExpression>()
      ?.cascadeSections
      .whereType<AssignmentExpression>()
      .where((assignment) => assignment.leftHandSide is PropertyAccess)
      .map(PropAssignment.new);

  return cascadedProps?.map((p) => p.name.name).toSet();
}
