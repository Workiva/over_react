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
import 'package:over_react/src/builder/generation/parsing/meta.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/util/pretty_print.dart';
import 'package:over_react/src/util/string_util.dart';

import '../../util.dart';
import 'ast_util.dart';
import 'member_detection.dart';
import 'util.dart';
import 'validation.dart';
import 'version.dart';

part 'members/component.dart';
part 'members/factory.dart';
part 'members/props_and_state.dart';
part 'members/props_and_state_mixins.dart';
part 'members/props_and_state_util.dart';

/// The parent class for all boilerplate members
abstract class BoilerplateMember {

  BoilerplateMember(this.versionConfidence);

  /// The confidence that, assuming that [node] has been correctly identified as this type of boilerplate member,
  /// it belongs to a boilerplate declaration of a given version.
  final VersionConfidence versionConfidence;

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
  String toString() => '${super.toString()} (${name.name}) $versionConfidence';

  String get debugString {
    return '${runtimeType.toString()}; confidence:$versionConfidence';
  }
}

/// The member class that wraps data for legacy boilerplate's accessor class.
abstract class BoilerplateAccessorsMember extends BoilerplateMember {
  BoilerplateAccessorsMember(VersionConfidence versionConfidence) : super(versionConfidence);

  @override
  NamedCompilationUnitMember get node;

  ClassishDeclaration get nodeHelper;

  @override
  annotations.TypedMap get meta;
}

/// A class that wraps the primary member types in order to group detected members.
///
/// Can be used to easily grab members from an input entity by using the
/// [BoilerplateMembers.detect] constructor.
class BoilerplateMembers {
  final factories = <BoilerplateFactory>[];
  final props = <BoilerplateProps>[];
  final propsMixins = <BoilerplatePropsMixin>[];
  final components = <BoilerplateComponent>[];
  final states = <BoilerplateState>[];
  final stateMixins = <BoilerplateStateMixin>[];

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

  /// Constructs this by visiting relevant entities in [unit] and adding
  /// found members to the relevant local list.
  BoilerplateMembers.detect(CompilationUnit unit) {
    BoilerplateMemberDetector(
      onFactory: factories.add,
      onProps: props.add,
      onPropsMixin: propsMixins.add,
      onComponent: components.add,
      onState: states.add,
      onStateMixin: stateMixins.add,
    ).detect(unit);
  }

  @override
  toString() => 'BoilerplateMembers:${prettyPrintMap({
        'factories': factories,
        'props': props,
        'propsMixins': propsMixins,
        'components': components,
        'states': states,
        'stateMixins': stateMixins,
      }..removeWhere((_, value) => value.isEmpty))}';
}
