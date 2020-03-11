import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:transformer_utils/transformer_utils.dart';

import '../parsing.dart';
import 'names.dart';
import 'util.dart';

abstract class ComponentGeneratorBase extends Generator {
  AccessorNames propsNames;
  AccessorNames stateNames;
  ComponentNames componentNames;
  String factoryName;

  BoilerplateComponent get component;
  bool get hasState;
  bool get isComponent2;

  @override
  void generate() {
    _generateClassComponentFactory();
    _generateComponentImpl();
  }

  void _generateClassComponentFactory() {
    // ----------------------------------------------------------------------
    //   Factory implementation
    // ----------------------------------------------------------------------

    String parentTypeParam = 'null';
    String parentTypeParamComment = '';

    Identifier parentType = component.configSubtypeOf;
    if (parentType != null) {
      parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

      if (parentType is PrefixedIdentifier) {
        final prefix = parentType.prefix.name;
        final parentNames = ComponentNames(parentType.identifier.name);

        parentTypeParam = prefix + '.' + parentNames.componentFactoryName;
      } else {
        final parentNames = ComponentNames(parentType.name);

        parentTypeParam = parentNames.componentFactoryName;
      }
    }

    if (parentTypeParam == componentNames.componentFactoryName) {
      /// It doesn't make sense to have a component subtype itself, and also an error occurs
      /// if a component's factory variable tries to reference itself during its initialization.
      /// Therefore, this is not allowed.
      // todo move to validation
      logger.severe(messageWithSpan('A component cannot be a subtype of itself.',
          span: getSpan(sourceFile, parentType))
      );
    }

    if (isComponent2) {
      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        ..writeln('final ${componentNames.componentFactoryName} = registerComponent2(() => ${componentNames.implName}(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: ${componentNames.componentName},')
        ..writeln('    isWrapper: ${component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)},');

      if ((component.meta as annotations.Component2).isErrorBoundary) {
        // Override `skipMethods` as an empty list so that
        // the `componentDidCatch` and `getDerivedStateFromError`
        // lifecycle methods are included in the component's JS bindings.
        outputContentsBuffer.writeln('    skipMethods: const [],');
      }

      outputContentsBuffer
        ..writeln(');')
        ..writeln();
    } else {
      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        ..writeln('final ${componentNames.componentFactoryName} = registerComponent(() => ${componentNames.implName}(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: ${componentNames.componentName},')
        ..writeln('    isWrapper: ${component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)}')
        ..writeln(');')
        ..writeln();
    }
  }

  void _generateComponentImpl() {
    StringBuffer componentBody = StringBuffer();

    if (isComponent2) {
      // See _generateConcretePropsOrStateImpl for more info on why these additional methods are
      // implemented for Component2.
      // This implementation here is necessary so that mixin accesses aren't compiled as index$ax
      componentBody
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
        ..writeln('  ${propsNames.jsMapImplName} typedPropsFactoryJs(JsBackedMap backingMap) => ${propsNames.jsMapImplName}(backingMap);')
        ..writeln();

      if (hasState) {
        componentBody
          ..writeln('  ${stateNames.jsMapImplName} _cachedTypedState;')
          ..writeln()
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
          ..writeln('  ${stateNames.jsMapImplName} typedStateFactoryJs(JsBackedMap backingMap) => ${stateNames.jsMapImplName}(backingMap);')
          ..writeln();
        }
    }
    componentBody
      ..writeln('  @override')
      ..writeln('  ${propsNames.implName} typedPropsFactory(Map backingMap) => ${propsNames.implName}(backingMap);')
      ..writeln();
    if (hasState) {
      componentBody
        ..writeln('  @override')
        ..writeln('  ${stateNames.implName} typedStateFactory(Map backingMap) => ${stateNames.implName}(backingMap);')
        ..writeln();
    }
  }

}

class ComponentGenerator extends ComponentGeneratorBase {
  final ClassComponentDeclaration declaration;

  @override
  final AccessorNames propsNames;

  @override
  final AccessorNames stateNames;

  @override
  final ComponentNames componentNames;

  @override
  final String factoryName;

  ComponentGenerator(this.declaration) :
        this.factoryName = declaration.factory.name.name,
        this.propsNames = AccessorNames(consumerName: declaration.props.either.name.name),
        this.stateNames = declaration.state == null ? null : AccessorNames(consumerName: declaration.state.either.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name);

  @override
  bool get isComponent2 => true;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;
}

class LegacyComponentGenerator extends ComponentGeneratorBase {
  final LegacyClassComponentDeclaration declaration;

  @override
  final AccessorNames propsNames;

  @override
  final AccessorNames stateNames;

  @override
  final ComponentNames componentNames;

  @override
  final String factoryName;

  LegacyComponentGenerator(this.declaration) :
        this.factoryName = declaration.factory.name.name,
        this.propsNames = AccessorNames(consumerName: declaration.props.name.name),
        this.stateNames = declaration.state == null ? null : AccessorNames(consumerName: declaration.state.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name);


  @override
  bool get isComponent2 => declaration.isComponent2;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;
}
