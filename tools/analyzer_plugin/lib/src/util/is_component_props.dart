import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

bool isComponentProps(Expression expression) {
  if (expression is SimpleIdentifier) {
    final targetElement = expression.staticElement;
    if (targetElement == null) return false;

    // Class Component props with implicit `this`
    if (expression.name == 'props' && (targetElement.enclosingElement?.isComponentClass ?? false)) {
      return true;
    }

    // Function component props
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
    final target = expression.target;
    return target != null && _isComponentPropsAccess(target: target, property: expression.propertyName);
  }

  return false;
}

bool _isComponentPropsAccess({required Expression target, required Identifier property}) =>
    property.name == 'props' && (target.staticType?.typeOrBound.isComponentClass ?? false);
