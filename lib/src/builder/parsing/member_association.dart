// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analyzer/dart/ast/ast.dart';

import 'ast_util.dart';
import 'members.dart';
import 'util.dart';

/// Removes the generated prefix from anywhere inside of [name].
String normalizeName(String name) => name.replaceAll(RegExp(r'^[_$]+'), '');

/// Strips the name of any prefix and suffix to return the actual name of the component.
///
/// Before          After
/// ------------    -----
/// _$FooProps      Foo
/// FooComponent    Foo
/// _$FooState      Foo
/// FooStateMixin   Foo
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

Union<A, B> getUnion<A extends BoilerplateMember, B extends BoilerplateMember>(
    BoilerplateMember member) {
  if (member is A) return Union.a(member);

  if (member is B) return Union.b(member);

  return null;
}

/// Retrieves the component for a given [member] if it is found in [components].
///
/// This first tries to normalize the names of the entities to find a matching name,
/// and if that fails it tries to look at the props class name to get a match.
BoilerplateComponent getComponentFor(
    BoilerplateMember member, List<BoilerplateComponent> components) {
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

/// Retrieves the props for a given [member] if it is found in [props] or [propsMixins].
///
/// This is done purely off of matching the name of the member class against the props
/// classes.
Union<BoilerplateProps, BoilerplatePropsMixin> getPropsFor(
  BoilerplateMember member,
  Iterable<BoilerplateProps> props,
  Iterable<BoilerplatePropsMixin> propsMixins,
) {
  return _getNameMatchUnion(props, propsMixins, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatchUnion(props, propsMixins, name));
}

/// ADD DOC COMMENT IF KEPT
String getPropsNameFromFunctionComponent(BoilerplateFactory factory) {
  if (factory.propsGenericArg != null) {
    return factory.propsGenericArg.typeNameWithoutPrefix;
  }
  final rightHandSide = factory.node.variables.firstInitializer;
  assert(rightHandSide != null && rightHandSide is MethodInvocation);
  final typeArgs = (rightHandSide as MethodInvocation).typeArguments?.arguments?.firstOrNull;
  return typeArgs?.typeNameWithoutPrefix;
}

/// ADD DOC COMMENT IF KEPT
bool hasConfigArg(BoilerplateFactory factory) {
  final rightHandSide = factory.node.variables.firstInitializer;
  final args = (rightHandSide as MethodInvocation).argumentList.arguments;
  if (args == null || args.length < 2) return false;
  return args[1] is! NullLiteral;
}

/// Retrieves the props for a given [member] if it is found in [states] or [stateMixins].
///
/// This is done purely off of matching the name of the member class against the props
/// classes.
Union<BoilerplateState, BoilerplateStateMixin> getStateFor(
  BoilerplateMember member,
  Iterable<BoilerplateState> states,
  Iterable<BoilerplateStateMixin> stateMixins,
) {
  return _getNameMatchUnion(states, stateMixins, normalizeNameAndRemoveSuffix(member)) ??
      getRelatedName(member).mapIfNotNull((name) => _getNameMatchUnion(states, stateMixins, name));
}

/// Attempts to find the member related to [member] and returns its name.
///
/// Currently, related names are only returned for factories/components
/// based on their props generic parameter; in the future this could be expanded.
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
