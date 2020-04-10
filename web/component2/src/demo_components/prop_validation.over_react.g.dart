// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'prop_validation.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $PropTypesTestComponentFactory = registerComponent2(
  () => _$PropTypesTestComponent(),
  builderFactory: _$PropTypesTest,
  componentClass: PropTypesTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'PropTypesTest',
);

_$$PropTypesTestProps _$PropTypesTest([Map backingProps]) =>
    backingProps == null
        ? _$$PropTypesTestProps$JsMap(JsBackedMap())
        : _$$PropTypesTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$PropTypesTestProps extends UiProps
    with
        PropTypesTestProps,
        $PropTypesTestProps // If this generated mixin is undefined, it's likely because PropTypesTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of PropTypesTestProps.
{
  _$$PropTypesTestProps._();

  factory _$$PropTypesTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PropTypesTestProps$JsMap(backingMap);
    } else {
      return _$$PropTypesTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PropTypesTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PropTypesTestProps$PlainMap extends _$$PropTypesTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesTestProps$PlainMap(Map backingMap)
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
class _$$PropTypesTestProps$JsMap extends _$$PropTypesTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesTestProps$JsMap(JsBackedMap backingMap)
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
class _$PropTypesTestComponent extends PropTypesTestComponent {
  _$$PropTypesTestProps$JsMap _cachedTypedProps;

  @override
  _$$PropTypesTestProps$JsMap get props => _cachedTypedProps;

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
  _$$PropTypesTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PropTypesTestProps$JsMap(backingMap);

  @override
  _$$PropTypesTestProps typedPropsFactory(Map backingMap) =>
      _$$PropTypesTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from PropTypesTestProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(PropTypesTestProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because PropTypesTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of PropTypesTestProps.
        PropTypesTestProps: $PropTypesTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $PropTypesTestProps on PropTypesTestProps {
  static const PropsMeta meta = _$metaForPropTypesTestProps;
  @override
  int get count =>
      props[_$key__count__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set count(int value) => props[_$key__count__PropTypesTestProps] = value;
  @override
  List get twoObjects =>
      props[_$key__twoObjects__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set twoObjects(List value) =>
      props[_$key__twoObjects__PropTypesTestProps] = value;
  @override
  int get defaultCount =>
      props[_$key__defaultCount__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set defaultCount(int value) =>
      props[_$key__defaultCount__PropTypesTestProps] = value;
  @override
  bool get content =>
      props[_$key__content__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set content(bool value) => props[_$key__content__PropTypesTestProps] = value;
  @override
  bool get hideHeader =>
      props[_$key__hideHeader__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set hideHeader(bool value) =>
      props[_$key__hideHeader__PropTypesTestProps] = value;
  @override
  dynamic get header =>
      props[_$key__header__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set header(dynamic value) => props[_$key__header__PropTypesTestProps] = value;
  @override
  List get initiallyExpandedKeys =>
      props[_$key__initiallyExpandedKeys__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set initiallyExpandedKeys(List value) =>
      props[_$key__initiallyExpandedKeys__PropTypesTestProps] = value;
  @override
  dynamic get targetKey =>
      props[_$key__targetKey__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set targetKey(dynamic value) =>
      props[_$key__targetKey__PropTypesTestProps] = value;
  @override
  bool get hideLabel =>
      props[_$key__hideLabel__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set hideLabel(bool value) =>
      props[_$key__hideLabel__PropTypesTestProps] = value;
  @override
  String get label =>
      props[_$key__label__PropTypesTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set label(String value) => props[_$key__label__PropTypesTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__count__PropTypesTestProps =
      PropDescriptor(_$key__count__PropTypesTestProps);
  static const PropDescriptor _$prop__twoObjects__PropTypesTestProps =
      PropDescriptor(_$key__twoObjects__PropTypesTestProps);
  static const PropDescriptor _$prop__defaultCount__PropTypesTestProps =
      PropDescriptor(_$key__defaultCount__PropTypesTestProps);
  static const PropDescriptor _$prop__content__PropTypesTestProps =
      PropDescriptor(_$key__content__PropTypesTestProps);
  static const PropDescriptor _$prop__hideHeader__PropTypesTestProps =
      PropDescriptor(_$key__hideHeader__PropTypesTestProps);
  static const PropDescriptor _$prop__header__PropTypesTestProps =
      PropDescriptor(_$key__header__PropTypesTestProps);
  static const PropDescriptor
      _$prop__initiallyExpandedKeys__PropTypesTestProps =
      PropDescriptor(_$key__initiallyExpandedKeys__PropTypesTestProps);
  static const PropDescriptor _$prop__targetKey__PropTypesTestProps =
      PropDescriptor(_$key__targetKey__PropTypesTestProps);
  static const PropDescriptor _$prop__hideLabel__PropTypesTestProps =
      PropDescriptor(_$key__hideLabel__PropTypesTestProps);
  static const PropDescriptor _$prop__label__PropTypesTestProps =
      PropDescriptor(_$key__label__PropTypesTestProps);
  static const String _$key__count__PropTypesTestProps =
      'PropTypesTestProps.count';
  static const String _$key__twoObjects__PropTypesTestProps =
      'PropTypesTestProps.twoObjects';
  static const String _$key__defaultCount__PropTypesTestProps =
      'PropTypesTestProps.defaultCount';
  static const String _$key__content__PropTypesTestProps =
      'PropTypesTestProps.content';
  static const String _$key__hideHeader__PropTypesTestProps =
      'PropTypesTestProps.hideHeader';
  static const String _$key__header__PropTypesTestProps =
      'PropTypesTestProps.header';
  static const String _$key__initiallyExpandedKeys__PropTypesTestProps =
      'PropTypesTestProps.initiallyExpandedKeys';
  static const String _$key__targetKey__PropTypesTestProps =
      'PropTypesTestProps.targetKey';
  static const String _$key__hideLabel__PropTypesTestProps =
      'PropTypesTestProps.hideLabel';
  static const String _$key__label__PropTypesTestProps =
      'PropTypesTestProps.label';

  static const List<PropDescriptor> $props = [
    _$prop__count__PropTypesTestProps,
    _$prop__twoObjects__PropTypesTestProps,
    _$prop__defaultCount__PropTypesTestProps,
    _$prop__content__PropTypesTestProps,
    _$prop__hideHeader__PropTypesTestProps,
    _$prop__header__PropTypesTestProps,
    _$prop__initiallyExpandedKeys__PropTypesTestProps,
    _$prop__targetKey__PropTypesTestProps,
    _$prop__hideLabel__PropTypesTestProps,
    _$prop__label__PropTypesTestProps
  ];
  static const List<String> $propKeys = [
    _$key__count__PropTypesTestProps,
    _$key__twoObjects__PropTypesTestProps,
    _$key__defaultCount__PropTypesTestProps,
    _$key__content__PropTypesTestProps,
    _$key__hideHeader__PropTypesTestProps,
    _$key__header__PropTypesTestProps,
    _$key__initiallyExpandedKeys__PropTypesTestProps,
    _$key__targetKey__PropTypesTestProps,
    _$key__hideLabel__PropTypesTestProps,
    _$key__label__PropTypesTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForPropTypesTestProps = PropsMeta(
  fields: $PropTypesTestProps.$props,
  keys: $PropTypesTestProps.$propKeys,
);
