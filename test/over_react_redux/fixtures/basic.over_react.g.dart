// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent2(
  () => new _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

abstract class _$BasicPropsAccessorsMixin implements _$BasicProps {
  @override
  Map get props;

  /// <!-- Generated from [_$BasicProps.propFromState] -->
  @override
  String get propFromState =>
      props[_$key__propFromState___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.propFromState] -->
  @override
  set propFromState(String value) =>
      props[_$key__propFromState___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.propFromOwnProps] -->
  @override
  String get propFromOwnProps =>
      props[_$key__propFromOwnProps___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.propFromOwnProps] -->
  @override
  set propFromOwnProps(String value) =>
      props[_$key__propFromOwnProps___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.propFromDispatch] -->
  @override
  String get propFromDispatch =>
      props[_$key__propFromDispatch___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.propFromDispatch] -->
  @override
  set propFromDispatch(String value) =>
      props[_$key__propFromDispatch___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.anything] -->
  @override
  dynamic get anything =>
      props[_$key__anything___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.anything] -->
  @override
  set anything(dynamic value) => props[_$key__anything___$BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__propFromState___$BasicProps =
      const PropDescriptor(_$key__propFromState___$BasicProps);
  static const PropDescriptor _$prop__propFromOwnProps___$BasicProps =
      const PropDescriptor(_$key__propFromOwnProps___$BasicProps);
  static const PropDescriptor _$prop__propFromDispatch___$BasicProps =
      const PropDescriptor(_$key__propFromDispatch___$BasicProps);
  static const PropDescriptor _$prop__anything___$BasicProps =
      const PropDescriptor(_$key__anything___$BasicProps);
  static const String _$key__propFromState___$BasicProps =
      'BasicProps.propFromState';
  static const String _$key__propFromOwnProps___$BasicProps =
      'BasicProps.propFromOwnProps';
  static const String _$key__propFromDispatch___$BasicProps =
      'BasicProps.propFromDispatch';
  static const String _$key__anything___$BasicProps = 'BasicProps.anything';

  static const List<PropDescriptor> $props = const [
    _$prop__propFromState___$BasicProps,
    _$prop__propFromOwnProps___$BasicProps,
    _$prop__propFromDispatch___$BasicProps,
    _$prop__anything___$BasicProps
  ];
  static const List<String> $propKeys = const [
    _$key__propFromState___$BasicProps,
    _$key__propFromOwnProps___$BasicProps,
    _$key__propFromDispatch___$BasicProps,
    _$key__anything___$BasicProps
  ];
}

const PropsMeta _$metaForBasicProps = const PropsMeta(
  fields: _$BasicPropsAccessorsMixin.$props,
  keys: _$BasicPropsAccessorsMixin.$propKeys,
);

class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicProps;
}

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? new _$$BasicProps$JsMap(new JsBackedMap())
    : new _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$BasicProps extends _$BasicProps
    with _$BasicPropsAccessorsMixin
    implements BasicProps {
  _$$BasicProps._();

  factory _$$BasicProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$BasicProps$JsMap(backingMap);
    } else {
      return new _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicProps$PlainMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$PlainMap(Map backingMap)
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
class _$$BasicProps$JsMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$BasicProps$JsMap(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) =>
      new _$$BasicProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
