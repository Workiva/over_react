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

    if (_detectBasedOnAnnotations(classish, companion: companion)) return;
    if (_detectNonLegacyPropsStateAndMixins(classish, companion: companion)) return;
    if (_detectPotentialComponent(classish)) return;
  }

  //
  // _processTopLevelVariableDeclaration helpers
  //

  void _detectFactory(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      onFactory(BoilerplateFactory(node, {
        BoilerplateVersion.v2_legacyBackwardsCompat: Confidence.high,
        BoilerplateVersion.v3_legacyDart2Only: Confidence.high,
        BoilerplateVersion.v4_mixinBased: Confidence.high,
      }));
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
          onFactory(BoilerplateFactory(node, {
            BoilerplateVersion.v4_mixinBased: Confidence.high,
          }));
          return;
        } else {
          onFactory(BoilerplateFactory(node, {
            BoilerplateVersion.v4_mixinBased: Confidence.medium,
            BoilerplateVersion.noGenerate: Confidence.medium,
          }));
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

  Map<BoilerplateVersion, int> _propsOrStateConfidence(
      ClassishDeclaration nodeHelper, ClassishDeclaration companionClass) {
    final node = nodeHelper.node;

    assert(node.hasAnnotationWithNames(const {'Props', 'State', 'AbstractProps', 'AbstractState'}),
        'this function assumes that all nodes passed to this function are annotated');

    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');
    final hasCompanionClass = companionClass != null;

    final isAbstractNoGenerate = !hasGeneratedPrefix &&
        (node is! MixinDeclaration && nodeHelper.hasAbstractKeyword && nodeHelper.members.isEmpty);
    if (isAbstractNoGenerate) {
      return {BoilerplateVersion.noGenerate: Confidence.high};
    }

    final map = <BoilerplateVersion, int>{};
    if (node is MixinDeclaration) {
      // todo might need to rethink these, as well as in the mixin classes, to be able to provide better error messages when people make things mixins

      // It has never been possible to declare a props class with a mixin
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.none;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.none;
      // fixme this ain't right
      map[BoilerplateVersion.v4_mixinBased] = Confidence.high;
    } else {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] =
          (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.medium : Confidence.veryLow;
      map[BoilerplateVersion.v3_legacyDart2Only] =
          (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.veryLow : Confidence.medium;
      map[BoilerplateVersion.v4_mixinBased] = Confidence.veryLow;
    }

    return map;
  }

  Map<BoilerplateVersion, int> _propsOrStateMixinConfidence(
      ClassishDeclaration nodeHelper, ClassishDeclaration companionClass) {
    final node = nodeHelper.node;

    assert(node.hasAnnotationWithNames(const {'PropsMixin', 'StateMixin'}),
        'this function assumes that all nodes passed to this function are annotated');

    final isMixin = node is MixinDeclaration;
    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');

    return {
      BoilerplateVersion.v2_legacyBackwardsCompat:
          isMixin ? Confidence.none : (hasGeneratedPrefix ? Confidence.veryLow : Confidence.high),
      BoilerplateVersion.v3_legacyDart2Only:
          isMixin ? Confidence.none : (hasGeneratedPrefix ? Confidence.high : Confidence.veryLow),
      BoilerplateVersion.v4_mixinBased: isMixin ? Confidence.high : Confidence.veryLow,
      BoilerplateVersion.noGenerate: Confidence.veryLow,
    };
  }

  bool _detectBasedOnAnnotations(ClassishDeclaration classish, {ClassishDeclaration companion}) {
    for (final annotation in classish.metadata) {
      switch (annotation.name.nameWithoutPrefix) {
        case 'Props':
        case 'AbstractProps':
          final confidence = _propsOrStateConfidence(classish, companion);
          onProps(BoilerplateProps(classish, companion, confidence));
          return true;

        case 'PropsMixin':
          final confidence = _propsOrStateMixinConfidence(classish, companion);
          onPropsMixin(BoilerplatePropsMixin(classish.node, companion, confidence));
          return true;

        case 'State':
        case 'AbstractState':
          final confidence = _propsOrStateConfidence(classish, companion);
          onState(BoilerplateState(classish, companion, confidence));
          return true;

        case 'StateMixin':
          final confidence = _propsOrStateMixinConfidence(classish, companion);
          onStateMixin(BoilerplateStateMixin(classish.node, companion, confidence));
          return true;

        case 'Component':
        case 'Component2':
          final confidence = {
            for (final version in BoilerplateVersion.values) version: Confidence.high
          };
          onComponent(BoilerplateComponent(classish, confidence));
          return true;

        // todo should we even use these?
        case 'AbstractComponent':
        case 'AbstractComponent2':
          final confidence = {BoilerplateVersion.noGenerate: Confidence.high};
          onComponent(BoilerplateComponent(classish, confidence));
          return true;
      }
    }

    return false;
  }

  static final propsOrMixinNamePattern = RegExp(r'Props(?:Mixin)?$');
  static final propsMixinNamePattern = propsOrMixinNamePattern;
  static final stateMixinNamePattern = RegExp(r'State(?:Mixin)?$');
  static final propsNamePattern = RegExp(r'Props(?:MapView)?$');
  static final stateNamePattern = RegExp(r'State$');

  bool _detectNonLegacyPropsStateAndMixins(ClassishDeclaration classish,
      {ClassishDeclaration companion}) {
    final name = classish.name.name;
    final node = classish.node;

    // By this point, this is a node that has no annotation.
    // Thus, it's non-legacy boilerplate.

    Map<BoilerplateVersion, int> getConfidence() {
      final confidence = {BoilerplateVersion.v4_mixinBased: Confidence.high};
      final overridesIsClassGenerated = classish.members
          .whereType<MethodDeclaration>()
          .any((member) => member.isGetter && member.name.name == r'$isClassGenerated');
      // Handle classes that look like props but are really just used as interfaces, and aren't extended from or directly used as a component's props
      if (overridesIsClassGenerated || onlyImplementsThings(classish)) {
        confidence[BoilerplateVersion.noGenerate] = Confidence.certain;
      } else if (classish.members.whereType<ConstructorDeclaration>().isNotEmpty) {
        //fixme fix these cases?
        confidence[BoilerplateVersion.noGenerate] = Confidence.certain;
      }

      return confidence;
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
        onComponent(BoilerplateComponent(classish, {
          for (var value in BoilerplateVersion.values) value: Confidence.medium,
        }));

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
