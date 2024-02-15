import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

/// Returns whether [expression] definitely represents the props a component was rendered with,
/// as opposed to some other props object that could be a partial set of props.
///
/// Returns true if [expression] is either:
/// - the `props` argument in a function component
/// - the `props` getter in a component class
///   - accessed from within the component class (handles both `props` and `this.props`)
///   - accessed on a component instance (for example: `componentRef.props`)
bool isPropsFromRender(Expression expression) {
  if (expression is SimpleIdentifier) {
    final targetElement = expression.staticElement;
    if (targetElement == null) return false;

    // Class Component props with implicit `this`
    if (expression.name == 'props' && (targetElement.enclosingElement?.isComponentClass ?? false)) {
      return true;
    }

    // Function component props
    //
    // Technically only checking against the closest function components could have false negatives when there are
    // nested function components, but function components shouldn't ever be nested, so don't worry about that case.
    final closestFunctionComponentParameters = getClosestFunctionComponent(expression)?.functionExpression.parameters;
    if (closestFunctionComponentParameters != null) {
      final targetElementParameterNode = lookUpParameter(targetElement, closestFunctionComponentParameters);
      final parameterList = targetElementParameterNode?.parent;
      if (parameterList != null && closestFunctionComponentParameters == parameterList) {
        return true;
      }
    }

    return false;
  }

  // Class component: `this.props`, `componentVariable.props`, 'otherProperty.componentVariable.props`
  if (expression is PrefixedIdentifier) {
    return _isComponentPropsAccess(target: expression.prefix, property: expression.identifier);
  }
  if (expression is PropertyAccess) {
    return  _isComponentPropsAccess(target: expression.realTarget, property: expression.propertyName);
  }

  return false;
}

bool _isComponentPropsAccess({required Expression target, required Identifier property}) =>
    property.name == 'props' && (target.staticType?.typeOrBound.isComponentClass ?? false);
