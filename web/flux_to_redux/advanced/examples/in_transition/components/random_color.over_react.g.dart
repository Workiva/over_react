// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'random_color.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $RandomColorComponentFactory = registerComponent2(
  () => _$RandomColorComponent(),
  builderFactory: RandomColor,
  componentClass: RandomColorComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'RandomColor',
);

abstract class _$RandomColorPropsAccessorsMixin implements _$RandomColorProps {
  @override
  Map get props;

  /// <!-- Generated from [_$RandomColorProps.lowLevelStore] -->
  @override
  InTransitionLowLevelStore get lowLevelStore =>
      props[_$key__lowLevelStore___$RandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorProps.lowLevelStore] -->
  @override
  set lowLevelStore(InTransitionLowLevelStore value) =>
      props[_$key__lowLevelStore___$RandomColorProps] = value;

  /// <!-- Generated from [_$RandomColorProps.secondStore] -->
  @override
  InTransitionSecondStore get secondStore =>
      props[_$key__secondStore___$RandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorProps.secondStore] -->
  @override
  set secondStore(InTransitionSecondStore value) =>
      props[_$key__secondStore___$RandomColorProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__lowLevelStore___$RandomColorProps =
      PropDescriptor(_$key__lowLevelStore___$RandomColorProps);
  static const PropDescriptor _$prop__secondStore___$RandomColorProps =
      PropDescriptor(_$key__secondStore___$RandomColorProps);
  static const String _$key__lowLevelStore___$RandomColorProps = 'RandomColorProps.lowLevelStore';
  static const String _$key__secondStore___$RandomColorProps = 'RandomColorProps.secondStore';

  static const List<PropDescriptor> $props = [
    _$prop__lowLevelStore___$RandomColorProps,
    _$prop__secondStore___$RandomColorProps
  ];
  static const List<String> $propKeys = [
    _$key__lowLevelStore___$RandomColorProps,
    _$key__secondStore___$RandomColorProps
  ];
}

const PropsMeta _$metaForRandomColorProps = PropsMeta(
  fields: _$RandomColorPropsAccessorsMixin.$props,
  keys: _$RandomColorPropsAccessorsMixin.$propKeys,
);

_$$RandomColorProps _$RandomColor([Map backingProps]) => backingProps == null
    ? _$$RandomColorProps$JsMap(JsBackedMap())
    : _$$RandomColorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$RandomColorProps extends _$RandomColorProps
    with _$RandomColorPropsAccessorsMixin
    implements RandomColorProps {
  _$$RandomColorProps._();

  factory _$$RandomColorProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RandomColorProps$JsMap(backingMap);
    } else {
      return _$$RandomColorProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $RandomColorComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'RandomColorProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$RandomColorProps$PlainMap extends _$$RandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorProps$PlainMap(Map backingMap)
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
class _$$RandomColorProps$JsMap extends _$$RandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorProps$JsMap(JsBackedMap backingMap)
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
class _$RandomColorComponent extends RandomColorComponent {
  _$$RandomColorProps$JsMap _cachedTypedProps;

  @override
  _$$RandomColorProps$JsMap get props => _cachedTypedProps;

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
  _$$RandomColorProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$RandomColorProps$JsMap(backingMap);

  @override
  _$$RandomColorProps typedPropsFactory(Map backingMap) => _$$RandomColorProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$RandomColorProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForRandomColorProps];
}
