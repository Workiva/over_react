import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/is_props_from_render.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

ForwardedProps? getForwardedProps(FluentComponentUsage usage, TypeSystem typeSystem) {
  late final enclosingComponentPropsClass =
      getTypeOfPropsInEnclosingInterface(usage.node)?.typeOrBound.element.tryCast<InterfaceElement>();
  late final enclosingComponentForwardedProps = _getForwardedPropsFromEnclosingInterface(usage.node);

  for (final invocation in usage.cascadedMethodInvocations) {
    final methodName = invocation.methodName.name;
    final arg = invocation.node.argumentList.arguments.firstOrNull;

    if (methodName == 'addProps' && arg != null && isPropsFromRender(arg)) {
      final propsType = arg.staticType?.typeOrBound.tryCast<InterfaceType>()?.element;
      if (propsType != null) {
        return ForwardedProps(propsType, PropsToForward.all(), invocation.node);
      }
    } else if ((methodName == 'addProps' && arg is MethodInvocation && arg.methodName.name == 'getPropsToForward') ||
        (methodName == 'modifyProps' && arg is MethodInvocation && arg.methodName.name == 'addPropsToForward')) {
      final realTarget = arg.realTarget;
      if (realTarget != null && isPropsFromRender(realTarget)) {
        final propsType = realTarget.staticType?.typeOrBound.tryCast<InterfaceType>()?.element;
        if (propsType != null) {
          return ForwardedProps(propsType, _parseGetPropsToForward(arg.argumentList, propsType), invocation.node);
        }
      }
    } else if ((methodName == 'addProps' && arg is MethodInvocation && arg.methodName.name == 'copyUnconsumedProps') ||
        (methodName == 'modifyProps' && arg is Identifier && arg.name == 'addUnconsumedProps')) {
      if (enclosingComponentPropsClass != null && enclosingComponentForwardedProps != null) {
        return ForwardedProps(enclosingComponentPropsClass, enclosingComponentForwardedProps, invocation.node);
      }
    }
  }

  return null;
}

class ForwardedProps {
  final InterfaceElement propsClassBeingForwarded;
  final PropsToForward propsToForward;
  final AstNode debugSourceNode;

  ForwardedProps(this.propsClassBeingForwarded, this.propsToForward, this.debugSourceNode);

  bool definitelyForwardsPropsFrom(InterfaceElement propsClass, TypeSystem typeSystem) =>
      !propsToForward.mightExcludeClass(propsClass) &&
      propsClassBeingForwarded.allSupertypes.any((s) => s.element == propsClass);

  // TODO loop through props mixins and show the full list of props being forwarded for debug purposes
  @override
  String toString() => 'Props from ${propsClassBeingForwarded.name}: $propsToForward';
}

class PropsToForward {
  final Set<InterfaceElement>? _onlyProps;
  final Set<InterfaceElement>? _excludedProps;

  const PropsToForward.all()
      : _excludedProps = const {},
        _onlyProps = null;

  const PropsToForward.allExceptFor(Set<InterfaceElement> this._excludedProps) : _onlyProps = null;

  const PropsToForward.only(Set<InterfaceElement> this._onlyProps) : _excludedProps = null;

  const PropsToForward.unresolved()
      : _excludedProps = null,
        _onlyProps = null;

  bool mightExcludeClass(InterfaceElement e) {
    final _excludedProps = this._excludedProps;
    final _onlyProps = this._onlyProps;

    assert(_excludedProps == null || _onlyProps == null);

    if (_excludedProps != null) return _excludedProps.contains(e);
    if (_onlyProps != null) return !_onlyProps.contains(e);
    return true;
  }

  @override
  String toString() {
    final _excludedProps = this._excludedProps;
    final _onlyProps = this._onlyProps;

    assert(_excludedProps == null || _onlyProps == null);

    String format(Set<InterfaceElement> set) => set.map((e) => e.name).toSet().toString();

    if (_excludedProps != null) return _excludedProps.isEmpty ? 'all' : 'all except ${format(_excludedProps)}';
    if (_onlyProps != null) return 'only ${format(_onlyProps)}';
    return 'unresolved';
  }
}

