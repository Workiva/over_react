// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'redux_multi_provider.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ReduxMultiProviderComponentFactory = registerComponent2(
  () => _$ReduxMultiProviderComponent(),
  builderFactory: _$ReduxMultiProvider,
  componentClass: ReduxMultiProviderComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$ReduxMultiProviderPropsAccessorsMixin
    implements _$ReduxMultiProviderProps {
  @override
  Map get props;

  /// A `Map` of contexts that connected components within the component tree
  /// can use to receive updates from specific stores.
  ///
  /// Each context and store instance should be unique. Referencing the context
  /// in a connected component is exactly the same as it would with a standard
  /// [ReduxProvider].
  ///
  /// <!-- Generated from [_$ReduxMultiProviderProps.storesByContext] -->
  @override
  Map<Context, Store> get storesByContext =>
      (props[_$key__storesByContext___$ReduxMultiProviderProps] ?? null)
          as Map<Context, Store>;

  /// A `Map` of contexts that connected components within the component tree
  /// can use to receive updates from specific stores.
  ///
  /// Each context and store instance should be unique. Referencing the context
  /// in a connected component is exactly the same as it would with a standard
  /// [ReduxProvider].
  ///
  /// <!-- Generated from [_$ReduxMultiProviderProps.storesByContext] -->
  @override
  set storesByContext(Map<Context, Store> value) =>
      props[_$key__storesByContext___$ReduxMultiProviderProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__storesByContext___$ReduxMultiProviderProps = PropDescriptor(
          _$key__storesByContext___$ReduxMultiProviderProps,
          isRequired: true,
          isNullable: true,
          isLate: true);
  static const String _$key__storesByContext___$ReduxMultiProviderProps =
      'ReduxMultiProviderProps.storesByContext';

  static const List<PropDescriptor> $props = [
    _$prop__storesByContext___$ReduxMultiProviderProps
  ];
  static const List<String> $propKeys = [
    _$key__storesByContext___$ReduxMultiProviderProps
  ];
}

const PropsMeta _$metaForReduxMultiProviderProps = PropsMeta(
  fields: _$ReduxMultiProviderPropsAccessorsMixin.$props,
  keys: _$ReduxMultiProviderPropsAccessorsMixin.$propKeys,
);

class ReduxMultiProviderProps extends _$ReduxMultiProviderProps
    with _$ReduxMultiProviderPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForReduxMultiProviderProps;
}

_$$ReduxMultiProviderProps _$ReduxMultiProvider([Map? backingProps]) =>
    backingProps == null
        ? _$$ReduxMultiProviderProps$JsMap(JsBackedMap())
        : _$$ReduxMultiProviderProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ReduxMultiProviderProps extends _$ReduxMultiProviderProps
    with _$ReduxMultiProviderPropsAccessorsMixin
    implements ReduxMultiProviderProps {
  _$$ReduxMultiProviderProps._();

  factory _$$ReduxMultiProviderProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ReduxMultiProviderProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ReduxMultiProviderProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ReduxMultiProviderComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ReduxMultiProviderProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ReduxMultiProviderProps(
          accessMap, (map) => _$$ReduxMultiProviderProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ReduxMultiProviderProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$ReduxMultiProviderProps$PlainMap extends _$$ReduxMultiProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxMultiProviderProps$PlainMap(Map? backingMap)
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
class _$$ReduxMultiProviderProps$JsMap extends _$$ReduxMultiProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxMultiProviderProps$JsMap(JsBackedMap? backingMap)
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
class _$ReduxMultiProviderComponent extends ReduxMultiProviderComponent {
  late _$$ReduxMultiProviderProps$JsMap _cachedTypedProps;

  @override
  _$$ReduxMultiProviderProps$JsMap get props => _cachedTypedProps;

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
  _$$ReduxMultiProviderProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ReduxMultiProviderProps$JsMap(backingMap);

  @override
  _$$ReduxMultiProviderProps typedPropsFactory(Map? backingMap) =>
      _$$ReduxMultiProviderProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ReduxMultiProvider';

  /// The default consumed props, taken from _$ReduxMultiProviderProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForReduxMultiProviderProps
  ];
}
