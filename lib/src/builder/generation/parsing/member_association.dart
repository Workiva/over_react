import 'members.dart';
import 'util.dart';

String normalizeName(String name) => name.replaceAll(RegExp(r'^[_$]+'), '');
String normalizeNameAndRemoveSuffix(BoilerplateMember member) {
  var name = normalizeName(member.name.name);
  if (member is BoilerplateComponent) {
    name = name.replaceFirst(RegExp(r'Component$'), '');
  } else if (member is BoilerplateProps) {
    name = name.replaceFirst(RegExp(r'Props$'), '');
  } else if (member is BoilerplatePropsMixin) {
    name = name.replaceFirst(RegExp(r'Props(?:Mixin)?$'), '');
  } else if (member is BoilerplateState) {
    name = name.replaceFirst(RegExp(r'State$'), '');
  } else if (member is BoilerplateStateMixin) {
    name = name.replaceFirst(RegExp(r'State(?:Mixin)?$'), '');
  }
  return name;
}

T _getMemberWithMatchingName<T extends BoilerplateMember>(Iterable<T> members, String name) =>
    members.firstWhere((member) => normalizeNameAndRemoveSuffix(member) == name,
        orElse: () => null);

Union<A, B>
    _getMemberUnionWithMatchingName<A extends BoilerplateMember, B extends BoilerplateMember>(
        Iterable<A> membersA, Iterable<B> membersB, String name) {
  final a = _getMemberWithMatchingName(membersA, name);
  if (a != null) return Union.a(a);

  final b = _getMemberWithMatchingName(membersB, name);
  if (b != null) return Union.b(b);

  return null;
}

BoilerplateComponent getComponentFor(
  BoilerplateMember member,
  List<BoilerplateComponent> components,
) =>
    _getMemberWithMatchingName(components, normalizeNameAndRemoveSuffix(member));

Union<BoilerplateProps, BoilerplatePropsMixin> getPropsFor(
  BoilerplateMember member,
  Iterable<BoilerplateProps> props,
  Iterable<BoilerplatePropsMixin> propsMixins,
) =>
    _getMemberUnionWithMatchingName(props, propsMixins, normalizeNameAndRemoveSuffix(member));

Union<BoilerplateState, BoilerplateStateMixin> getStateFor(
  BoilerplateMember member,
  Iterable<BoilerplateState> states,
  Iterable<BoilerplateStateMixin> stateMixins,
) =>
    _getMemberUnionWithMatchingName(states, stateMixins, normalizeNameAndRemoveSuffix(member));
