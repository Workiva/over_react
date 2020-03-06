import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';

import '../../util.dart';
import 'ast_util.dart';
import 'members.dart';
import 'util.dart';
import 'version.dart';

class BoilerplateMemberDetector {
  Map<String, NamedCompilationUnitMember> _classishDeclarationsByName;

  final void Function(BoilerplateFactory) onFactory;
  final void Function(BoilerplateProps) onProps;
  final void Function(BoilerplateState) onState;
  final void Function(BoilerplatePropsMixin) onPropsMixin;
  final void Function(BoilerplateStateMixin) onStateMixin;
  final void Function(BoilerplateComponent) onComponent;

  BoilerplateMemberDetector({
    @required this.onFactory,
    @required this.onProps,
    @required this.onState,
    @required this.onPropsMixin,
    @required this.onStateMixin,
    @required this.onComponent,
  });

  void detect(CompilationUnit unit) {
    _classishDeclarationsByName = {};
    final visitor = _BoilerplateMemberDetectorVisitor(
      onClassishDeclaration: (node) => _classishDeclarationsByName[node.name.name] = node,
      onTopLevelVariableDeclaration: _processTopLevelVariableDeclaration,
    );

    unit.accept(visitor);

    _classishDeclarationsByName.values.forEach(_processClassishDeclaration);
    _classishDeclarationsByName = null;
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

    if (_detectClassBasedOnAnnotations(classish, companion)) return;
    if (_detectNonLegacyPropsStateOrMixin(classish, companion)) return;
    if (_detectPotentialComponent(classish)) return;
  }

  //
  // _classishDeclarationsByName-related utilities
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

  //
  // _processTopLevelVariableDeclaration helpers
  //

