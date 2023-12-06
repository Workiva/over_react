// @dart=2.11
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'component_integration_verbose_syntax_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ComponentTest290ComponentFactory = registerComponent2(
  () => _$ComponentTest290Component(),
  builderFactory: _$ComponentTest290,
  componentClass: ComponentTest290Component,
  isWrapper: false,
  parentType: null,
);

_$$ComponentTestProps290Props _$ComponentTest290([Map backingProps]) =>
    backingProps == null
        ? _$$ComponentTestProps290Props$JsMap(JsBackedMap())
        : _$$ComponentTestProps290Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ComponentTestProps290Props extends UiProps
    with
        ComponentTestPropsMixin,
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        $ComponentTestPropsMixin,
        TestPropsMixin,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        $TestPropsMixin
    implements
        ComponentTestProps290Props {
  _$$ComponentTestProps290Props._();

  factory _$$ComponentTestProps290Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ComponentTestProps290Props$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ComponentTestProps290Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ComponentTest290ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        ComponentTestPropsMixin: $ComponentTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps290Props$PlainMap
    extends _$$ComponentTestProps290Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps290Props$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps290Props$JsMap
    extends _$$ComponentTestProps290Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps290Props$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ComponentTest290Component extends ComponentTest290Component {
  _$$ComponentTestProps290Props$JsMap _cachedTypedProps;

  @override
  _$$ComponentTestProps290Props$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ComponentTestProps290Props$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$ComponentTestProps290Props$JsMap(backingMap);

  @override
  _$$ComponentTestProps290Props typedPropsFactory(Map backingMap) =>
      _$$ComponentTestProps290Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ComponentTest290';

  /// The default consumed props, comprising all props mixins used by ComponentTestProps290Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        ComponentTestPropsMixin: $ComponentTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ComponentTestComponentFactory = registerComponent2(
  () => _$ComponentTestComponent(),
  builderFactory: _$ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
);

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    backingProps == null
        ? _$$ComponentTestProps$JsMap(JsBackedMap())
        : _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ComponentTestProps extends UiProps
    with
        ComponentTestPropsMixin,
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        $ComponentTestPropsMixin,
        TestPropsMixin,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        $TestPropsMixin
    implements
        ComponentTestProps {
  _$$ComponentTestProps._();

  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ComponentTestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        ComponentTestPropsMixin: $ComponentTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps$PlainMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps$JsMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ComponentTestComponent extends ComponentTestComponent {
  _$$ComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$ComponentTestProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ComponentTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ComponentTestProps$JsMap(backingMap);

  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      _$$ComponentTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ComponentTest';

  /// The default consumed props, comprising all props mixins used by ComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestPropsMixin, and check that $ComponentTestPropsMixin is exported/imported properly.
        ComponentTestPropsMixin: $ComponentTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestPropsMixin on TestPropsMixin {
  static const PropsMeta meta = _$metaForTestPropsMixin;
  @override
  dynamic get propsMixinProp =>
      (props[_$key__propsMixinProp__TestPropsMixin] ?? null) as dynamic;
  @override
  set propsMixinProp(dynamic value) =>
      props[_$key__propsMixinProp__TestPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__propsMixinProp__TestPropsMixin =
      PropDescriptor(_$key__propsMixinProp__TestPropsMixin);
  static const String _$key__propsMixinProp__TestPropsMixin =
      'TestPropsMixin.propsMixinProp';

  static const List<PropDescriptor> $props = [
    _$prop__propsMixinProp__TestPropsMixin
  ];
  static const List<String> $propKeys = [_$key__propsMixinProp__TestPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestPropsMixin = PropsMeta(
  fields: $TestPropsMixin.$props,
  keys: $TestPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ComponentTestPropsMixin on ComponentTestPropsMixin {
  static const PropsMeta meta = _$metaForComponentTestPropsMixin;
  @override
  String get stringProp =>
      (props[_$key__stringProp__ComponentTestPropsMixin] ?? null) as String;
  @override
  set stringProp(String value) =>
      props[_$key__stringProp__ComponentTestPropsMixin] = value;
  @override
  bool get shouldSetPropsDirectly =>
      (props[_$key__shouldSetPropsDirectly__ComponentTestPropsMixin] ?? null)
          as bool;
  @override
  set shouldSetPropsDirectly(bool value) =>
      props[_$key__shouldSetPropsDirectly__ComponentTestPropsMixin] = value;
  @override
  bool get shouldUseJsFactory =>
      (props[_$key__shouldUseJsFactory__ComponentTestPropsMixin] ?? null)
          as bool;
  @override
  set shouldUseJsFactory(bool value) =>
      props[_$key__shouldUseJsFactory__ComponentTestPropsMixin] = value;
  @override
  dynamic get dynamicProp =>
      (props[_$key__dynamicProp__ComponentTestPropsMixin] ?? null) as dynamic;
  @override
  set dynamicProp(dynamic value) =>
      props[_$key__dynamicProp__ComponentTestPropsMixin] = value;
  @override
  get untypedProp => props[_$key__untypedProp__ComponentTestPropsMixin] ?? null;
  @override
  set untypedProp(value) =>
      props[_$key__untypedProp__ComponentTestPropsMixin] = value;
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyProp =>
      (props[_$key__customKeyProp__ComponentTestPropsMixin] ?? null) as dynamic;
  @override
  @Accessor(key: 'custom key!')
  set customKeyProp(dynamic value) =>
      props[_$key__customKeyProp__ComponentTestPropsMixin] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceProp =>
      (props[_$key__customNamespaceProp__ComponentTestPropsMixin] ?? null)
          as dynamic;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceProp(dynamic value) =>
      props[_$key__customNamespaceProp__ComponentTestPropsMixin] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceProp =>
      (props[_$key__customKeyAndNamespaceProp__ComponentTestPropsMixin] ?? null)
          as dynamic;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceProp(dynamic value) =>
      props[_$key__customKeyAndNamespaceProp__ComponentTestPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__stringProp__ComponentTestPropsMixin);
  static const PropDescriptor
      _$prop__shouldSetPropsDirectly__ComponentTestPropsMixin =
      PropDescriptor(_$key__shouldSetPropsDirectly__ComponentTestPropsMixin);
  static const PropDescriptor
      _$prop__shouldUseJsFactory__ComponentTestPropsMixin =
      PropDescriptor(_$key__shouldUseJsFactory__ComponentTestPropsMixin);
  static const PropDescriptor _$prop__dynamicProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__dynamicProp__ComponentTestPropsMixin);
  static const PropDescriptor _$prop__untypedProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__untypedProp__ComponentTestPropsMixin);
  static const PropDescriptor _$prop__customKeyProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__customKeyProp__ComponentTestPropsMixin);
  static const PropDescriptor
      _$prop__customNamespaceProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__customNamespaceProp__ComponentTestPropsMixin);
  static const PropDescriptor
      _$prop__customKeyAndNamespaceProp__ComponentTestPropsMixin =
      PropDescriptor(_$key__customKeyAndNamespaceProp__ComponentTestPropsMixin);
  static const String _$key__stringProp__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.stringProp';
  static const String _$key__shouldSetPropsDirectly__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.shouldSetPropsDirectly';
  static const String _$key__shouldUseJsFactory__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.shouldUseJsFactory';
  static const String _$key__dynamicProp__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.dynamicProp';
  static const String _$key__untypedProp__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.untypedProp';
  static const String _$key__customKeyProp__ComponentTestPropsMixin =
      'ComponentTestPropsMixin.custom key!';
  static const String _$key__customNamespaceProp__ComponentTestPropsMixin =
      'custom namespace~~customNamespaceProp';
  static const String
      _$key__customKeyAndNamespaceProp__ComponentTestPropsMixin =
      'custom namespace~~custom key!';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp__ComponentTestPropsMixin,
    _$prop__shouldSetPropsDirectly__ComponentTestPropsMixin,
    _$prop__shouldUseJsFactory__ComponentTestPropsMixin,
    _$prop__dynamicProp__ComponentTestPropsMixin,
    _$prop__untypedProp__ComponentTestPropsMixin,
    _$prop__customKeyProp__ComponentTestPropsMixin,
    _$prop__customNamespaceProp__ComponentTestPropsMixin,
    _$prop__customKeyAndNamespaceProp__ComponentTestPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__stringProp__ComponentTestPropsMixin,
    _$key__shouldSetPropsDirectly__ComponentTestPropsMixin,
    _$key__shouldUseJsFactory__ComponentTestPropsMixin,
    _$key__dynamicProp__ComponentTestPropsMixin,
    _$key__untypedProp__ComponentTestPropsMixin,
    _$key__customKeyProp__ComponentTestPropsMixin,
    _$key__customNamespaceProp__ComponentTestPropsMixin,
    _$key__customKeyAndNamespaceProp__ComponentTestPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForComponentTestPropsMixin = PropsMeta(
  fields: $ComponentTestPropsMixin.$props,
  keys: $ComponentTestPropsMixin.$propKeys,
);
