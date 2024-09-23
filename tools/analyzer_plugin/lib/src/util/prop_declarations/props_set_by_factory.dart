import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

/// Returns the static element for an over_react factory referenced by [factoryReference].
///
/// In this context, "factory" refers to the target of the first invocation in an over_react component usage.
/// For example, `Foo` in `(Foo()..id = 'id')()`, or `someFactory` in `someFactory()()`.
Element? getFactoryElement(Expression factoryReference) {
  factoryReference = factoryReference.unParenthesized;
  if (factoryReference is Identifier) return factoryReference.staticElement;
  if (factoryReference is PropertyAccess) return factoryReference.propertyName.staticElement;

  return null;
}

/// Returns a list of prop names that are assigned in the cascaded return of [factoryElement],
/// by looking up at parsing the unresolved AST for the containing file.
///
/// For example, given this code:
/// ```dart
/// FooProps myFactory() => Foo()
///   ..requiredProp1 = '1'
///   ..aria.label = '1';
/// ```
/// Calling `getPropsSetByFactory` on the `myFactory` element would return `{'requiredProp1', 'aria.label'}`.
///
/// Any prefixed props include the prefix, as shown in the above example.
///
/// This function currently only operates on simple return values.
///
/// Supported declarations for [factoryElement]:
/// - function variables (top-level, class field, or local variable) or their synthetic getters/setters
/// - function declarations (top level or local)
/// - class methods
Set<String>? getPropsSetByFactory(Element factoryElement) {
  // Normalize synthetic getters to the non-synthetic field that declares them,
  // otherwise `nameOffset` will be `-1` below.
  if (factoryElement.isSynthetic) {
    factoryElement = factoryElement.nonSynthetic;
  }

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

  return cascadedProps?.map((p) {
    final prefix = p.prefix;
    return <String>[
      if (prefix != null) prefix.name,
      p.name.name,
    ].join('.');
  }).toSet();
}
