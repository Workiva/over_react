// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'button.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ButtonComponentFactory = registerComponent2(
  () => _$ButtonComponent(),
  builderFactory: Button,
  componentClass: ButtonComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Button',
);

_$$ButtonProps _$Button([Map backingProps]) => backingProps == null
    ? _$$ButtonProps$JsMap(JsBackedMap())
    : _$$ButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ButtonProps extends UiProps
    with
        ButtonProps,
        $ButtonProps // If this generated mixin is undefined, it's likely because ButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonProps.
{
  _$$ButtonProps._();

  factory _$$ButtonProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ButtonProps$JsMap(backingMap);
    } else {
      return _$$ButtonProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ButtonProps$PlainMap extends _$$ButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonProps$PlainMap(Map backingMap)
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
class _$$ButtonProps$JsMap extends _$$ButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$ButtonState extends UiState
    with
        ButtonState,
        $ButtonState // If this generated mixin is undefined, it's likely because ButtonState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonState.
{
  _$$ButtonState._();

  factory _$$ButtonState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ButtonState$JsMap(backingMap);
    } else {
      return _$$ButtonState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ButtonState$PlainMap extends _$$ButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonState$PlainMap(Map backingMap)
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
class _$$ButtonState$JsMap extends _$$ButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonState$JsMap(JsBackedMap backingMap)
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
class _$ButtonComponent extends ButtonComponent {
  _$$ButtonProps$JsMap _cachedTypedProps;

  @override
  _$$ButtonProps$JsMap get props => _cachedTypedProps;

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
  _$$ButtonProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonProps$JsMap(backingMap);

  @override
  _$$ButtonProps typedPropsFactory(Map backingMap) =>
      _$$ButtonProps(backingMap);

  _$$ButtonState$JsMap _cachedTypedState;
  @override
  _$$ButtonState$JsMap get state => _cachedTypedState;

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
  _$$ButtonState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonState$JsMap(backingMap);

  @override
  _$$ButtonState typedStateFactory(Map backingMap) =>
      _$$ButtonState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ButtonProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(ButtonProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonProps.
        ButtonProps: $ButtonProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ButtonProps on ButtonProps {
  static const PropsMeta meta = _$metaForButtonProps;
  @override
  ButtonSkin get skin =>
      props[_$key__skin__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set skin(ButtonSkin value) => props[_$key__skin__ButtonProps] = value;
  @override
  ButtonSize get size =>
      props[_$key__size__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set size(ButtonSize value) => props[_$key__size__ButtonProps] = value;
  @override
  bool get isActive =>
      props[_$key__isActive__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isActive(bool value) => props[_$key__isActive__ButtonProps] = value;
  @override
  bool get isDisabled =>
      props[_$key__isDisabled__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isDisabled(bool value) => props[_$key__isDisabled__ButtonProps] = value;
  @override
  bool get isBlock =>
      props[_$key__isBlock__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isBlock(bool value) => props[_$key__isBlock__ButtonProps] = value;
  @override
  String get href =>
      props[_$key__href__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set href(String value) => props[_$key__href__ButtonProps] = value;
  @override
  String get target =>
      props[_$key__target__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set target(String value) => props[_$key__target__ButtonProps] = value;
  @override
  ButtonType get type =>
      props[_$key__type__ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set type(ButtonType value) => props[_$key__type__ButtonProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__skin__ButtonProps =
      PropDescriptor(_$key__skin__ButtonProps);
  static const PropDescriptor _$prop__size__ButtonProps =
      PropDescriptor(_$key__size__ButtonProps);
  static const PropDescriptor _$prop__isActive__ButtonProps =
      PropDescriptor(_$key__isActive__ButtonProps);
  static const PropDescriptor _$prop__isDisabled__ButtonProps =
      PropDescriptor(_$key__isDisabled__ButtonProps);
  static const PropDescriptor _$prop__isBlock__ButtonProps =
      PropDescriptor(_$key__isBlock__ButtonProps);
  static const PropDescriptor _$prop__href__ButtonProps =
      PropDescriptor(_$key__href__ButtonProps);
  static const PropDescriptor _$prop__target__ButtonProps =
      PropDescriptor(_$key__target__ButtonProps);
  static const PropDescriptor _$prop__type__ButtonProps =
      PropDescriptor(_$key__type__ButtonProps);
  static const String _$key__skin__ButtonProps = 'ButtonProps.skin';
  static const String _$key__size__ButtonProps = 'ButtonProps.size';
  static const String _$key__isActive__ButtonProps = 'ButtonProps.isActive';
  static const String _$key__isDisabled__ButtonProps = 'disabled';
  static const String _$key__isBlock__ButtonProps = 'ButtonProps.isBlock';
  static const String _$key__href__ButtonProps = 'href';
  static const String _$key__target__ButtonProps = 'target';
  static const String _$key__type__ButtonProps = 'ButtonProps.type';

  static const List<PropDescriptor> $props = [
    _$prop__skin__ButtonProps,
    _$prop__size__ButtonProps,
    _$prop__isActive__ButtonProps,
    _$prop__isDisabled__ButtonProps,
    _$prop__isBlock__ButtonProps,
    _$prop__href__ButtonProps,
    _$prop__target__ButtonProps,
    _$prop__type__ButtonProps
  ];
  static const List<String> $propKeys = [
    _$key__skin__ButtonProps,
    _$key__size__ButtonProps,
    _$key__isActive__ButtonProps,
    _$key__isDisabled__ButtonProps,
    _$key__isBlock__ButtonProps,
    _$key__href__ButtonProps,
    _$key__target__ButtonProps,
    _$key__type__ButtonProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForButtonProps = PropsMeta(
  fields: $ButtonProps.$props,
  keys: $ButtonProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ButtonState on ButtonState {
  static const StateMeta meta = _$metaForButtonState;
  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForButtonState = StateMeta(
  fields: $ButtonState.$state,
  keys: $ButtonState.$stateKeys,
);