  void _detectFactory(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      onFactory(BoilerplateFactory(node, VersionConfidence.all(Confidence.high)));
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
          onFactory(BoilerplateFactory(
              node,
              VersionConfidence(
                v4_mixinBased: Confidence.high,
                v3_legacyDart2Only: Confidence.none,
                v2_legacyBackwardsCompat: Confidence.none,
              )));
          return;
        } else {
          onFactory(BoilerplateFactory(
              node,
              VersionConfidence(
                v4_mixinBased: Confidence.medium,
                v2_legacyBackwardsCompat: Confidence.none,
                v3_legacyDart2Only: Confidence.none,
              )));
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

  bool _detectClassBasedOnAnnotations(ClassishDeclaration classish, ClassishDeclaration companion) {
    for (final annotation in classish.metadata) {
      switch (annotation.name.nameWithoutPrefix) {
        case 'Props':
        case 'AbstractProps':
          onProps(BoilerplateProps(
              classish, companion, _annotatedPropsOrStateConfidence(classish, companion)));
          return true;

        case 'PropsMixin':
          onPropsMixin(BoilerplatePropsMixin(classish.node, companion,
              _annotatedPropsOrStateMixinConfidence(classish, companion)));
          return true;

        case 'State':
        case 'AbstractState':
          onState(BoilerplateState(
              classish, companion, _annotatedPropsOrStateConfidence(classish, companion)));
          return true;

        case 'StateMixin':
          onStateMixin(BoilerplateStateMixin(classish.node, companion,
              _annotatedPropsOrStateMixinConfidence(classish, companion)));
          return true;

        case 'Component':
        case 'Component2':
          onComponent(BoilerplateComponent(classish, VersionConfidence.all(Confidence.high)));
          return true;

        // todo should we even use these?
        case 'AbstractComponent':
        case 'AbstractComponent2':
          onComponent(BoilerplateComponent(classish, VersionConfidence.none()));
          return true;
      }
    }

    return false;
  }

  VersionConfidence _annotatedPropsOrStateConfidence(
      ClassishDeclaration classish, ClassishDeclaration companion) {
    final node = classish.node;
    assert(node.hasAnnotationWithNames(const {'Props', 'State', 'AbstractProps', 'AbstractState'}),
        'this function assumes that all nodes passed to this function are annotated');

    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');
    final hasCompanionClass = companion != null;

    final isAbstractNoGenerate = !hasGeneratedPrefix &&
        (node is! MixinDeclaration && classish.hasAbstractKeyword && classish.members.isEmpty);
    if (isAbstractNoGenerate) {
      return VersionConfidence.none();
    }

    if (node is MixinDeclaration) {
      // todo might need to rethink these, as well as in the mixin classes, to be able to provide better error messages when people make things mixins

      // It has never been possible to declare a props class with a mixin
      return VersionConfidence(
        v2_legacyBackwardsCompat: Confidence.none,
        v3_legacyDart2Only: Confidence.none,
        // fixme this ain't right
        v4_mixinBased: Confidence.high,
      );
    } else {
      return VersionConfidence(
        v2_legacyBackwardsCompat:
            (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.high : Confidence.low,
        v3_legacyDart2Only:
            (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.low : Confidence.high,
        v4_mixinBased: Confidence.low,
      );
    }
  }

  VersionConfidence _annotatedPropsOrStateMixinConfidence(
      ClassishDeclaration classish, ClassishDeclaration companion) {
    final node = classish.node;
    assert(node.hasAnnotationWithNames(const {'PropsMixin', 'StateMixin'}),
        'this function assumes that all nodes passed to this function are annotated');

    final isMixin = node is MixinDeclaration;
    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');

    return VersionConfidence(
      v2_legacyBackwardsCompat:
          isMixin ? Confidence.none : (hasGeneratedPrefix ? Confidence.low : Confidence.high),
      v3_legacyDart2Only:
          isMixin ? Confidence.none : (hasGeneratedPrefix ? Confidence.high : Confidence.low),
      v4_mixinBased: isMixin ? Confidence.high : Confidence.low,
    );
  }

  static final propsOrMixinNamePattern = RegExp(r'Props(?:Mixin)?$');
  static final propsMixinNamePattern = propsOrMixinNamePattern;
  static final stateMixinNamePattern = RegExp(r'State(?:Mixin)?$');
  static final propsNamePattern = RegExp(r'Props(?:MapView)?$');
  static final stateNamePattern = RegExp(r'State$');

  bool _detectNonLegacyPropsStateOrMixin(
      ClassishDeclaration classish, ClassishDeclaration companion) {
    final name = classish.name.name;
    final node = classish.node;

    // By this point, this is a node that has no annotation.
    // Thus, it's non-legacy boilerplate.

    VersionConfidence getConfidence() {
      final overridesIsClassGenerated = classish.members
          .whereType<MethodDeclaration>()
          .any((member) => member.isGetter && member.name.name == r'$isClassGenerated');
      // Handle classes that look like props but are really just used as interfaces, and aren't extended from or directly used as a component's props
      if (overridesIsClassGenerated || onlyImplementsThings(classish)) {
        return VersionConfidence.none();
      } else if (classish.members.whereType<ConstructorDeclaration>().isNotEmpty) {
        //fixme fix these cases?
        return VersionConfidence.none();
      }

      return VersionConfidence(
        v2_legacyBackwardsCompat: Confidence.none,
        v3_legacyDart2Only: Confidence.none,
        v4_mixinBased: Confidence.high,
      );
    }

    if (node is MixinDeclaration) {
      if (propsMixinNamePattern.hasMatch(name) && node.hasSuperclassConstraint('UiProps')) {
        onPropsMixin(BoilerplatePropsMixin(node, companion, getConfidence()));
        return true;
      }
      if (stateMixinNamePattern.hasMatch(name) && node.hasSuperclassConstraint('UiState')) {
        onStateMixin(BoilerplateStateMixin(node, companion, getConfidence()));
        return true;
      }
    } else {
      // We never generate for abstract classes in the new boilerplate.
      if (classish.abstractKeyword != null) return false;

      final superclassName = classish.superclass?.typeNameWithoutPrefix;
      if (propsNamePattern.hasMatch(name) && superclassName == 'UiProps') {
        onProps(BoilerplateProps(classish, companion, getConfidence()));
        return true;
      }
      if (stateNamePattern.hasMatch(name) && superclassName == 'UiState') {
        onState(BoilerplateState(classish, companion, getConfidence()));
        return true;
      }
    }

    return false;
  }

  bool _detectPotentialComponent(ClassishDeclaration classish) {
    // Don't detect react-dart components as boilerplate components, since they cause issues with grouping
    // if they're in the same file as an OverReact component with non-matching names.
    if (!const {'Component', 'Component2'}.contains(classish.superclass?.nameWithoutPrefix)) {
      if (classish.name.name.endsWith('Component') ||
          classish.allSuperTypes
              .map((t) => t.typeNameWithoutPrefix)
              .any(const {'UiComponent', 'UiComponent2'}.contains) ||
          (classish.superclass?.typeArguments?.arguments
                  ?.map((t) => t.typeNameWithoutPrefix)
                  ?.any(propsOrMixinNamePattern.hasMatch) ??
              false)) {
        onComponent(BoilerplateComponent(classish, VersionConfidence.all(Confidence.medium)));

        return true;
      }
    }

    return false;
  }
}

class _BoilerplateMemberDetectorVisitor extends SimpleAstVisitor<void> {
  final void Function(NamedCompilationUnitMember) onClassishDeclaration;
  final void Function(TopLevelVariableDeclaration) onTopLevelVariableDeclaration;

  _BoilerplateMemberDetectorVisitor({
    this.onClassishDeclaration,
    this.onTopLevelVariableDeclaration,
  });

  @override
  void visitCompilationUnit(CompilationUnit node) => node.visitChildren(this);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) =>
      onTopLevelVariableDeclaration(node);

  @override
  void visitClassDeclaration(ClassDeclaration node) => onClassishDeclaration(node);

  @override
  void visitClassTypeAlias(ClassTypeAlias node) => onClassishDeclaration(node);

  @override
  void visitMixinDeclaration(MixinDeclaration node) => onClassishDeclaration(node);
}
