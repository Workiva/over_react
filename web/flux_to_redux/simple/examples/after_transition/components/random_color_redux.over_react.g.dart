// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'random_color_redux.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $RandomColorReduxComponentFactory = registerComponent2(
  () => _$RandomColorReduxComponent(),
  builderFactory: RandomColorRedux,
  componentClass: RandomColorReduxComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'RandomColorRedux',
);

abstract class _$RandomColorReduxPropsAccessorsMixin implements _$RandomColorReduxProps {
  @override
  Map get props;

  /// <!-- Generated from [_$RandomColorReduxProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$RandomColorReduxProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorReduxProps.backgroundColor] -->
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor___$RandomColorReduxProps] = value;

  /// <!-- Generated from [_$RandomColorReduxProps.changeBackgroundColor] -->
  @override
  Function get changeBackgroundColor =>
      props[_$key__changeBackgroundColor___$RandomColorReduxProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorReduxProps.changeBackgroundColor] -->
  @override
  set changeBackgroundColor(Function value) =>
      props[_$key__changeBackgroundColor___$RandomColorReduxProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor___$RandomColorReduxProps =
      PropDescriptor(_$key__backgroundColor___$RandomColorReduxProps);
  static const PropDescriptor _$prop__changeBackgroundColor___$RandomColorReduxProps =
      PropDescriptor(_$key__changeBackgroundColor___$RandomColorReduxProps);
  static const String _$key__backgroundColor___$RandomColorReduxProps =
      'RandomColorReduxProps.backgroundColor';
  static const String _$key__changeBackgroundColor___$RandomColorReduxProps =
      'RandomColorReduxProps.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$RandomColorReduxProps,
    _$prop__changeBackgroundColor___$RandomColorReduxProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$RandomColorReduxProps,
    _$key__changeBackgroundColor___$RandomColorReduxProps
  ];
}

const PropsMeta _$metaForRandomColorReduxProps = PropsMeta(
  fields: _$RandomColorReduxPropsAccessorsMixin.$props,
  keys: _$RandomColorReduxPropsAccessorsMixin.$propKeys,
);

class RandomColorReduxProps extends _$RandomColorReduxProps
    with _$RandomColorReduxPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForRandomColorReduxProps;
}

_$$RandomColorReduxProps _$RandomColorRedux([Map backingProps]) => backingProps == null
    ? _$$RandomColorReduxProps$JsMap(JsBackedMap())
    : _$$RandomColorReduxProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$RandomColorReduxProps extends _$RandomColorReduxProps
    with _$RandomColorReduxPropsAccessorsMixin
    implements RandomColorReduxProps {
  _$$RandomColorReduxProps._();

  factory _$$RandomColorReduxProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RandomColorReduxProps$JsMap(backingMap);
    } else {
      return _$$RandomColorReduxProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $RandomColorReduxComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'RandomColorReduxProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$RandomColorReduxProps$PlainMap extends _$$RandomColorReduxProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorReduxProps$PlainMap(Map backingMap)
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
class _$$RandomColorReduxProps$JsMap extends _$$RandomColorReduxProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorReduxProps$JsMap(JsBackedMap backingMap)
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
class _$RandomColorReduxComponent extends RandomColorReduxComponent {
  _$$RandomColorReduxProps$JsMap _cachedTypedProps;

  @override
  _$$RandomColorReduxProps$JsMap get props => _cachedTypedProps;

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
  _$$RandomColorReduxProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$RandomColorReduxProps$JsMap(backingMap);

  @override
  _$$RandomColorReduxProps typedPropsFactory(Map backingMap) =>
      _$$RandomColorReduxProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$RandomColorReduxProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForRandomColorReduxProps];
}
