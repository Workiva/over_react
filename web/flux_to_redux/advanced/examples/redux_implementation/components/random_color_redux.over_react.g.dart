// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'random_color_redux.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $RandomColorReduxComponentFactory = registerComponent2(
  () => _$RandomColorReduxComponent(),
  builderFactory: _$RandomColorRedux,
  componentClass: RandomColorReduxComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'RandomColorRedux',
);

_$$RandomColorReduxProps _$RandomColorRedux([Map backingProps]) =>
    backingProps == null
        ? _$$RandomColorReduxProps$JsMap(JsBackedMap())
        : _$$RandomColorReduxProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$RandomColorReduxProps extends UiProps
    with
        RandomColorReduxPropsMixin,
        $RandomColorReduxPropsMixin, // If this generated mixin is undefined, it's likely because RandomColorReduxPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RandomColorReduxPropsMixin.
        ConnectPropsMixin,
        $ConnectPropsMixin // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectPropsMixin.
    implements
        RandomColorReduxProps {
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
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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

  /// The default consumed props, taken from RandomColorReduxProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because RandomColorReduxPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of RandomColorReduxPropsMixin.
        RandomColorReduxPropsMixin: $RandomColorReduxPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ConnectPropsMixin.
        ConnectPropsMixin: $ConnectPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $RandomColorReduxPropsMixin on RandomColorReduxPropsMixin {
  static const PropsMeta meta = _$metaForRandomColorReduxPropsMixin;
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor__RandomColorReduxPropsMixin] = value;
  @override
  String get blockTwoBackgroundColor =>
      props[_$key__blockTwoBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set blockTwoBackgroundColor(String value) =>
      props[_$key__blockTwoBackgroundColor__RandomColorReduxPropsMixin] = value;
  @override
  String get blockThreeBackgroundColor =>
      props[_$key__blockThreeBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set blockThreeBackgroundColor(String value) =>
      props[_$key__blockThreeBackgroundColor__RandomColorReduxPropsMixin] =
          value;
  @override
  String get blockOneBackgroundColor =>
      props[_$key__blockOneBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set blockOneBackgroundColor(String value) =>
      props[_$key__blockOneBackgroundColor__RandomColorReduxPropsMixin] = value;
  @override
  void Function() get changeMainBackgroundColor =>
      props[_$key__changeMainBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set changeMainBackgroundColor(void Function() value) =>
      props[_$key__changeMainBackgroundColor__RandomColorReduxPropsMixin] =
          value;
  @override
  void Function() get changeBlockOneBackgroundColor =>
      props[_$key__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set changeBlockOneBackgroundColor(void Function() value) =>
      props[_$key__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin] =
          value;
  @override
  void Function() get changeBlockTwoBackgroundColor =>
      props[_$key__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set changeBlockTwoBackgroundColor(void Function() value) =>
      props[_$key__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin] =
          value;
  @override
  void Function() get changeBlockThreeBackgroundColor =>
      props[
          _$key__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set changeBlockThreeBackgroundColor(void Function() value) => props[
          _$key__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__backgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(_$key__backgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__blockTwoBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__blockTwoBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__blockThreeBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__blockThreeBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__blockOneBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__blockOneBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__changeMainBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__changeMainBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin);
  static const PropDescriptor
      _$prop__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin =
      PropDescriptor(
          _$key__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin);
  static const String _$key__backgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.backgroundColor';
  static const String
      _$key__blockTwoBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.blockTwoBackgroundColor';
  static const String
      _$key__blockThreeBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.blockThreeBackgroundColor';
  static const String
      _$key__blockOneBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.blockOneBackgroundColor';
  static const String
      _$key__changeMainBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.changeMainBackgroundColor';
  static const String
      _$key__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.changeBlockOneBackgroundColor';
  static const String
      _$key__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.changeBlockTwoBackgroundColor';
  static const String
      _$key__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin =
      'RandomColorReduxPropsMixin.changeBlockThreeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor__RandomColorReduxPropsMixin,
    _$prop__blockTwoBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__blockThreeBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__blockOneBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__changeMainBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin,
    _$prop__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor__RandomColorReduxPropsMixin,
    _$key__blockTwoBackgroundColor__RandomColorReduxPropsMixin,
    _$key__blockThreeBackgroundColor__RandomColorReduxPropsMixin,
    _$key__blockOneBackgroundColor__RandomColorReduxPropsMixin,
    _$key__changeMainBackgroundColor__RandomColorReduxPropsMixin,
    _$key__changeBlockOneBackgroundColor__RandomColorReduxPropsMixin,
    _$key__changeBlockTwoBackgroundColor__RandomColorReduxPropsMixin,
    _$key__changeBlockThreeBackgroundColor__RandomColorReduxPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForRandomColorReduxPropsMixin = PropsMeta(
  fields: $RandomColorReduxPropsMixin.$props,
  keys: $RandomColorReduxPropsMixin.$propKeys,
);
