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
import 'package:over_react/src/builder/util.dart';
import 'package:transformer_utils/transformer_utils.dart';

import '../parsing.dart';
import '../util.dart';
import 'names.dart';
import 'util.dart';

/// Base class for generating concrete factory and props/state class implementations.
abstract class TypedMapImplGenerator extends BoilerplateDeclarationGenerator {
  TypedMapImplGenerator();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory TypedMapImplGenerator.legacyProps(LegacyClassComponentDeclaration declaration) =
      _LegacyTypedMapImplGenerator.props;

  factory TypedMapImplGenerator.legacyState(LegacyClassComponentDeclaration declaration) =
      _LegacyTypedMapImplGenerator.state;

  factory TypedMapImplGenerator.props(ClassComponentDeclaration declaration) =
      _TypedMapImplGenerator.props;

  factory TypedMapImplGenerator.state(ClassComponentDeclaration declaration) =
      _TypedMapImplGenerator.state;

  factory TypedMapImplGenerator.propsMapViewOrFunctionComponent(
          PropsMapViewOrFunctionComponentDeclaration declaration) =
      _TypedMapImplGenerator.propsMapViewOrFunctionComponent;

  TypedMapNames get names;
  bool get isComponent2;
  List<FactoryNames> get factoryNames;
  bool get isProps;

  BoilerplateTypedMapMember get member;

  TypeParameterList get typeParameters => member.nodeHelper.typeParameters;
  String get typeParamsOnClass => typeParameters?.toSource() ?? '';
  String get typeParamsOnSuper => removeBoundsFromTypeParameters(typeParameters);

  @override
  void generate() {
    if (isProps) {
      _generateFactory();
      _generatePropsImpl();
    } else {
      _generateStateImpl();
    }
  }

  void _generatePropsImpl();

  void _generateStateImpl();

  void _generateFactory() {
    if (factoryNames == null) throw StateError('factoryNames must not be null');
    assert(factoryNames.length == 1, 'factoryNames must have a length of 1');

    outputContentsBuffer
        .write('${names.implName} ${factoryNames.first.implName}([Map backingProps]) => ');

    /// _$$FooProps _$Foo([Map backingProps]) => _$$FooProps(backingProps);
    outputContentsBuffer.writeln('${names.implName}(backingProps);');
  }

  String _generateImplClassHeader();

