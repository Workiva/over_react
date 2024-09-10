import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/is_props_from_render.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_forwarding/parse_forwarding_config.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

import 'forwarding_config.dart';
import 'util.dart';

class ForwardedProps {
  final InterfaceElement propsClassBeingForwarded;
  final PropForwardingConfig forwardingConfig;
  final AstNode debugSourceNode;

  ForwardedProps(this.propsClassBeingForwarded, this.forwardingConfig, this.debugSourceNode);

  bool definitelyForwardsPropsFrom(InterfaceElement propsClass) {
    // Handle legacy classes being passed in.
    if (propsClass.name.startsWith(r'_$')) {
      // Look up the companion and use that instead, since that's what will be referenced in the forwarding config.
      // E.g., for `_$FooProps`, find `FooProps`, since consumers will be using `FooProps` when setting up prop forwarding.
      final companion = propsClassBeingForwarded.allSupertypes
          .map((s) => s.element)
          .whereType<ClassElement>()
          .singleWhereOrNull((c) => c.supertype?.element == propsClass && '_\$${c.name}' == propsClass.name);
      // If we can't find the companion, return false, since it won't show up in the forwarding config.
      if (companion == null) return false;
      propsClass = companion;
    }

    return !forwardingConfig.mightExcludeClass(propsClass) &&
        propsClassBeingForwarded.allSupertypes.any((s) => s.element == propsClass);
  }

  // TODO loop through props mixins and show the full list of props being forwarded for debug purposes
  @override
  String toString() => 'Props from ${propsClassBeingForwarded.name}: $forwardingConfig';
}

/// Computes and returns forwarded props for a given component [usage], or `null` if the usage does not receive any
/// forwarded props.
ForwardedProps? computeForwardedProps(FluentComponentUsage usage) {
  // Lazy variables for potentially expensive values that may get used in multiple loop iterations.
  late final enclosingComponentPropsClass =
      getTypeOfPropsInEnclosingInterface(usage.node)?.typeOrBound.element.tryCast<InterfaceElement>();
  late final enclosingComponentForwardedProps = parseEnclosingClassComponentConsumedProps(usage.node);

  for (final invocation in usage.cascadedMethodInvocations) {
    final methodName = invocation.methodName.name;
    final arg = invocation.node.argumentList.arguments.firstOrNull;

    // FIXME what should we do about the second condition arg for addProps?
    final isAddAllOrAddProps = methodName == 'addProps' || methodName == 'addAll';

    // ..addProps(props)
    if (isAddAllOrAddProps && arg != null && isPropsFromRender(arg)) {
      final propsType = arg.staticType?.typeOrBound.tryCast<InterfaceType>()?.element;
      if (propsType != null) {
        return ForwardedProps(propsType, PropForwardingConfig.all(), invocation.node);
      }
    } else if (
        // ..addProps(props.getPropsToForward(...))
        (isAddAllOrAddProps && arg is MethodInvocation && arg.methodName.name == 'getPropsToForward') ||
            // ..modifyProps(props.addPropsToForward(...))
            (methodName == 'modifyProps' && arg is MethodInvocation && arg.methodName.name == 'addPropsToForward')) {
      final realTarget = arg.realTarget;
      if (realTarget != null && isPropsFromRender(realTarget)) {
        final propsType = realTarget.staticType?.typeOrBound.tryCast<InterfaceType>()?.element;
        if (propsType != null) {
          return ForwardedProps(propsType, parsePropsToForwardMethodArgs(arg.argumentList, propsType), invocation.node);
        }
      }
    } else if (
        // ..addProps(copyUnconsumedProps())
        (isAddAllOrAddProps && arg is MethodInvocation && arg.methodName.name == 'copyUnconsumedProps') ||
            // ..modifyProps(addUnconsumedProps)
            (methodName == 'modifyProps' && arg is Identifier && arg.name == 'addUnconsumedProps')) {
      if (enclosingComponentPropsClass != null && enclosingComponentForwardedProps != null) {
        return ForwardedProps(enclosingComponentPropsClass, enclosingComponentForwardedProps, invocation.node);
      }
    } else if (
        // ..addUnconsumedProps(props, consumedProps)
        methodName == 'addUnconsumedProps') {
      final consumedPropsArg = invocation.node.argumentList.arguments.elementAtOrNull(1);
      if (arg != null && consumedPropsArg != null && isPropsFromRender(arg)) {
        final propsType = arg.staticType?.typeOrBound.tryCast<InterfaceType>()?.element;
        if (propsType != null) {
          return ForwardedProps(propsType, parseConsumedProps(consumedPropsArg), invocation.node);
        }
      }
    }
  }

  return null;
}
