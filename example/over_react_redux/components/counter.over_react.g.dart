// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $CounterComponentFactory = registerComponent2(
  () => new _$CounterComponent(),
  builderFactory: Counter,
  componentClass: CounterComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Counter',
);

abstract class _$CounterPropsAccessorsMixin implements _$CounterProps {
  @override
  Map get props;

  /// <!-- Generated from [_$CounterProps.intProp] -->
  @override
  int get intProp =>
      props[_$key__intProp___$CounterProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$CounterProps.intProp] -->
  @override
  set intProp(int value) => props[_$key__intProp___$CounterProps] = value;

  /// <!-- Generated from [_$CounterProps.customStyles] -->
  @override
  Map<String, dynamic> get customStyles =>
      props[_$key__customStyles___$CounterProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$CounterProps.customStyles] -->
  @override
  set customStyles(Map<String, dynamic> value) =>
      props[_$key__customStyles___$CounterProps] = value;

  /// <!-- Generated from [_$CounterProps.dispatcherProp] -->
  @override
  void Function(dynamic action) get dispatcherProp =>
      props[_$key__dispatcherProp___$CounterProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$CounterProps.dispatcherProp] -->
  @override
  set dispatcherProp(void Function(dynamic action) value) =>
      props[_$key__dispatcherProp___$CounterProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__intProp___$CounterProps =
      const PropDescriptor(_$key__intProp___$CounterProps);
  static const PropDescriptor _$prop__customStyles___$CounterProps =
      const PropDescriptor(_$key__customStyles___$CounterProps);
  static const PropDescriptor _$prop__dispatcherProp___$CounterProps =
      const PropDescriptor(_$key__dispatcherProp___$CounterProps);
  static const String _$key__intProp___$CounterProps = 'CounterProps.intProp';
  static const String _$key__customStyles___$CounterProps =
      'CounterProps.customStyles';
  static const String _$key__dispatcherProp___$CounterProps =
      'CounterProps.dispatcherProp';

  static const List<PropDescriptor> $props = const [
    _$prop__intProp___$CounterProps,
    _$prop__customStyles___$CounterProps,
    _$prop__dispatcherProp___$CounterProps
  ];
  static const List<String> $propKeys = const [
    _$key__intProp___$CounterProps,
    _$key__customStyles___$CounterProps,
    _$key__dispatcherProp___$CounterProps
  ];
}

const PropsMeta _$metaForCounterProps = const PropsMeta(
  fields: _$CounterPropsAccessorsMixin.$props,
  keys: _$CounterPropsAccessorsMixin.$propKeys,
);

class CounterProps extends _$CounterProps with _$CounterPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForCounterProps;
}

_$$CounterProps _$Counter([Map backingProps]) => backingProps == null
    ? new _$$CounterProps$JsMap(new JsBackedMap())
    : new _$$CounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$CounterProps extends _$CounterProps
    with _$CounterPropsAccessorsMixin
    implements CounterProps {
  _$$CounterProps._();

  factory _$$CounterProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$CounterProps$JsMap(backingMap);
    } else {
      return new _$$CounterProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CounterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'CounterProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$CounterProps$PlainMap extends _$$CounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CounterProps$PlainMap(Map backingMap)
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
class _$$CounterProps$JsMap extends _$$CounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CounterProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
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
class _$CounterComponent extends CounterComponent {
  _$$CounterProps$JsMap _cachedTypedProps;

  @override
  _$$CounterProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$CounterProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$CounterProps$JsMap(backingMap);

  @override
  _$$CounterProps typedPropsFactory(Map backingMap) =>
      new _$$CounterProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$CounterProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForCounterProps
  ];
}
