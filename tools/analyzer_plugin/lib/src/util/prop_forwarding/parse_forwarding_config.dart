import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

import 'forwarding_config.dart';
import 'util.dart';

/// Returns a forwarding config parsed/resolved from arguments to `.getPropsToForward` or `addPropsToForward`.
///
/// Returns null if the forwarded props could not be resolved.
///
/// Parses:
///
///     ..addProps(props.getPropsToForward())
///     ..addProps(props.getPropsToForward(exclude: {...}))
///     ..modifyProps(props.addPropsToForward(exclude: {...}))
PropForwardingConfig? parsePropsToForwardMethodArgs(ArgumentList argumentList, InterfaceElement propsType) {
  final excludeArg = argumentList.arguments
      .whereType<NamedExpression>()
      .firstWhereOrNull((a) => a.name.label.name == 'exclude')
      ?.expression;

  // With no exclude, the default is the props in the current props type
  if (excludeArg == null || excludeArg is NullLiteral) {
    return PropForwardingConfig.allExceptFor({propsType});
  }

  // Not a literal we can statically analyze
  if (excludeArg is! SetOrMapLiteral || !excludeArg.isSet) {
    return null;
  }

  final excluded = _resolveInterfaceReferences(excludeArg.elements)?.toSet();
  if (excluded == null) return null;
  return PropForwardingConfig.allExceptFor(excluded);
}

/// Returns a forwarding config parsed/resolved from a [consumedProps] expression representing the set of
/// props mixins to exclude when forwarding, which is used by `UiProps.addUnconsumedProps` and also UiComponent's
/// `consumedProps` getter.
///
/// Returns null if the forwarded props could not be resolved.
///
/// Handles various different syntaxes (see comments in this method for examples).
PropForwardingConfig? parseConsumedProps(Expression consumedProps) {
  // Look up value of consumedProps stored into variables, which is very common in usage:
  //
  //    final consumedProps = props.staticMeta.forMixins({...});
  if (consumedProps is Identifier) {
    final staticElement = consumedProps.staticElement;
    if (staticElement == null) return null;

    final variableValue = lookUpVariable(staticElement, consumedProps.root)?.initializer;
    // Don't recurse for Identifiers, to prevent potential infinite loops;
    // this case should not be common so we're safe to ignore it.
    if (variableValue != null && variableValue is! Identifier) {
      return parseConsumedProps(variableValue);
    }

    return null;
  }

  // We could validate the target of this call, but these methods are specifically-named enough that false positives
  // are unlikely, and validating the target would require a bit of extra logic.
  //
  // This invocation will usually look like:
  // - `propsMeta.forMixins` - class component `propsMeta` getter
  // - `props.staticMeta.forMixins` - props class `staticMeta` getter:
  if (consumedProps is MethodInvocation) {
    if (consumedProps.methodName.name == 'forMixins') {
      final arg = consumedProps.argumentList.arguments.whereType<Expression>().firstOrNull;
      if (arg is SetOrMapLiteral) {
        final mixins = _resolveInterfaceReferences(arg.elements)?.toSet();
        if (mixins != null) {
          return PropForwardingConfig.allExceptFor(mixins);
        }
      }
      return null;
    } else if (consumedProps.methodName.name == 'allExceptForMixins') {
      final arg = consumedProps.argumentList.arguments.whereType<Expression>().firstOrNull;
      if (arg is SetOrMapLiteral) {
        final mixins = _resolveInterfaceReferences(arg.elements)?.toSet();
        if (mixins != null) {
          return PropForwardingConfig.only(mixins);
        }
      }
      return null;
    }
  }

  final consumedPropElements =
      consumedProps.tryCast<ListLiteral>()?.elements ?? consumedProps.tryCast<SetOrMapLiteral>()?.elements;
  if (consumedPropElements != null) {
    // get consumedProps => const [LightboxProps.meta]
    final excluded = <InterfaceElement>{};
    for (final consumedPropElement in consumedPropElements) {
      if (consumedPropElement is Expression) {
        final result = getSimpleTargetAndPropertyName(consumedPropElement, allowMethodInvocation: false);
        if (result != null && result.item2.name == 'meta') {
          final propsClass = result.item1.staticElement.tryCast<InterfaceElement>();
          if (propsClass != null) {
            excluded.add(propsClass);
            continue;
          }
        }
      }
      // Short-circuit if we encounter any other cases.
      return null;
    }
    return PropForwardingConfig.allExceptFor(excluded);
  }

  return null;
}

/// Returns a forwarding config parsed/resolved from the `UiComponent.consumedProps` override in the component class
/// that encloses [node].
///
/// Returns null if the forwarded props could not be resolved.
PropForwardingConfig? parseEnclosingClassComponentConsumedProps(AstNode node) {
  final enclosingComponentPropsClass =
      getTypeOfPropsInEnclosingInterface(node)?.typeOrBound.element.tryCast<InterfaceElement>();
  if (enclosingComponentPropsClass == null) return null;

  final enclosingClass = node.thisOrAncestorOfType<ClassDeclaration>();
  final consumedPropsGetter =
      enclosingClass?.members.whereType<MethodDeclaration>().firstWhereOrNull((m) => m.name.lexeme == 'consumedProps');

  // The default is only props declared in enclosingComponentPropsClass for legacy boilerplate, and empty for non-legacy boilerplate.
  if (consumedPropsGetter == null) {
    final isLegacy = enclosingClass?.declaredElement?.isLegacyComponentClass ?? false;
    return isLegacy ? PropForwardingConfig.allExceptFor({enclosingComponentPropsClass}) : PropForwardingConfig.only({});
  }

  final consumedProps = consumedPropsGetter.body.returnExpressions.singleOrNull;
  if (consumedProps == null) return null;

  return parseConsumedProps(consumedProps);
}

/// Resolves AST [elements] representing references to interface types to the elements they reference.
///
/// Returns null if not all of the references could be resolved, or if if-elements or for-elements are used.
///
/// For example, given either the AST Node:
/// - `{SomeClass, SomeMixin}` (a [SetOrMapLiteral])
/// - `[SomeClass, SomeMixin]` (a [ListLiteral])
///
/// ...passing in these collection's `.elements` would yield a list containing the [ClassElement] representing `SomeClass`
/// and the [MixinElement] for SomeMixin.
List<InterfaceElement>? _resolveInterfaceReferences(List<CollectionElement> elements) {
  final interfaces = <InterfaceElement>[];
  for (final setElement in elements) {
    // Some other element or expression we can't statically analyze.
    // It seems like this should be a TypeLiteral,
    // but it seems to be a SimpleIdentifier.
    // Handle both cases in case it's sometimes one and sometimes the other.
    InterfaceElement? interface;
    if (setElement is Identifier) {
      interface = setElement.staticElement.tryCast();
    } else if (setElement is TypeLiteral) {
      interface = setElement.type.element.tryCast();
    }
    if (interface == null) return null;

    interfaces.add(interface);
  }
  return interfaces;
}
