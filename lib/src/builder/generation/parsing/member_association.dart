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

BoilerplateComponent getComponentFor(BoilerplateMember member, List<BoilerplateComponent> components) {
  final match = _getNameMatch(components, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatch(components, name));
  if (match != null) return match;

  // If there's no match by name, use the props generic parameter
  return components.firstWhere((comp) {
    final propsGenericArgName = comp.nodeHelper.superclass?.typeArguments?.arguments
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
