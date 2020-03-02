import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../util.dart';
import 'ast_util.dart';
import 'members.dart';
import 'util.dart';
import 'version.dart';

class BoilerplateMemberDetector {
  BoilerplateMembers members;
  Map<String, NamedCompilationUnitMember> _classishDeclarationsByName = {};

  void detect(CompilationUnit unit) {
    final visitor = _BoilerplateMemberDetectorVisitor(
      onClassishDeclaration: (node) => _classishDeclarationsByName[node.name.name] = node,
      onTopLevelVariableDeclaration: _processTopLevelVariableDeclaration,
    );

    unit.accept(visitor);

    _classishDeclarationsByName.values.forEach(_processClassishDeclaration);
  }

  void _processTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    _detectFactory(node);
  }

  void _processClassishDeclaration(NamedCompilationUnitMember node) {
    // If this is a companion class, ignore it.
    final sourceClass = _getSourceClassForPotentialCompanion(node);
    if (sourceClass != null) return;

    if (_isMixinStub(node)) return;

    final classish = node.asClassish();
    final companion = _getCompanionClass(node)?.asClassish();

    if (_detectBasedOnAnnotations(classish, companion: companion)) return;
    if (_detectPropsStateAndMixins(classish, companion: companion)) return;
    if (_detectComponent(classish)) return;
  }

  //
  // _processTopLevelVariableDeclaration helpers
  //

  void _detectFactory(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      members.factories.add(BoilerplateFactory(node, Confidence.high));
      return;
    }

    final type = node.variables.type;
    if (type != null) {
      if (type?.typeNameWithoutPrefix == 'UiFactory') {
        final firstVar = node.variables.variables.first;
        final name = firstVar.name.name;
        final identifierInInitializer =
            firstVar.initializer?.tryCast<Identifier>()?.nameWithoutPrefix;
        // Check for `Foo = _$Foo` or `Foo = $Foo` (which could be a typo)
        if (identifierInInitializer != null &&
            (identifierInInitializer == '_\$$name' || identifierInInitializer == '\$$name')) {
          members.factories.add(BoilerplateFactory(node, Confidence.high));
          return;
        } else {
          members.factories.add(BoilerplateFactory(node, Confidence.medium));
          return;
        }
      }
    } else {
      // todo do we need something with function components?
//      if ((node.variables.firstInitializer?.tryCast<MethodInvocation>()?.methodName?.name == 'uiFunction') {
//        factories.add(BoilerplateFactory(node));
//      }
    }

    return;
  }

  //
  // _processClassishDeclaration helpers
  //

  /// For `FooProps`, returns `_$FooProps`
  NamedCompilationUnitMember _getSourceClassForPotentialCompanion(NamedCompilationUnitMember node) {
    final name = node.name.name;
    if (name.startsWith(privateSourcePrefix)) {
      return null;
    }
    final sourceName = '$privateSourcePrefix$name';
    return _classishDeclarationsByName[sourceName];
  }

  /// For `_$FooProps`, returns `FooProps`
  NamedCompilationUnitMember _getCompanionClass(NamedCompilationUnitMember node) {
    final name = node.name.name;
    if (!name.startsWith(privateSourcePrefix)) {
      return null;
    }
    final sourceName = name.replaceFirst(privateSourcePrefix, '');
    return _classishDeclarationsByName[sourceName];
  }

  /// Returns whether it's the `$FooPropsMixin` to a `_$FooPropsMixin`
  bool _isMixinStub(NamedCompilationUnitMember node) {
    final name = node.name.name;
    return name.startsWith(r'$') && _classishDeclarationsByName.containsKey('_$name');
  }

  bool _detectBasedOnAnnotations(ClassishDeclaration classish, {ClassishDeclaration companion}) {
    for (final annotation in classish.metadata) {
      switch (annotation.name.nameWithoutPrefix) {
        case 'Props':
        case 'AbstractProps':
          members.props.add(BoilerplateProps(classish, Confidence.high, companion: companion));
          return true;
        case 'PropsMixin':
          members.propsMixins
              .add(BoilerplatePropsMixin(classish.node, Confidence.high, companion: companion));
          return true;
        case 'State':
        case 'AbstractState':
          members.states.add(BoilerplateState(classish, Confidence.high, companion: companion));
          return true;
        case 'StateMixin':
          members.stateMixins
              .add(BoilerplateStateMixin(classish.node, Confidence.high, companion: companion));
          return true;
        case 'Component':
        case 'Component2':
        case 'AbstractComponent':
        case 'AbstractComponent2':
          members.components.add(BoilerplateComponent(classish, Confidence.high));
          return true;
      }
    }

    return false;
  }

  bool _detectPropsStateAndMixins(ClassishDeclaration classish, {ClassishDeclaration companion}) {
    final name = classish.name.name;
    final node = classish.node;

    var looksLikeMixin = false;
    if (node is MixinDeclaration) {
      looksLikeMixin = true;
    } else if (classish.hasAbstractKeyword && classish.mixins.isEmpty) {
      final superclassName = classish.superclass?.nameWithoutPrefix;
      if (superclassName == null || superclassName == 'Object') {
        looksLikeMixin = true;
      }
    }

    // Prioritize categorize PropsMixins before Props // todo better comment
    if (looksLikeMixin) {
      if (name.endsWith('Props') || name.endsWith('PropsMixin')) {
        members.propsMixins
            .add(BoilerplatePropsMixin(node, Confidence.medium, companion: companion));
        return true;
      }
      if (name.endsWith('State') || name.endsWith('StateMixin')) {
        members.stateMixins
            .add(BoilerplateStateMixin(node, Confidence.medium, companion: companion));
        return true;
      }
    } else {
      // todo start looking for other characteristics (superclasses, etc).
      // how to not get false positives for stuff that doesn't want codegen?
      if (name.endsWith('Props') || name.endsWith('PropsMapView')) {
        members.props.add(BoilerplateProps(classish, Confidence.medium, companion: companion));
        return true;
      }
      if (name.endsWith('State')) {
        members.states.add(BoilerplateState(classish, Confidence.medium, companion: companion));
        return true;
      }
    }

    return false;
  }

  bool _detectComponent(ClassishDeclaration classish) {
    // todo optimize
    final allSuperTypes = [
      ...classish.interfaces,
      ...classish.mixins,
      if (classish.superclass != null) classish.superclass,
    ];

    // Don't detect react-dart components as boilerplate components, since they cause issues with grouping
    // if they're in the same file as an OverReact component with non-matching names.
    if (!const {'Component', 'Component2'}.contains(classish.superclass?.nameWithoutPrefix)) {
      int confidence = 0;
      if (classish.name.name.endsWith('Component')) {
        confidence += Confidence.medium;
      }
      if (allSuperTypes.any((type) {
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
        members.components.add(BoilerplateComponent(classish, confidence));
        return true;
      }
    }

    return false;
  }
}

class _BoilerplateMemberDetectorVisitor extends SimpleAstVisitor<void> {
  final void Function(NamedCompilationUnitMember) onClassishDeclaration;
  final void Function(TopLevelVariableDeclaration) onTopLevelVariableDeclaration;

  _BoilerplateMemberDetectorVisitor(
      {this.onClassishDeclaration, this.onTopLevelVariableDeclaration});

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    onTopLevelVariableDeclaration(node);
  }

  void visitClassishDeclaration(NamedCompilationUnitMember node) {
    onClassishDeclaration(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) => visitClassishDeclaration(node);

  @override
  void visitClassTypeAlias(ClassTypeAlias node) => visitClassishDeclaration(node);

  @override
  void visitMixinDeclaration(MixinDeclaration node) => visitClassishDeclaration(node);
}
