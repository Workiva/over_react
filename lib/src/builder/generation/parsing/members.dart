import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/builder/generation/parsing/ast_util.dart';
import 'package:over_react/src/builder/generation/parsing/util.dart';
import 'package:over_react/src/builder/generation/parsing/validation.dart';
import 'package:over_react/src/builder/generation/parsing/version.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/util/pretty_print.dart';
import 'package:over_react/src/util/string_util.dart';
import 'package:transformer_utils/transformer_utils.dart';

import '../../util.dart';

part 'members/component.dart';
part 'members/factory.dart';
part 'members/props_and_state.dart';

abstract class BoilerplateMember {
  final int declarationConfidence;

  BoilerplateMember(this.declarationConfidence);

  CompilationUnitMember get node;

  /// The confidence that, assuming that [node] has been correctly identified as this type of boilerplate member,
  /// it belongs to a boilerplate declaration of a given version.
  Map<BoilerplateVersion, int> get versionConfidence;
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector);

  toString() => '${super.toString()} ${prettyPrintMap(versionConfidence)}';
}

class BoilerplateMembers {
  final factories = <BoilerplateFactory>[];
  final props = <BoilerplateProps>[];
  final propsMixins = <BoilerplatePropsMixin>[];
  final components = <BoilerplateComponent>[];
  final states = <BoilerplateState>[];
  final stateMixins = <BoilerplateStateMixin>[];

  BoilerplateMembers.detect(CompilationUnit unit) {
    final visitor = BoilerplateMemberDetector()..members = this;
    unit.accept(visitor);
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

class BoilerplateMemberDetector extends SimpleAstVisitor<void> {
  BoilerplateMembers members;

  @override
  visitCompilationUnit(CompilationUnit node) {
    return node.visitChildren(this);
  }

  @override
  visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      members.factories.add(BoilerplateFactory(node, Confidence.high));
      return;
    }

    final type = node.variables.type;
    if (type != null) {
      if (type?.typeNameWithoutPrefix == 'UiFactory') {
        final firstVar = node.variables.variables.first;
        final name = firstVar.name.name;
        final identifierInInitializer = firstVar.initializer?.tryCast<Identifier>()?.nameWithoutPrefix;
        // Check for `Foo = _$Foo` or `Foo = $Foo` (which could be a typo)
        if (identifierInInitializer != null && (identifierInInitializer == '_\$$name' || identifierInInitializer == '\$$name')) {
          members.factories.add(BoilerplateFactory(node, Confidence.high));
        } else {
          members.factories.add(BoilerplateFactory(node, Confidence.medium));
        }
      }
    } else {
      // todo do we need something with function components?
//      if ((node.variables.firstInitializer?.tryCast<MethodInvocation>()?.methodName?.name == 'uiFunction') {
//        factories.add(BoilerplateFactory(node));
//      }
    }
  }

  void visitClassishDeclaration(NamedCompilationUnitMember node) {
    final annotationNames = node.metadata.map((m) => m.name.nameWithoutPrefix).toList();
    if (annotationNames.contains('Props')) {
      members.props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.high));
      return;
    }
    if (annotationNames.contains('State')) {
      members.props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.high));
      return;
    }
    if (annotationNames.contains('Component')) {
      members.components.add(BoilerplateComponent(ClassishDeclaration(node), Confidence.high));
      return;
    }

    final name = node.name.name;

    // todo start looking for other characteristics (superclasses, etc).
    // how to not get false positives for stuff that doesn't want codegen?
    if (name.endsWith('Props') || name.endsWith('PropsMapView')) {
      members.props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.medium));
      return;
    }
    if (name.endsWith('PropsMixin')) {
      members.propsMixins.add(BoilerplatePropsMixin(node, Confidence.medium));
      return;
    }
    if (name.endsWith('State')) {
      members.states.add(BoilerplateState(ClassishDeclaration(node), Confidence.medium));
      return;
    }
    if (name.endsWith('StateMixin')) {
      members.stateMixins.add(BoilerplateStateMixin(node, Confidence.medium));
      return;
    }
    if (name.endsWith('Component')) {
      members.components.add(BoilerplateComponent(ClassishDeclaration(node), Confidence.medium));
      return;
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) => visitClassishDeclaration(node);

  @override
  void visitClassTypeAlias(ClassTypeAlias node) => visitClassishDeclaration(node);

  @override
  void visitMixinDeclaration(MixinDeclaration node) => visitClassishDeclaration(node);
}
