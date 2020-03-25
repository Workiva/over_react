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
import 'package:meta/meta.dart';

import 'ast_util.dart';
import 'members.dart';
import 'util.dart';
import 'validation.dart';
import 'version.dart';

/// The possible declaration types that the builder will look for.
enum DeclarationType {
  propsMapViewOrFunctionComponentDeclaration,
  classComponentDeclaration,
  legacyClassComponentDeclaration,
  legacyAbstractPropsDeclaration,
  legacyAbstractStateDeclaration,
  propsMixinDeclaration,
  stateMixinDeclaration,
}

/// Parent class to all boilerplate declaration members.
abstract class BoilerplateDeclaration {
  /// The individual member version.
  ///
  /// __Note:__ this is an instantaneous evaluation of this member's version,
  /// and not the version of all related entities together. Consequently,
  /// this field should not be relied upon as the final say of what version
  /// the boilerplate is. Rather, [resolveVersion] should be used to detect that.
  final Version version;

  /// The explicit type of declaration this class is tied to.
  DeclarationType type;

  BoilerplateDeclaration(this.version);

  Iterable<BoilerplateMember> get members => _members;

  void validate(ErrorCollector errorCollector) {
    if (version == null) {
      // This should almost never happen.
      errorCollector.addError(
          'Could not determine boilerplate version.', errorCollector.spanFor(_members.first.node));
      return;
    }

    for (var member in _members) {
      member.validate(version, errorCollector);
    }
  }

  Iterable<BoilerplateMember> get _members;

  @override
  String toString() => '${super.toString()} (${_members.map((m) => m.name.name)})';
}

/// The component declaration wrapper for declarations that are not the mixin based boilerplate.
class LegacyClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final BoilerplateProps props;
  final BoilerplateState state;

  /// Whether this is Component2 based on the annotation or if the version
  /// is [Version.v4_mixinBased].
  bool get isComponent2 => component.isComponent2(version);

  @override
  get _members => [factory, component, props, if (state != null) state];

  @override
  get type => DeclarationType.legacyClassComponentDeclaration;

  LegacyClassComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);

  /// Validates that the proper annotations are present.
  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    if (!component.node.hasAnnotationWithNames({'Component', 'Component2'})) {
      errorCollector.addError(
          'Legacy boilerplate components must be annotated with `@Component()` or `@Component2()`.',
          errorCollector.spanFor(component.node));
    }

    if (!props.node.hasAnnotationWithNames({'Props'})) {
      errorCollector.addError('Legacy boilerplate props classes must be annotated with `@Props()`.',
          errorCollector.spanFor(props.node));
    }

    if (state != null && !state.node.hasAnnotationWithNames({'State'})) {
      errorCollector.addError('Legacy boilerplate state classes must be annotated with `@State()`.',
          errorCollector.spanFor(state.node));
    }
  }
}

/// The props declaration wrapper for abstract declarations that are not the mixin based boilerplate.
class LegacyAbstractPropsDeclaration extends BoilerplateDeclaration {
  final BoilerplateProps props;

  @override
  get _members => [props];

  @override
  get type => DeclarationType.legacyAbstractPropsDeclaration;

  LegacyAbstractPropsDeclaration({
    @required Version version,
    @required this.props,
  }) : super(version);

  /// Validates that if there are props that the props class has the correct annotation.
  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    // Only annotated nodes should make it in here.
    assert(props.node.hasAnnotationWithName('AbstractProps'));
  }
}

/// The state declaration wrapper for abstract declarations that are not the mixin based boilerplate.
class LegacyAbstractStateDeclaration extends BoilerplateDeclaration {
  final BoilerplateState state;

  @override
  get _members => [state];

  @override
  get type => DeclarationType.legacyAbstractStateDeclaration;

  LegacyAbstractStateDeclaration({
    @required Version version,
    @required this.state,
  }) : super(version);

  /// Validates that if there are state fields that the class has the correct annotation.
  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    // Only annotated nodes should make it in here.
    assert(state.node.hasAnnotationWithName('AbstractState'));
  }
}

/// The component declaration wrapper for declarations that are the mixin based boilerplate.
class ClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final Union<BoilerplateProps, BoilerplatePropsMixin> props;
  final Union<BoilerplateState, BoilerplateStateMixin> state;

  @override
  get _members => [factory, component, props.either, if (state != null) state?.either];

  @override
  get type => DeclarationType.classComponentDeclaration;

  /// All the props mixins related to this component declaration
  List<Identifier> get allPropsMixins => props.switchCase(
        (a) => a.nodeHelper.mixins.map((name) => name.name).toList(),
        (b) => [b.name],
  );

  ClassComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);
}

/// The declaration wrapper for either a props map view or function component,
/// which have almost identical syntax and code generation.
class PropsMapViewOrFunctionComponentDeclaration extends BoilerplateDeclaration {
  /// The related factory instance.
  final BoilerplateFactory factory;

  /// The related props instance.
  ///
  /// Can be either [BoilerplateProps] or [BoilerplatePropsMixin], but not both.
  final Union<BoilerplateProps, BoilerplatePropsMixin> props;

  @override
  get _members => [factory, props.either];

  @override
  get type => DeclarationType.propsMapViewOrFunctionComponentDeclaration;

  PropsMapViewOrFunctionComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.props,
  }) : super(version);
}

/// A wrapper for mixin based declarations.
mixin PropsOrStateMixinDeclaration on BoilerplateDeclaration {
  /// The corresponding mixin instance for the class.
  BoilerplatePropsOrStateMixin mixin;

  @override
  get _members => [mixin];
}

class PropsMixinDeclaration extends BoilerplateDeclaration with PropsOrStateMixinDeclaration {
  @override
  final BoilerplatePropsMixin mixin;

  @override
  get type => DeclarationType.propsMixinDeclaration;

  PropsMixinDeclaration({
    @required Version version,
    @required this.mixin,
  }) : super(version);
}

class StateMixinDeclaration extends BoilerplateDeclaration with PropsOrStateMixinDeclaration {
  @override
  final BoilerplateStateMixin mixin;

  @override
  get type => DeclarationType.stateMixinDeclaration;

  StateMixinDeclaration({
    @required Version version,
    @required this.mixin,
  }) : super(version);
}