  /// Generates a concrete props or state implementation class for a given component.
  ///
  /// ## For Component2
  ///
  /// Generates an additional UiProps class implementation for each component that can only be backed by JS maps,
  /// and overrides the return type of `typedPropsFactoryJs`/`props` to match this.
  ///
  /// This allows dart2js to make some optimizations. For instance:
  ///
  /// For the access of `props.isOpen` within a component, if we try to inline things
  /// (for the purposes of understanding what's going on under the hood), then it looks like this:
  ///
  ///     props.isOpen;           // inlining FooProps.isOpen typed getter, this becomes...
  ///     props.props['isOpen'];  // inlining UiProps.operator[], this becomes...
  ///     props.props.backingMap['isOpen'];
  ///
  /// So, we're eventually accessing a property on the `Map backingMap`.
  ///
  /// But if `backingMap` is a `JsBackedMap`, we can go one layer deeper:
  ///
  ///     props.props.backingMap['isOpen'];  // inlining JsBackedMap.operator[], this becomes...
  ///     getProperty(props.props.backingMap.jsMap, 'isOpen');
  ///
  /// Now, onto dart2js, which performs actual inlining in certain cases (like prop accesses).
  ///
  /// When dart2js only knows that `backingMap` is a `Map`, it emits the following code, wherein
  /// `$index$asx` performs type-checking on the map and key, and then performs an interceptor lookup on
  /// the backing map before finally calling into the actual key lookup function.
  ///
  ///     J.$index$asx(this._cachedTypedProps.props.backingMap, 'isOpen');
  ///
  /// However, when dart2js knows that `backingMap` is a `JsMap`, it can skip that step and emit
  /// code that directly accesses the JS property `index$ax` instead:
  ///
  ///     J.$index$ax(this._cachedTypedProps.props.backingMap, 'isOpen');
  ///
  /// Which in some cases can just become:
  ///
  ///     this._cachedTypedProps.props.backingMap.jsMap.isOpen;
  ///     // or, minified:
  ///     this.foo.bar.baz.qux.isOpen;
  ///
  String _generateConcretePropsOrStateImpl({
    String componentFactoryName,
    String propKeyNamespace,
    List<Identifier> allPropsMixins,
  }) {
    if (isProps) {
      if (componentFactoryName == null || propKeyNamespace == null) {
        throw ArgumentError('componentFactoryName/propKeyNamespace must be specified for props');
      }
    } else {
      if (componentFactoryName != null || propKeyNamespace != null) {
        throw ArgumentError(
            'componentFactoryName/propKeyNamespace must not be specified for state');
      }
    }

    final classDeclaration = StringBuffer();
    classDeclaration..write(_generateImplClassHeader())..write(' {');

    final propsOrState = isProps ? 'props' : 'state';

    // Class declaration
    final buffer = StringBuffer()
      ..writeln('// Concrete $propsOrState implementation.')
      ..writeln('//')
      ..writeln(
          '// Implements constructor and backing map${isProps ? ', and links up to generated component factory' : ''}.')
      ..write(internalGeneratedMemberDeprecationLine())
      ..writeln(classDeclaration);

    // Constructors

    buffer
      ..writeln(
          '  // This initializer of `_$propsOrState` to an empty map, as well as the reassignment')
      ..writeln(
          '  // of `_$propsOrState` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217')
      ..writeln('  ${names.implName}(Map backingMap) : this.$propsOrState = backingMap ?? ({});');

    buffer
      ..writeln()
      ..writeln('  /// The backing $propsOrState map proxied by this class.')
      ..writeln('  @override')
      ..writeln('  final Map $propsOrState;');

    buffer
      ..writeln()
      ..writeln(
          '  /// Let `${isProps ? 'UiProps' : 'UiState'}` internals know that this class has been generated.')
      ..writeln('  @override')
      ..writeln('  bool get \$isClassGenerated => true;');
    if (isProps) {
      // No reason to override if it's null.
      if (componentFactoryName != 'null') {
        buffer
          ..writeln()
          ..writeln(
              '  /// The `ReactComponentFactory` associated with the component built by this class.')
          ..writeln('  @override')
          ..writeln('  ReactComponentFactoryProxy get componentFactory =>'
              ' super.componentFactory ?? $componentFactoryName;')
          ..writeln();
      }
      buffer
        ..writeln(
            '  /// The default namespace for the prop getters/setters generated for this class.')
        ..writeln('  @override')
        ..writeln('  String get propKeyNamespace => ${stringLiteral(propKeyNamespace)};');

      if (allPropsMixins != null) {
        generatePropsMeta(buffer, allPropsMixins,
            classType: 'PropsMetaCollection', fieldName: r'staticMeta');
      }
    }

    // End of class body
    buffer.writeln('}');

    return buffer.toString();
  }
}

/// Generates concrete factories and props/state class implementations for legacy props/state classes.
class _LegacyTypedMapImplGenerator extends TypedMapImplGenerator {
  @override
  final TypedMapNames names;

  @override
  final List<FactoryNames> factoryNames;

  @override
  final bool isProps;

  final LegacyClassComponentDeclaration declaration;

  @override
  final BoilerplatePropsOrState member;

  _LegacyTypedMapImplGenerator.props(this.declaration)
      : names = TypedMapNames(declaration.props.name.name),
        factoryNames = [FactoryNames(declaration.factory.name.name)],
        member = declaration.props,
        isProps = true;

  _LegacyTypedMapImplGenerator.state(this.declaration)
      : names = TypedMapNames(declaration.state.name.name),
        factoryNames = [FactoryNames(declaration.factory.name.name)],
        member = declaration.state,
        isProps = false;

  @override
  Version get version => declaration.version;

  @override
  bool get isComponent2 => declaration.isComponent2;

  @override
  void _generatePropsImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl(
      componentFactoryName: ComponentNames(declaration.component.name.name).componentFactoryName,
      propKeyNamespace: getAccessorKeyNamespace(names, member.meta),
    ));
  }

  @override
  void _generateStateImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl());
  }

  @override
  String _generateImplClassHeader() {
    final typeParamsOnSuper = this.typeParamsOnSuper;

    return 'class ${names.implName}$typeParamsOnClass '
        'extends ${names.consumerName}$typeParamsOnSuper '
        'with ${names.legacyAccessorsMixinName}$typeParamsOnSuper '
        'implements ${names.publicName}$typeParamsOnSuper';
  }
}

