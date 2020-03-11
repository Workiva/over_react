import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:transformer_utils/transformer_utils.dart';

import '../parsing.dart';
import 'names.dart';
import 'util.dart';

abstract class ComponentGenerator extends Generator {
  ComponentGenerator._();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory ComponentGenerator(ClassComponentDeclaration declaration) = _ComponentGenerator;

  factory ComponentGenerator.legacy(LegacyClassComponentDeclaration declaration) =
      _LegacyComponentGenerator;

  TypedMapNames propsNames;
  TypedMapNames stateNames;
  ComponentNames componentNames;

  BoilerplateComponent get component;
  bool get hasState;
  bool get isComponent2;
  String get defaultConsumedProps;

  @override
  void generate() {
    _generateComponentImpl();
  }

  void _generateComponentImpl() {
    outputContentsBuffer
      ..writeln('// Concrete component implementation mixin.')
      ..writeln('//')
      ..writeln(
          '// Implements typed props/state factories, defaults `consumedPropKeys` to the keys')
      ..writeln('// generated for the associated props class.')
      ..writeln('class ${componentNames.implName} extends ${componentNames.componentName} {');

    if (isComponent2) {
      // See _generateConcretePropsOrStateImpl for more info on why these additional methods are
      // implemented for Component2.
      // This implementation here is necessary so that mixin accesses aren't compiled as index$ax
      outputContentsBuffer
        ..writeln('  ${propsNames.jsMapImplName} _cachedTypedProps;')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  ${propsNames.jsMapImplName} get props => _cachedTypedProps;')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  set props(Map value) {')
        ..writeln('    assert(getBackingMap(value) is JsBackedMap, ')
        ..writeln('      \'Component2.props should never be set directly in \'')
        ..writeln('      \'production. If this is required for testing, the \'')
        ..writeln('      \'component should be rendered within the test. If \'')
        ..writeln('      \'that does not have the necessary result, the last \'')
        ..writeln('      \'resort is to use typedPropsFactoryJs.\');')
        ..writeln('    super.props = value;')
        // FIXME 3.0.0-wip: is this implementation still needed here to get good dart2js output, or can we do it in the superclass?
        ..writeln('    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));')
        ..writeln('  }')
        ..writeln()
        ..writeln('  @override ')
        ..writeln('  ${propsNames.jsMapImplName} typedPropsFactoryJs(JsBackedMap backingMap)'
            ' => ${propsNames.jsMapImplName}(backingMap);')
        ..writeln();
    }

    outputContentsBuffer
      ..writeln('  @override')
      ..writeln(
          '  ${propsNames.implName} typedPropsFactory(Map backingMap) => ${propsNames.implName}(backingMap);')
      ..writeln();

    if (isComponent2 && hasState) {
      outputContentsBuffer
        ..writeln('  ${stateNames.jsMapImplName} _cachedTypedState;')
        ..writeln('  @override')
        ..writeln('  ${stateNames.jsMapImplName} get state => _cachedTypedState;')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  set state(Map value) {')
        ..writeln('    assert(value is JsBackedMap, ')
        ..writeln('      \'Component2.state should only be set via \'')
        ..writeln('      \'initialState or setState.\');')
        ..writeln('    super.state = value;')
        ..writeln('    _cachedTypedState = typedStateFactoryJs(value);')
        ..writeln('  }')
        ..writeln()
        ..writeln('  @override ')
        ..writeln('  ${stateNames.jsMapImplName} typedStateFactoryJs(JsBackedMap backingMap)'
            ' => ${stateNames.jsMapImplName}(backingMap);')
        ..writeln();
    }

    if (hasState) {
      outputContentsBuffer
        ..writeln('  @override')
        ..writeln('  ${stateNames.implName} typedStateFactory(Map backingMap)'
            ' => ${stateNames.implName}(backingMap);')
        ..writeln();
    }

    outputContentsBuffer
      ..writeln('  /// Let `UiComponent` internals know that this class has been generated.')
      ..writeln('  @override')
      ..writeln('  bool get \$isClassGenerated => true;')
      ..writeln()
      ..writeln('  /// The default consumed props, taken from ${propsNames.consumerName}.')
      ..writeln('  /// Used in `ConsumedProps` if [consumedProps] is not overridden.')
      ..writeln('  @override')
      ..writeln('  final List<ConsumedProps> \$defaultConsumedProps = $defaultConsumedProps;');

    _generateAdditionalComponentBody();

    outputContentsBuffer.writeln('}');

    final implementsTypedPropsStateFactory = component.nodeHelper.members.any((member) =>
        member is MethodDeclaration &&
        !member.isStatic &&
        (member.name.name == 'typedPropsFactory' || member.name.name == 'typedStateFactory'));

    // FIXME move to validation
    if (implementsTypedPropsStateFactory) {
      // Can't be an error, because consumers may be implementing typedPropsFactory or typedStateFactory in their components.
      logger.warning(messageWithSpan(
          'Components should not add their own implementions of typedPropsFactory or typedStateFactory.',
          span: getSpan(sourceFile, component.node)));
    }
  }

  void _generateAdditionalComponentBody() {}
}

class _ComponentGenerator extends ComponentGenerator {
  final ClassComponentDeclaration declaration;

  @override
  final TypedMapNames propsNames;

  @override
  final TypedMapNames stateNames;

  @override
  final ComponentNames componentNames;

  _ComponentGenerator(this.declaration)
      : this.propsNames = TypedMapNames(declaration.props.either.name.name),
        this.stateNames =
            declaration.state == null ? null : TypedMapNames(declaration.state.either.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name),
        super._();

  @override
  bool get isComponent2 => true;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;

  @override
  String get defaultConsumedProps => declaration.props.switchCase(
        (a) => 'const []', // Concrete props classes do not have generated meta
        (b) => 'const [${propsNames.metaConstantName}]',
      );

  @override
  void _generateAdditionalComponentBody() {
    outputContentsBuffer
      ..writeln()
      ..writeln('  @override')
      ..writeln('  PropsMetaCollection get propsMeta => const PropsMetaCollection({')
      ..writeAll(declaration.allPropsMixins.map((name) {
        final names = TypedMapNames(name.name);
        return '    ${names.consumerName}: ${names.publicGeneratedMetaName},';
      }), '\n')
      ..writeln('  });');
  }
}

class _LegacyComponentGenerator extends ComponentGenerator {
  final LegacyClassComponentDeclaration declaration;

  @override
  final TypedMapNames propsNames;

  @override
  final TypedMapNames stateNames;

  @override
  final ComponentNames componentNames;

  _LegacyComponentGenerator(this.declaration)
      : this.propsNames = TypedMapNames(declaration.props.name.name),
        this.stateNames =
            declaration.state == null ? null : TypedMapNames(declaration.state.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name),
        super._();

  @override
  bool get isComponent2 => declaration.isComponent2;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;

  @override
  String get defaultConsumedProps => 'const [${propsNames.metaConstantName}]';
}
