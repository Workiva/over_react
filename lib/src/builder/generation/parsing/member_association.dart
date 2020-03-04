import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/generation/parsing/version.dart';

import 'ast_util.dart';
import 'members.dart';
import 'util.dart';

String normalizeName(String name) => name.replaceAll(RegExp(r'^[_$]+'), '');

String normalizeNameAndRemoveSuffix(BoilerplateMember member) {
  var name = normalizeName(member.name.name);
  if (member is BoilerplateComponent) {
    name = _normalizeBoilerplateComponentName(name);
  } else if (member is BoilerplateProps) {
    name = _normalizeBoilerplatePropsName(name);
  } else if (member is BoilerplatePropsMixin) {
    name = _normalizeBoilerplatePropsMixinName(name);
  } else if (member is BoilerplateState) {
    name = _normalizeBoilerplateStateName(name);
  } else if (member is BoilerplateStateMixin) {
    name = _normalizeBoilerplateStateMixinName(name);
  }
  return name;
}

String _normalizeBoilerplateComponentName(String name) => //
    name.replaceFirst(RegExp(r'Component$'), '');

String _normalizeBoilerplatePropsName(String name) => //
    name.replaceFirst(RegExp(r'Props$'), '');

String _normalizeBoilerplatePropsMixinName(String name) => //
    _normalizeBoilerplatePropsOrPropsMixinName(name);

String _normalizeBoilerplatePropsOrPropsMixinName(String name) => //
    name.replaceFirst(RegExp(r'Props(?:Mixin)?$'), '');

String _normalizeBoilerplateStateName(String name) => //
    name.replaceFirst(RegExp(r'State$'), '');

String _normalizeBoilerplateStateMixinName(String name) => //
    name.replaceFirst(RegExp(r'State(?:Mixin)?$'), '');

T _getNameMatch<T extends BoilerplateMember>(Iterable<T> members, String name) => members
    .firstWhere((member) => normalizeNameAndRemoveSuffix(member) == name, orElse: () => null);

Union<A, B> _getNameMatchUnion<A extends BoilerplateMember, B extends BoilerplateMember>(
    Iterable<A> membersA, Iterable<B> membersB, String name) {
  final a = _getNameMatch(membersA, name);
  if (a != null) return Union.a(a);

  final b = _getNameMatch(membersB, name);
  if (b != null) return Union.b(b);

  return null;
}

BoilerplateComponent getComponentFor(
  BoilerplateMember member,
  List<BoilerplateComponent> components, {
  bool findOtherInCompilationUnit = false,
}) {
  final match = _getNameMatch(components, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatch(components, name));
  if (match != null) return match;

  if (findOtherInCompilationUnit) {
    final componentNode = member.node
        .thisOrAncestorOfType<CompilationUnit>()
        .declarations
        .whereType<NamedCompilationUnitMember>()
        .where((m) => m is ClassOrMixinDeclaration || m is ClassTypeAlias)
        .map((m) => m.asClassish())
        .where(_detectComponent)
        .firstWhere((comp) {
      final propsGenericArgName = comp.superclass?.typeArguments?.arguments
          ?.firstWhere((arg) => arg.typeNameWithoutPrefix.contains('Props'), orElse: () => null)
          ?.typeNameWithoutPrefix;
      if (propsGenericArgName != null) {
        if (_normalizeBoilerplatePropsOrPropsMixinName(propsGenericArgName) ==
            normalizeNameAndRemoveSuffix(member)) {
          return true;
        }
      }

      return false;
    }, orElse: () => null);

    if (componentNode != null) {
      return BoilerplateComponent(componentNode, {
        for (final version in BoilerplateVersion.values) version: Confidence.medium,
      });
    }
  }

  return null;
}

bool _detectComponent(ClassishDeclaration classish) {
  // Don't detect react-dart components as boilerplate components, since they cause issues with grouping
  // if they're in the same file as an OverReact component with non-matching names.
  if (!const {'Component', 'Component2'}.contains(classish.superclass?.nameWithoutPrefix)) {
    int confidence = 0;
    if (classish.name.name.endsWith('Component')) {
      confidence += Confidence.medium;
    }
    if (classish.allSuperTypes.any((type) {
      final name = type.nameWithoutPrefix;
      return name == 'UiComponent' || name == 'UiComponent2';
    })) {
      confidence += Confidence.high;
    }

    // extending from an abstract component: `FooComponent extends BarComponent<FooProps, FooState>`
    if (classish.superclass?.typeArguments?.arguments
            ?.any((arg) => arg.typeNameWithoutPrefix.contains('Props')) ??
        false) {
      confidence += Confidence.medium;
    }

    if (confidence != 0) {
      return true;
    }
  }

  return false;
}

Union<BoilerplateProps, BoilerplatePropsMixin> getPropsFor(
  BoilerplateMember member,
  Iterable<BoilerplateProps> props,
  Iterable<BoilerplatePropsMixin> propsMixins,
) {
  return _getNameMatchUnion(props, propsMixins, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatchUnion(props, propsMixins, name));
}

Union<BoilerplateState, BoilerplateStateMixin> getStateFor(
  BoilerplateMember member,
  Iterable<BoilerplateState> states,
  Iterable<BoilerplateStateMixin> stateMixins,
) {
  return _getNameMatchUnion(states, stateMixins, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatchUnion(states, stateMixins, name));
}

String getRelatedName(BoilerplateMember member) {
  if (member is BoilerplateFactory) {
    return member.propsGenericArg?.typeNameWithoutPrefix
        ?.mapIfNotNull(_normalizeBoilerplatePropsOrPropsMixinName);
  }

  if (member is BoilerplateComponent) {
    return member.propsGenericArg?.typeNameWithoutPrefix
        ?.mapIfNotNull(_normalizeBoilerplatePropsOrPropsMixinName);
  }

  return null;
}

extension<T> on T {
  S mapIfNotNull<S>(S Function(T) callback) => this == null ? null : callback(this);
}
