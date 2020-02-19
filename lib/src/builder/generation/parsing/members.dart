import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react/src/builder/generation/parsing/ast_util.dart';
import 'package:over_react/src/builder/generation/parsing/util.dart';
import 'package:over_react/src/builder/generation/parsing/version.dart';
import 'package:source_span/source_span.dart';

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
}

abstract class ValidationErrorCollector {
  SourceFile get _sourceFile;

  void addError(String message, [SourceSpan span]);

  FileSpan spanFor(SyntacticEntity nodeOrToken) => _sourceFile.spanFor(nodeOrToken);
  FileSpan span(int start, [int end]) => _sourceFile.span(start, end);
}

mixin BoilerplateMembers {
  final factories = <BoilerplateFactory>[];
  final props = <BoilerplateProps>[];
  final propsMixins = <BoilerplatePropsMixin>[];
  final components = <BoilerplateComponent>[];
  final states = <BoilerplateState>[];
  final stateMixins = <BoilerplateStateMixin>[];
}

class BoilerplateMemberDetector extends SimpleAstVisitor<void> with BoilerplateMembers {
  @override
  visitCompilationUnit(CompilationUnit node) {
    return node.visitChildren(this);
  }

  @override
  visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      factories.add(BoilerplateFactory(node, Confidence.high));
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
          factories.add(BoilerplateFactory(node, Confidence.high));
        } else {
          factories.add(BoilerplateFactory(node, Confidence.medium));
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
      props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.high));
      return;
    }
    if (annotationNames.contains('State')) {
      props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.high));
      return;
    }
    if (annotationNames.contains('Component')) {
      components.add(BoilerplateComponent(ClassishDeclaration(node), Confidence.high));
      return;
    }

    final name = node.name.name;

    // todo start looking for other characteristics (superclasses, etc).
    // how to not get false positives for stuff that doesn't want codegen?
    if (name.endsWith('Props') || name.endsWith('PropsMapView')) {
      props.add(BoilerplateProps(ClassishDeclaration(node), Confidence.medium));
      return;
    }
    if (name.endsWith('PropsMixin')) {
      propsMixins.add(BoilerplatePropsMixin(node, Confidence.medium));
      return;
    }
    if (name.endsWith('State')) {
      states.add(BoilerplateState(ClassishDeclaration(node), Confidence.medium));
      return;
    }
    if (name.endsWith('StateMixin')) {
      stateMixins.add(BoilerplateStateMixin(node, Confidence.medium));
      return;
    }
    if (name.endsWith('Component')) {
      components.add(BoilerplateComponent(ClassishDeclaration(node), Confidence.medium));
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
