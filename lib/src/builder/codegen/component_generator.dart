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

import '../parsing.dart';
import 'names.dart';
import 'util.dart';

/// Base class for generating concrete and component class implementations.
abstract class ComponentGenerator extends BoilerplateDeclarationGenerator {
  ComponentGenerator._();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory ComponentGenerator(ClassComponentDeclaration declaration, {required bool nullSafety}) =
      _ComponentGenerator;

  factory ComponentGenerator.legacy(LegacyClassComponentDeclaration declaration,
      {required bool nullSafety}) = _LegacyComponentGenerator;

  TypedMapNames get propsNames;
  TypedMapNames? get stateNames;
  ComponentNames get componentNames;
  FactoryNames get factoryNames;

  BoilerplateComponent get component;
  bool get hasState;
  bool get isComponent2;
  String get defaultConsumedPropsImpl;
  bool get nullSafety;

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
      ..write(internalGeneratedMemberDeprecationLine())
      ..writeln('class ${componentNames.implName} extends ${componentNames.consumerName} {');

    if (isComponent2) {
      // See _generateConcretePropsOrStateImpl for more info on why these additional methods are
      // implemented for Component2.
      // This implementation here is necessary so that mixin accesses aren't compiled as index$ax
      outputContentsBuffer
        ..writeln('  ${nullSafety ? 'late ' : ''}${propsNames.jsMapImplName} _cachedTypedProps;')
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
        // TODO is this implementation still needed here to get good dart2js output, or can we do it in the superclass?
        ..writeln(
            '    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);')
        ..writeln('  }')
        ..writeln()
        ..writeln('  @override ')
        ..writeln(
            '  ${propsNames.jsMapImplName} typedPropsFactoryJs(JsBackedMap${nullSafety ? '?' : ''} backingMap)'
            ' => ${propsNames.jsMapImplName}(backingMap);')
        ..writeln();
    }

    outputContentsBuffer
      ..writeln('  @override')
      ..writeln(
          '  ${propsNames.implName} typedPropsFactory(Map${nullSafety ? '?' : ''} backingMap) => ${propsNames.implName}(backingMap);')
      ..writeln();

    if (hasState) {
      final stateNames = this.stateNames!;
      if (isComponent2) {
        outputContentsBuffer
          ..writeln('  ${nullSafety ? 'late ' : ''}${stateNames.jsMapImplName} _cachedTypedState;')
          ..writeln('  @override')
          ..writeln('  ${stateNames.jsMapImplName} get state => _cachedTypedState;')
          ..writeln()
          ..writeln('  @override')
          ..writeln('  set state(Map value) {')
          ..writeln('    assert(value is JsBackedMap, ')
          ..writeln('      \'Component2.state should only be set via \'')
          ..writeln('      \'initialState or setState.\');')
          ..writeln('    super.state = value;')
          ..writeln('    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);')
          ..writeln('  }')
          ..writeln()
          ..writeln('  @override ')
          ..writeln(
              '  ${stateNames.jsMapImplName} typedStateFactoryJs(JsBackedMap${nullSafety ? '?' : ''} backingMap)'
              ' => ${stateNames.jsMapImplName}(backingMap);')
          ..writeln();
      }
      outputContentsBuffer
        ..writeln('  @override')
        ..writeln(
            '  ${stateNames.implName} typedStateFactory(Map${nullSafety ? '?' : ''} backingMap)'
            ' => ${stateNames.implName}(backingMap);')
        ..writeln();
    }

    outputContentsBuffer
      ..writeln('  /// Let `UiComponent` internals know that this class has been generated.')
      ..writeln('  @override')
      ..writeln('  bool get \$isClassGenerated => true;')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String get displayName => \'${factoryNames.unprefixedConsumerName}\';')
      ..writeln()
      ..writeln('  $defaultConsumedPropsImpl');

    _generateAdditionalComponentBody();

    outputContentsBuffer.writeln('}');
  }

  void _generateAdditionalComponentBody() {}
}

/// Generates concrete and component class implementations for mixin-based boilerplate.
class _ComponentGenerator extends ComponentGenerator {
  final ClassComponentDeclaration declaration;

  @override
  final TypedMapNames propsNames;

  @override
  final TypedMapNames? stateNames;

  @override
  final ComponentNames componentNames;

  @override
  final FactoryNames factoryNames;

  @override
  final bool nullSafety;

  _ComponentGenerator(this.declaration, {required this.nullSafety})
      : this.propsNames = TypedMapNames(declaration.props.either.name.name),
        this.stateNames =
            declaration.state == null ? null : TypedMapNames(declaration.state!.either.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name),
        this.factoryNames = FactoryNames(declaration.factory.name.name),
        super._();

  @override
  Version get version => declaration.version;

  @override
  bool get isComponent2 => true;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;

  @override
  String get defaultConsumedPropsImpl =>
      '  /// The default consumed props, comprising all props mixins used by ${propsNames.consumerName}.\n'
      '  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.\n'
      '  @override\n'
      '  get \$defaultConsumedProps => propsMeta.all;';

  @override
  void _generateAdditionalComponentBody() {
    generatePropsMeta(outputContentsBuffer, declaration.allPropsMixins);
  }
}

/// Generates concrete and component class implementations for legacy-based boilerplate.
class _LegacyComponentGenerator extends ComponentGenerator {
  final LegacyClassComponentDeclaration declaration;

  @override
  final TypedMapNames propsNames;

  @override
  final TypedMapNames? stateNames;

  @override
  final ComponentNames componentNames;

  @override
  final FactoryNames factoryNames;

  @override
  final bool nullSafety;

  _LegacyComponentGenerator(this.declaration, {required this.nullSafety})
      : this.propsNames = TypedMapNames(declaration.props.name.name),
        this.stateNames =
            declaration.state == null ? null : TypedMapNames(declaration.state!.name.name),
        this.componentNames = ComponentNames(declaration.component.name.name),
        this.factoryNames = FactoryNames(declaration.factory.name.name),
        super._();

  @override
  Version get version => declaration.version;

  @override
  bool get isComponent2 => declaration.isComponent2;

  @override
  BoilerplateComponent get component => declaration.component;

  @override
  bool get hasState => declaration.state != null;

  @override
  String get defaultConsumedPropsImpl =>
      '  /// The default consumed props, taken from ${propsNames.consumerName}.\n'
      '  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.\n'
      '  @override\n'
      '  final List<ConsumedProps> \$defaultConsumedProps = const [${propsNames.metaConstantName}];';
}
