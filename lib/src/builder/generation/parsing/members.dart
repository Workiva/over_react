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

abstract class BoilerplateMember {
  /// The confidence that, assuming that [node] has been correctly identified as this type of boilerplate member,
  /// it belongs to a boilerplate declaration of a given version.
  final VersionConfidence versionConfidence;

  BoilerplateMember(this.versionConfidence) : assert(versionConfidence != null);

  CompilationUnitMember get node;

  void validate(Version version, ErrorCollector errorCollector);

  SimpleIdentifier get name;

  @override
  String toString() => '${super.toString()} (${name.name}) ${versionConfidence}';

  String get debugString {
    return '${runtimeType.toString()}; confidence:$versionConfidence';
  }
}

class BoilerplateMembers {
  final factories = <BoilerplateFactory>[];
  final props = <BoilerplateProps>[];
  final propsMixins = <BoilerplatePropsMixin>[];
  final components = <BoilerplateComponent>[];
  final states = <BoilerplateState>[];
  final stateMixins = <BoilerplateStateMixin>[];

  Iterable<BoilerplateMember> get allMembers => allMembersLists.expand((i) => i);
  List<List<BoilerplateMember>> get allMembersLists => [
        factories,
        props,
        propsMixins,
        components,
        states,
        stateMixins,
      ];

  bool get isEmpty => allMembersLists.every((list) => list.isEmpty);
  bool get isNotEmpty => !isEmpty;

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

  toString() => 'BoilerplateMembers:${prettyPrintMap({
        'factories': factories,
        'props': props,
        'propsMixins': propsMixins,
        'components': components,
        'states': states,
        'stateMixins': stateMixins,
      }..removeWhere((_, value) => value.isEmpty))}';
}
