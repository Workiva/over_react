// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_component_2.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $Basic2ComponentFactory = registerComponent(() => new _$Basic2Component(),
    builderFactory: Basic2,
    componentClass: Basic2Component,
    isWrapper: false,
    parentType: null,
    displayName: 'Basic2');

abstract class _$Basic2PropsAccessorsMixin implements _$Basic2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$Basic2Props.basicProp] -->
  @override
  @deprecated
  @requiredProp
  String get basicProp =>
      props[_$key__basicProp___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basicProp] -->
  @override
  @deprecated
  @requiredProp
  set basicProp(String value) => props[_$key__basicProp___$Basic2Props] = value;

  /// <!-- Generated from [_$Basic2Props.basic1] -->
  @override
  String get basic1 =>
      props[_$key__basic1___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basic1] -->
  @override
  set basic1(String value) => props[_$key__basic1___$Basic2Props] = value;

  /// <!-- Generated from [_$Basic2Props.basic2] -->
  @override
  String get basic2 =>
      props[_$key__basic2___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basic2] -->
  @override
  set basic2(String value) => props[_$key__basic2___$Basic2Props] = value;

  /// <!-- Generated from [_$Basic2Props.basic3] -->
  @override
  String get basic3 =>
      props[_$key__basic3___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basic3] -->
  @override
  set basic3(String value) => props[_$key__basic3___$Basic2Props] = value;

  /// <!-- Generated from [_$Basic2Props.basic4] -->
  @override
  String get basic4 =>
      props[_$key__basic4___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basic4] -->
  @override
  set basic4(String value) => props[_$key__basic4___$Basic2Props] = value;

  /// <!-- Generated from [_$Basic2Props.basic5] -->
  @override
  String get basic5 =>
      props[_$key__basic5___$Basic2Props] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$Basic2Props.basic5] -->
  @override
  set basic5(String value) => props[_$key__basic5___$Basic2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp___$Basic2Props =
      const PropDescriptor(_$key__basicProp___$Basic2Props, isRequired: true);
  static const PropDescriptor _$prop__basic1___$Basic2Props =
      const PropDescriptor(_$key__basic1___$Basic2Props);
  static const PropDescriptor _$prop__basic2___$Basic2Props =
      const PropDescriptor(_$key__basic2___$Basic2Props);
  static const PropDescriptor _$prop__basic3___$Basic2Props =
      const PropDescriptor(_$key__basic3___$Basic2Props);
  static const PropDescriptor _$prop__basic4___$Basic2Props =
      const PropDescriptor(_$key__basic4___$Basic2Props);
  static const PropDescriptor _$prop__basic5___$Basic2Props =
      const PropDescriptor(_$key__basic5___$Basic2Props);
  static const String _$key__basicProp___$Basic2Props = 'Basic2Props.basicProp';
  static const String _$key__basic1___$Basic2Props = 'Basic2Props.basic1';
  static const String _$key__basic2___$Basic2Props = 'Basic2Props.basic2';
  static const String _$key__basic3___$Basic2Props = 'Basic2Props.basic3';
  static const String _$key__basic4___$Basic2Props = 'Basic2Props.basic4';
  static const String _$key__basic5___$Basic2Props = 'Basic2Props.basic5';

  static const List<PropDescriptor> $props = const [
    _$prop__basicProp___$Basic2Props,
    _$prop__basic1___$Basic2Props,
    _$prop__basic2___$Basic2Props,
    _$prop__basic3___$Basic2Props,
    _$prop__basic4___$Basic2Props,
    _$prop__basic5___$Basic2Props
  ];
  static const List<String> $propKeys = const [
    _$key__basicProp___$Basic2Props,
    _$key__basic1___$Basic2Props,
    _$key__basic2___$Basic2Props,
    _$key__basic3___$Basic2Props,
    _$key__basic4___$Basic2Props,
    _$key__basic5___$Basic2Props
  ];
}

const PropsMeta _$metaForBasic2Props = const PropsMeta(
  fields: _$Basic2PropsAccessorsMixin.$props,
  keys: _$Basic2PropsAccessorsMixin.$propKeys,
);

class Basic2Props extends _$Basic2Props with _$Basic2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasic2Props;
}

_$$Basic2Props _$Basic2([Map backingProps]) => backingProps == null
    ? new _$$Basic2Props$JsMap(new JsBackedMap())
    : new _$$Basic2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$Basic2Props extends _$Basic2Props
    with _$Basic2PropsAccessorsMixin
    implements Basic2Props {
  _$$Basic2Props._();

  factory _$$Basic2Props(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$Basic2Props$JsMap(backingMap);
    } else {
      return new _$$Basic2Props$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $Basic2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'Basic2Props.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$Basic2Props$PlainMap extends _$$Basic2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Basic2Props$PlainMap(Map backingMap)
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
class _$$Basic2Props$JsMap extends _$$Basic2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Basic2Props$JsMap(JsBackedMap backingMap)
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
class _$Basic2Component extends Basic2Component {
  _$$Basic2Props$JsMap _cachedTypedProps;

  @override
  _$$Basic2Props$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$Basic2Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$Basic2Props$JsMap(backingMap);

  @override
  _$$Basic2Props typedPropsFactory(Map backingMap) =>
      new _$$Basic2Props(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$Basic2Props.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasic2Props
  ];
}