PropsToForward _parseGetPropsToForward(ArgumentList argumentList, InterfaceElement propsType) {
  final excludeArg = argumentList.arguments
      .whereType<NamedExpression>()
      .firstWhereOrNull((a) => a.name.label.name == 'exclude')
      ?.expression;

  // With no exclude, the default is the props in the current props type
  if (excludeArg == null || excludeArg is NullLiteral) {
    return PropsToForward.allExceptFor({propsType});
  }

  // Not a literal we can statically analyze
  if (excludeArg is! SetOrMapLiteral || !excludeArg.isSet) {
    return const PropsToForward.unresolved();
  }

  final excluded = lookUpInterfaces(excludeArg.elements)?.toSet();
  if (excluded == null) return const PropsToForward.unresolved();
  return PropsToForward.allExceptFor(excluded);
}

List<InterfaceElement>? lookUpInterfaces(List<CollectionElement> elements) {
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

PropsToForward _getForwardedPropsFromConsumedProps(Expression consumedProps) {
  if (consumedProps is MethodInvocation && consumedProps.realTarget.tryCast<Identifier>()?.name == 'propsMeta') {
    // propsMeta.forMixins({FluxUiPropsMixin});
    if (consumedProps.methodName.name == 'forMixins') {
      final arg = consumedProps.argumentList.arguments.whereType<Expression>().firstOrNull;
      if (arg is SetOrMapLiteral) {
        final mixins = lookUpInterfaces(arg.elements)?.toSet();
        if (mixins != null) {
          return PropsToForward.allExceptFor(mixins);
        }
      }
      return PropsToForward.unresolved();
    } else if (consumedProps.methodName.name == 'allExceptForMixins') {
      final arg = consumedProps.argumentList.arguments.whereType<Expression>().firstOrNull;
      if (arg is SetOrMapLiteral) {
        final mixins = lookUpInterfaces(arg.elements)?.toSet();
        if (mixins != null) {
          // FIXME this also includes props not in this props class; how to represent that clearnly
          return PropsToForward.only(mixins);
        }
      }
      return PropsToForward.unresolved();
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
        if (result != null && result.item2.name != 'meta') {
          final propsClass = result.item1.staticElement.tryCast<InterfaceElement>();
          if (propsClass != null) {
            excluded.add(propsClass);
            continue;
          }
        }
      }
      // Short-circuit if we encounter any other cases.
      return const PropsToForward.unresolved();
    }
    return PropsToForward.allExceptFor(excluded);
  }

  return PropsToForward.unresolved();
}

PropsToForward? _getForwardedPropsFromEnclosingInterface(AstNode node) {
  final enclosingComponentPropsClass =
      getTypeOfPropsInEnclosingInterface(node)?.typeOrBound.element.tryCast<InterfaceElement>();
  if (enclosingComponentPropsClass == null) return null;

  final enclosingClass = node.thisOrAncestorOfType<ClassDeclaration>();
  final consumedPropsGetter =
      enclosingClass?.members.whereType<MethodDeclaration>().firstWhereOrNull((m) => m.name.lexeme == 'consumedProps');

  // FIXME double check this behavior.
  // The default is only props declared in enclosingComponentPropsClass for legacy boilerplate, and empty for non-legacy boilerplate.
  if (consumedPropsGetter == null) {
    // FIXME implement conditionally for legacy boilerplate
    // ignore: prefer_const_declarations
    final isLegacy = false;
    // ignore: dead_code
    return isLegacy ? PropsToForward.allExceptFor({enclosingComponentPropsClass}) : PropsToForward.only({});
  }

  final consumedProps = consumedPropsGetter.body.returnExpressions.singleOrNull;
  if (consumedProps == null) {
    return PropsToForward.unresolved();
  }

  return _getForwardedPropsFromConsumedProps(consumedProps);
}

DartType? getTypeOfPropsInEnclosingInterface(AstNode node) {
  final enclosingInterface = getEnclosingInterface(node);
  if (enclosingInterface == null) return null;

  return enclosingInterface.thisType.lookUpGetter2('props', enclosingInterface.library)?.returnType;
}

InterfaceElement? getEnclosingInterface(AstNode node) {
  for (final ancestor in node.ancestors) {
    if (ancestor is ClassDeclaration) return ancestor.declaredElement;
    if (ancestor is MixinDeclaration) return ancestor.declaredElement;
    if (ancestor is ExtensionDeclaration) {
      return ancestor.declaredElement?.extendedType.typeOrBound.tryCast<InterfaceType>()?.element;
    }
  }
  return null;
}
