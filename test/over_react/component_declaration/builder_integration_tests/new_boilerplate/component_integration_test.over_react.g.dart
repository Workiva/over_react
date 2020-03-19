// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ComponentTestComponentFactory = registerComponent2(
  () => _$ComponentTestComponent(),
  builderFactory: ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ComponentTest',
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
        ComponentTestProps,
        $ComponentTestProps // If this generated mixin is undefined, it's likely because ComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ComponentTestProps.
{
  _$$ComponentTestProps._();

  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ComponentTestProps$JsMap(backingMap);
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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
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

  /// The default consumed props, taken from ComponentTestProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(ComponentTestProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ComponentTestProps.
        ComponentTestProps: $ComponentTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ComponentTestProps on ComponentTestProps {
  static const PropsMeta meta = _$metaForComponentTestProps;
  @override
  String get stringProp =>
      props[_$key__stringProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set stringProp(String value) =>
      props[_$key__stringProp__ComponentTestProps] = value;
  @override
  bool get shouldSetPropsDirectly =>
      props[_$key__shouldSetPropsDirectly__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set shouldSetPropsDirectly(bool value) =>
      props[_$key__shouldSetPropsDirectly__ComponentTestProps] = value;
  @override
  bool get shouldUseJsFactory =>
      props[_$key__shouldUseJsFactory__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set shouldUseJsFactory(bool value) =>
      props[_$key__shouldUseJsFactory__ComponentTestProps] = value;
  @override
  dynamic get dynamicProp =>
      props[_$key__dynamicProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set dynamicProp(dynamic value) =>
      props[_$key__dynamicProp__ComponentTestProps] = value;
  @override
  get untypedProp =>
      props[_$key__untypedProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set untypedProp(value) =>
      props[_$key__untypedProp__ComponentTestProps] = value;
  @override
  dynamic get customKeyProp =>
      props[_$key__customKeyProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set customKeyProp(dynamic value) =>
      props[_$key__customKeyProp__ComponentTestProps] = value;
  @override
  dynamic get customNamespaceProp =>
      props[_$key__customNamespaceProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set customNamespaceProp(dynamic value) =>
      props[_$key__customNamespaceProp__ComponentTestProps] = value;
  @override
  dynamic get customKeyAndNamespaceProp =>
      props[_$key__customKeyAndNamespaceProp__ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set customKeyAndNamespaceProp(dynamic value) =>
      props[_$key__customKeyAndNamespaceProp__ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp__ComponentTestProps =
      PropDescriptor(_$key__stringProp__ComponentTestProps);
  static const PropDescriptor
      _$prop__shouldSetPropsDirectly__ComponentTestProps =
      PropDescriptor(_$key__shouldSetPropsDirectly__ComponentTestProps);
  static const PropDescriptor _$prop__shouldUseJsFactory__ComponentTestProps =
      PropDescriptor(_$key__shouldUseJsFactory__ComponentTestProps);
  static const PropDescriptor _$prop__dynamicProp__ComponentTestProps =
      PropDescriptor(_$key__dynamicProp__ComponentTestProps);
  static const PropDescriptor _$prop__untypedProp__ComponentTestProps =
      PropDescriptor(_$key__untypedProp__ComponentTestProps);
  static const PropDescriptor _$prop__customKeyProp__ComponentTestProps =
      PropDescriptor(_$key__customKeyProp__ComponentTestProps);
  static const PropDescriptor _$prop__customNamespaceProp__ComponentTestProps =
      PropDescriptor(_$key__customNamespaceProp__ComponentTestProps);
  static const PropDescriptor
      _$prop__customKeyAndNamespaceProp__ComponentTestProps =
      PropDescriptor(_$key__customKeyAndNamespaceProp__ComponentTestProps);
  static const String _$key__stringProp__ComponentTestProps =
      'ComponentTestProps.stringProp';
  static const String _$key__shouldSetPropsDirectly__ComponentTestProps =
      'ComponentTestProps.shouldSetPropsDirectly';
  static const String _$key__shouldUseJsFactory__ComponentTestProps =
      'ComponentTestProps.shouldUseJsFactory';
  static const String _$key__dynamicProp__ComponentTestProps =
      'ComponentTestProps.dynamicProp';
  static const String _$key__untypedProp__ComponentTestProps =
      'ComponentTestProps.untypedProp';
  static const String _$key__customKeyProp__ComponentTestProps =
      'ComponentTestProps.custom key!';
  static const String _$key__customNamespaceProp__ComponentTestProps =
      'custom namespace~~customNamespaceProp';
  static const String _$key__customKeyAndNamespaceProp__ComponentTestProps =
      'custom namespace~~custom key!';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp__ComponentTestProps,
    _$prop__shouldSetPropsDirectly__ComponentTestProps,
    _$prop__shouldUseJsFactory__ComponentTestProps,
    _$prop__dynamicProp__ComponentTestProps,
    _$prop__untypedProp__ComponentTestProps,
    _$prop__customKeyProp__ComponentTestProps,
    _$prop__customNamespaceProp__ComponentTestProps,
    _$prop__customKeyAndNamespaceProp__ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__stringProp__ComponentTestProps,
    _$key__shouldSetPropsDirectly__ComponentTestProps,
    _$key__shouldUseJsFactory__ComponentTestProps,
    _$key__dynamicProp__ComponentTestProps,
    _$key__untypedProp__ComponentTestProps,
    _$key__customKeyProp__ComponentTestProps,
    _$key__customNamespaceProp__ComponentTestProps,
    _$key__customKeyAndNamespaceProp__ComponentTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForComponentTestProps = PropsMeta(
  fields: $ComponentTestProps.$props,
  keys: $ComponentTestProps.$propKeys,
);

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $IsErrorBoundaryComponentFactory = registerComponent2(
  () => _$IsErrorBoundaryComponent(),
  builderFactory: IsErrorBoundary,
  componentClass: IsErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'IsErrorBoundary',
  skipMethods: const [],
);

_$$IsErrorBoundaryProps _$IsErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? _$$IsErrorBoundaryProps$JsMap(JsBackedMap())
        : _$$IsErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$IsErrorBoundaryProps extends UiProps
    with
        IsErrorBoundaryProps,
        $IsErrorBoundaryProps // If this generated mixin is undefined, it's likely because IsErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of IsErrorBoundaryProps.
{
  _$$IsErrorBoundaryProps._();

  factory _$$IsErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$IsErrorBoundaryProps$JsMap(backingMap);
    } else {
      return _$$IsErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $IsErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$IsErrorBoundaryProps$PlainMap extends _$$IsErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsErrorBoundaryProps$PlainMap(Map backingMap)
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
class _$$IsErrorBoundaryProps$JsMap extends _$$IsErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsErrorBoundaryProps$JsMap(JsBackedMap backingMap)
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
class _$IsErrorBoundaryComponent extends IsErrorBoundaryComponent {
  _$$IsErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$IsErrorBoundaryProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$IsErrorBoundaryProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$IsErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$IsErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$IsErrorBoundaryProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from IsErrorBoundaryProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(IsErrorBoundaryProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because IsErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of IsErrorBoundaryProps.
        IsErrorBoundaryProps: $IsErrorBoundaryProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $IsErrorBoundaryProps on IsErrorBoundaryProps {
  static const PropsMeta meta = _$metaForIsErrorBoundaryProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForIsErrorBoundaryProps = PropsMeta(
  fields: $IsErrorBoundaryProps.$props,
  keys: $IsErrorBoundaryProps.$propKeys,
);

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $IsNotErrorBoundaryComponentFactory = registerComponent2(
  () => _$IsNotErrorBoundaryComponent(),
  builderFactory: IsNotErrorBoundary,
  componentClass: IsNotErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'IsNotErrorBoundary',
);

_$$IsNotErrorBoundaryProps _$IsNotErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? _$$IsNotErrorBoundaryProps$JsMap(JsBackedMap())
        : _$$IsNotErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$IsNotErrorBoundaryProps extends UiProps
    with
        IsNotErrorBoundaryProps,
        $IsNotErrorBoundaryProps // If this generated mixin is undefined, it's likely because IsNotErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of IsNotErrorBoundaryProps.
{
  _$$IsNotErrorBoundaryProps._();

  factory _$$IsNotErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$IsNotErrorBoundaryProps$JsMap(backingMap);
    } else {
      return _$$IsNotErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $IsNotErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$IsNotErrorBoundaryProps$PlainMap extends _$$IsNotErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsNotErrorBoundaryProps$PlainMap(Map backingMap)
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
class _$$IsNotErrorBoundaryProps$JsMap extends _$$IsNotErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsNotErrorBoundaryProps$JsMap(JsBackedMap backingMap)
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
class _$IsNotErrorBoundaryComponent extends IsNotErrorBoundaryComponent {
  _$$IsNotErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$IsNotErrorBoundaryProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$IsNotErrorBoundaryProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$IsNotErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$IsNotErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$IsNotErrorBoundaryProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from IsNotErrorBoundaryProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(IsNotErrorBoundaryProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because IsNotErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of IsNotErrorBoundaryProps.
        IsNotErrorBoundaryProps: $IsNotErrorBoundaryProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $IsNotErrorBoundaryProps on IsNotErrorBoundaryProps {
  static const PropsMeta meta = _$metaForIsNotErrorBoundaryProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForIsNotErrorBoundaryProps = PropsMeta(
  fields: $IsNotErrorBoundaryProps.$props,
  keys: $IsNotErrorBoundaryProps.$propKeys,
);
