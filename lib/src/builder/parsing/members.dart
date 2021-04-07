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
import 'package:over_react/src/builder/codegen/names.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/util/pretty_print.dart';
import 'package:over_react/src/util/string_util.dart';

import '../parsing.dart';
import '../util.dart';
import 'ast_util.dart';
import 'declarations.dart';
import 'members_from_ast.dart';
import 'meta.dart';
import 'error_collection.dart';
import 'version.dart';

part 'members/component.dart';
part 'members/factory.dart';
part 'members/props_and_state.dart';
part 'members/props_and_state_mixins.dart';
part 'members/props_and_state_util.dart';

/// Base class for a boilerplate "member"—a part of a [BoilerplateDeclaration]—that contains
/// references to the member's node and instantiated annotation, boilerplate version confidence
/// computed during detection, and validation logic for all potential versions.
///
/// For example: a component class, a factory variable, a props class, a props mixin, etc.
abstract class BoilerplateMember {
  BoilerplateMember(this.versionConfidences);

  /// For each boilerplate version, the confidence that, assuming that [node] has been correctly
  /// identified as this type of boilerplate member, it belongs to a boilerplate declaration of
  /// a given version.
  final VersionConfidences versionConfidences;

  /// The node backing the boilerplate member.
  CompilationUnitMember get node;

  /// Metadata around the member, which will most likely be [InstantiatedComponentMeta]
  /// or the corresponding annotation.
  Object get meta;

  /// Verifies notable elements of the member are implemented as expected for the
  /// given version.
  void validate(Version version, ErrorCollector errorCollector);

  SimpleIdentifier get name;

  @override
  String toString() => '$runtimeType: ${name.name}';

  String get debugString => '$this, confidence: $versionConfidences';
}

/// A member representing a typed map class: props/state classes and mixins.
///
/// See [BoilerplateMember] for more information.
abstract class BoilerplateTypedMapMember extends BoilerplateMember {
  BoilerplateTypedMapMember(VersionConfidences versionConfidence) : super(versionConfidence);

  @override
  NamedCompilationUnitMember get node;

  ClassishDeclaration get nodeHelper;

  @override
  annotations.TypedMap get meta;
}

/// A collection of all [BoilerplateMember]s within a given file.
///
/// See [detectBoilerplateMembers].
class BoilerplateMembers {
  final List<BoilerplateFactory> factories;
  final List<BoilerplateProps> props;
  final List<BoilerplatePropsMixin> propsMixins;
  final List<BoilerplateComponent> components;
  final List<BoilerplateState> states;
  final List<BoilerplateStateMixin> stateMixins;

  /// A flat list composed of all boilerplate members.
  Iterable<BoilerplateMember> get allMembers => allMembersLists.expand((i) => i);

  /// A nested list that keeps different member types separate while being grouped
  /// in one iterable.
  List<List<BoilerplateMember>> get allMembersLists => [
        factories,
        props,
        propsMixins,
        components,
        states,
        stateMixins,
      ];

  /// Whether or not all of the member lists are empty.
  bool get isEmpty => allMembersLists.every((list) => list.isEmpty);

  /// Whether or not at least a single list of members has a member.
  bool get isNotEmpty => !isEmpty;

  @protected
  BoilerplateMembers({
    this.factories,
    this.props,
    this.propsMixins,
    this.components,
    this.states,
    this.stateMixins,
  });

  @override
  toString() => 'BoilerplateMembers:${prettyPrintMap(<String, Iterable>{
        'factories': factories,
        'props': props,
        'propsMixins': propsMixins,
        'components': components,
        'states': states,
        'stateMixins': stateMixins,
      }..removeWhere((_, value) => value.isEmpty))}';
}
