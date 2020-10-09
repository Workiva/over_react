// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'progress.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ProgressComponentFactory = registerComponent2(
  () => _$ProgressComponent(),
  builderFactory: _$Progress,
  componentClass: ProgressComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Progress',
);

_$$ProgressProps _$Progress([Map backingProps]) => backingProps == null
    ? _$$ProgressProps$JsMap(JsBackedMap())
    : _$$ProgressProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ProgressProps extends UiProps
    with
        ProgressProps,
        $ProgressProps // If this generated mixin is undefined, it's likely because ProgressProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ProgressProps, and check that $ProgressProps is exported/imported properly.
{
  _$$ProgressProps._();

  factory _$$ProgressProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ProgressProps$JsMap(backingMap);
    } else {
      return _$$ProgressProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ProgressComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsInstanceMeta get $meta => PropsInstanceMeta({
        // If this generated mixin is undefined, it's likely because ProgressProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ProgressProps, and check that $ProgressProps is exported/imported properly.
        ProgressProps: $ProgressProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ProgressProps$PlainMap extends _$$ProgressProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProgressProps$PlainMap(Map backingMap)
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
class _$$ProgressProps$JsMap extends _$$ProgressProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProgressProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ProgressState extends UiState
    with
        ProgressState,
        $ProgressState // If this generated mixin is undefined, it's likely because ProgressState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of ProgressState, and check that $ProgressState is exported/imported properly.
{
  _$$ProgressState._();

  factory _$$ProgressState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ProgressState$JsMap(backingMap);
    } else {
      return _$$ProgressState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ProgressState$PlainMap extends _$$ProgressState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProgressState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ProgressState$JsMap extends _$$ProgressState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProgressState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ProgressComponent extends ProgressComponent {
  _$$ProgressProps$JsMap _cachedTypedProps;

  @override
  _$$ProgressProps$JsMap get props => _cachedTypedProps;

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
  _$$ProgressProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ProgressProps$JsMap(backingMap);

  @override
  _$$ProgressProps typedPropsFactory(Map backingMap) =>
      _$$ProgressProps(backingMap);

  _$$ProgressState$JsMap _cachedTypedState;
  @override
  _$$ProgressState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$ProgressState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ProgressState$JsMap(backingMap);

  @override
  _$$ProgressState typedStateFactory(Map backingMap) =>
      _$$ProgressState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ProgressProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ProgressProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ProgressProps, and check that $ProgressProps is exported/imported properly.
        ProgressProps: $ProgressProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ProgressProps on ProgressProps {
  static const PropsMeta meta = _$metaForProgressProps;
  @override
  double get value =>
      props[_$key__value__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set value(double value) => props[_$key__value__ProgressProps] = value;
  @override
  double get min =>
      props[_$key__min__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set min(double value) => props[_$key__min__ProgressProps] = value;
  @override
  double get max =>
      props[_$key__max__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set max(double value) => props[_$key__max__ProgressProps] = value;
  @override
  ProgressSkin get skin =>
      props[_$key__skin__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set skin(ProgressSkin value) => props[_$key__skin__ProgressProps] = value;
  @override
  bool get isStriped =>
      props[_$key__isStriped__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isStriped(bool value) => props[_$key__isStriped__ProgressProps] = value;
  @override
  bool get isAnimated =>
      props[_$key__isAnimated__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isAnimated(bool value) => props[_$key__isAnimated__ProgressProps] = value;
  @override
  String get caption =>
      props[_$key__caption__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set caption(String value) => props[_$key__caption__ProgressProps] = value;
  @override
  Map get captionProps =>
      props[_$key__captionProps__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set captionProps(Map value) =>
      props[_$key__captionProps__ProgressProps] = value;
  @override
  bool get showCaption =>
      props[_$key__showCaption__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set showCaption(bool value) =>
      props[_$key__showCaption__ProgressProps] = value;
  @override
  bool get showPercentComplete =>
      props[_$key__showPercentComplete__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set showPercentComplete(bool value) =>
      props[_$key__showPercentComplete__ProgressProps] = value;
  @override
  Map get rootNodeProps =>
      props[_$key__rootNodeProps__ProgressProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set rootNodeProps(Map value) =>
      props[_$key__rootNodeProps__ProgressProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__value__ProgressProps =
      PropDescriptor(_$key__value__ProgressProps);
  static const PropDescriptor _$prop__min__ProgressProps =
      PropDescriptor(_$key__min__ProgressProps);
  static const PropDescriptor _$prop__max__ProgressProps =
      PropDescriptor(_$key__max__ProgressProps);
  static const PropDescriptor _$prop__skin__ProgressProps =
      PropDescriptor(_$key__skin__ProgressProps);
  static const PropDescriptor _$prop__isStriped__ProgressProps =
      PropDescriptor(_$key__isStriped__ProgressProps);
  static const PropDescriptor _$prop__isAnimated__ProgressProps =
      PropDescriptor(_$key__isAnimated__ProgressProps);
  static const PropDescriptor _$prop__caption__ProgressProps =
      PropDescriptor(_$key__caption__ProgressProps);
  static const PropDescriptor _$prop__captionProps__ProgressProps =
      PropDescriptor(_$key__captionProps__ProgressProps);
  static const PropDescriptor _$prop__showCaption__ProgressProps =
      PropDescriptor(_$key__showCaption__ProgressProps);
  static const PropDescriptor _$prop__showPercentComplete__ProgressProps =
      PropDescriptor(_$key__showPercentComplete__ProgressProps);
  static const PropDescriptor _$prop__rootNodeProps__ProgressProps =
      PropDescriptor(_$key__rootNodeProps__ProgressProps);
  static const String _$key__value__ProgressProps = 'ProgressProps.value';
  static const String _$key__min__ProgressProps = 'ProgressProps.min';
  static const String _$key__max__ProgressProps = 'ProgressProps.max';
  static const String _$key__skin__ProgressProps = 'ProgressProps.skin';
  static const String _$key__isStriped__ProgressProps =
      'ProgressProps.isStriped';
  static const String _$key__isAnimated__ProgressProps =
      'ProgressProps.isAnimated';
  static const String _$key__caption__ProgressProps = 'ProgressProps.caption';
  static const String _$key__captionProps__ProgressProps =
      'ProgressProps.captionProps';
  static const String _$key__showCaption__ProgressProps =
      'ProgressProps.showCaption';
  static const String _$key__showPercentComplete__ProgressProps =
      'ProgressProps.showPercentComplete';
  static const String _$key__rootNodeProps__ProgressProps =
      'ProgressProps.rootNodeProps';

  static const List<PropDescriptor> $props = [
    _$prop__value__ProgressProps,
    _$prop__min__ProgressProps,
    _$prop__max__ProgressProps,
    _$prop__skin__ProgressProps,
    _$prop__isStriped__ProgressProps,
    _$prop__isAnimated__ProgressProps,
    _$prop__caption__ProgressProps,
    _$prop__captionProps__ProgressProps,
    _$prop__showCaption__ProgressProps,
    _$prop__showPercentComplete__ProgressProps,
    _$prop__rootNodeProps__ProgressProps
  ];
  static const List<String> $propKeys = [
    _$key__value__ProgressProps,
    _$key__min__ProgressProps,
    _$key__max__ProgressProps,
    _$key__skin__ProgressProps,
    _$key__isStriped__ProgressProps,
    _$key__isAnimated__ProgressProps,
    _$key__caption__ProgressProps,
    _$key__captionProps__ProgressProps,
    _$key__showCaption__ProgressProps,
    _$key__showPercentComplete__ProgressProps,
    _$key__rootNodeProps__ProgressProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForProgressProps = PropsMeta(
  fields: $ProgressProps.$props,
  keys: $ProgressProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ProgressState on ProgressState {
  static const StateMeta meta = _$metaForProgressState;
  @override
  String get id =>
      state[_$key__id__ProgressState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set id(String value) => state[_$key__id__ProgressState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__id__ProgressState =
      StateDescriptor(_$key__id__ProgressState);
  static const String _$key__id__ProgressState = 'ProgressState.id';

  static const List<StateDescriptor> $state = [_$prop__id__ProgressState];
  static const List<String> $stateKeys = [_$key__id__ProgressState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForProgressState = StateMeta(
  fields: $ProgressState.$state,
  keys: $ProgressState.$stateKeys,
);