/// Generates concrete factories and props/state class implementations for mixin-based syntax:
///
/// - component props/state
/// - function or props map view props
///
/// Handles both shorthand and verbose syntax.
class _TypedMapImplGenerator extends TypedMapImplGenerator {
  @override
  final TypedMapNames names;

  @override
  final List<FactoryNames> factoryNames;

  @override
  final bool isProps;

  @override
  final BoilerplateTypedMapMember member;

  final String componentFactoryName;

  final bool isFunctionComponentDeclaration;

  @override
  final Version version;

  final List<Identifier> allPropsMixins;

  _TypedMapImplGenerator.props(ClassComponentDeclaration declaration)
      : names = TypedMapNames(declaration.props.either.name.name),
        factoryNames = [FactoryNames(declaration.factory.name.name)],
        member = declaration.props.either,
        allPropsMixins = declaration.allPropsMixins,
        isProps = true,
        componentFactoryName = ComponentNames(declaration.component.name.name).componentFactoryName,
        isFunctionComponentDeclaration = false,
        version = declaration.version;

  _TypedMapImplGenerator.state(ClassComponentDeclaration declaration)
      : names = TypedMapNames(declaration.state.either.name.name),
        factoryNames = [FactoryNames(declaration.factory.name.name)],
        member = declaration.state.either,
        allPropsMixins = null,
        isProps = false,
        componentFactoryName = ComponentNames(declaration.component.name.name).componentFactoryName,
        isFunctionComponentDeclaration = false,
        version = declaration.version;

  _TypedMapImplGenerator.propsMapViewOrFunctionComponent(
      PropsMapViewOrFunctionComponentDeclaration declaration)
      : names = TypedMapNames(declaration.props.either.name.name),
        factoryNames =
            declaration.factories.map((factory) => FactoryNames(factory.name.name)).toList(),
        member = declaration.props.either,
        allPropsMixins = declaration.allPropsMixins,
        isProps = true,
        componentFactoryName = 'null',
        isFunctionComponentDeclaration = declaration.factories.first.shouldGenerateConfig,
        version = declaration.version;

  @override
  bool get isComponent2 => true;

  String _generateUiFactoryConfig(FactoryNames factoryName) {
    return 'final UiFactoryConfig<${names.implName}> '
        '${factoryName.privateConfigName} = UiFactoryConfig(\n'
        'propsFactory: PropsFactory(\n'
        'map: (map) => ${names.implName}(map),\n'
        'jsMap: (map) => ${names.implName}(map),),\n'
        'displayName: \'${factoryName.consumerName}\');\n\n'
        '@Deprecated(r\'Use the private variable, ${factoryName.privateConfigName}, instead \'\n'
        '\'and update the `over_react` lower bound to version 4.1.0. \'\n'
        '\'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650\')\n'
        'final UiFactoryConfig<${names.implName}> '
        // ignore: deprecated_member_use_from_same_package
        '${factoryName.publicConfigName} = ${factoryName.privateConfigName};\n\n';
  }

  @override
  void _generateFactory() {
    if (isFunctionComponentDeclaration) {
      for (final factoryName in factoryNames) {
        outputContentsBuffer.write(_generateUiFactoryConfig(factoryName));
      }
    } else {
      super._generateFactory();
    }
  }

  @override
  void _generatePropsImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl(
      componentFactoryName: componentFactoryName,
      // This doesn't really apply to the new boilerplate
      propKeyNamespace: '',
      allPropsMixins: allPropsMixins,
    ));
  }

  @override
  void _generateStateImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl());
  }

  @override
  String _generateImplClassHeader() {
    if (member is BoilerplatePropsOrStateMixin) {
      return 'class ${names.implName}$typeParamsOnClass'
          ' extends ${isProps ? 'UiProps' : 'UiState'}'
          ' with\n'
          ' ${names.consumerName}$typeParamsOnSuper';
    } else if (member is BoilerplatePropsOrState) {
      final header = StringBuffer()
        ..write('class ${names.implName}$typeParamsOnClass'
            ' extends ${names.consumerName}$typeParamsOnSuper');
      return header.toString();
    } else {
      throw StateError('`member` is an unexpected type: $member');
    }
  }
}
