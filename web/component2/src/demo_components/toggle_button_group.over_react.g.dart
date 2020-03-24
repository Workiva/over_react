// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'toggle_button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ToggleButtonGroupComponentFactory = registerComponent2(
  () => _$ToggleButtonGroupComponent(),
  builderFactory: ToggleButtonGroup,
  componentClass: ToggleButtonGroupComponent,
  isWrapper: false,
  parentType: $ButtonGroupComponentFactory,
  /* from `subtypeOf: ButtonGroupComponent` */
  displayName: 'ToggleButtonGroup',
);

_$$ToggleButtonGroupProps _$ToggleButtonGroup([Map backingProps]) =>
    backingProps == null
        ? _$$ToggleButtonGroupProps$JsMap(JsBackedMap())
        : _$$ToggleButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ToggleButtonGroupProps extends UiProps
    with
        ButtonGroupProps,
        $ButtonGroupProps, // If this generated mixin is undefined, it's likely because ButtonGroupProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupProps.
        AbstractInputPropsMixin,
        $AbstractInputPropsMixin // If this generated mixin is undefined, it's likely because AbstractInputPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of AbstractInputPropsMixin.
    implements
        ToggleButtonGroupProps {
  _$$ToggleButtonGroupProps._();

  factory _$$ToggleButtonGroupProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonGroupProps$JsMap(backingMap);
    } else {
      return _$$ToggleButtonGroupProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ToggleButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ToggleButtonGroupProps$PlainMap extends _$$ToggleButtonGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonGroupProps$PlainMap(Map backingMap)
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
class _$$ToggleButtonGroupProps$JsMap extends _$$ToggleButtonGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonGroupProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$ToggleButtonGroupState extends UiState
    with
        ButtonGroupState,
        $ButtonGroupState, // If this generated mixin is undefined, it's likely because ButtonGroupState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupState.
        AbstractInputStateMixin,
        $AbstractInputStateMixin // If this generated mixin is undefined, it's likely because AbstractInputStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of AbstractInputStateMixin.
    implements
        ToggleButtonGroupState {
  _$$ToggleButtonGroupState._();

  factory _$$ToggleButtonGroupState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonGroupState$JsMap(backingMap);
    } else {
      return _$$ToggleButtonGroupState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ToggleButtonGroupState$PlainMap extends _$$ToggleButtonGroupState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonGroupState$PlainMap(Map backingMap)
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
class _$$ToggleButtonGroupState$JsMap extends _$$ToggleButtonGroupState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonGroupState$JsMap(JsBackedMap backingMap)
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
class _$ToggleButtonGroupComponent extends ToggleButtonGroupComponent {
  _$$ToggleButtonGroupProps$JsMap _cachedTypedProps;

  @override
  _$$ToggleButtonGroupProps$JsMap get props => _cachedTypedProps;

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
  _$$ToggleButtonGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonGroupProps$JsMap(backingMap);

  @override
  _$$ToggleButtonGroupProps typedPropsFactory(Map backingMap) =>
      _$$ToggleButtonGroupProps(backingMap);

  _$$ToggleButtonGroupState$JsMap _cachedTypedState;
  @override
  _$$ToggleButtonGroupState$JsMap get state => _cachedTypedState;

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
  _$$ToggleButtonGroupState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonGroupState$JsMap(backingMap);

  @override
  _$$ToggleButtonGroupState typedStateFactory(Map backingMap) =>
      _$$ToggleButtonGroupState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ToggleButtonGroupProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps => const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ButtonGroupProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupProps.
        ButtonGroupProps: $ButtonGroupProps.meta,
        // If this generated mixin is undefined, it's likely because AbstractInputPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of AbstractInputPropsMixin.
        AbstractInputPropsMixin: $AbstractInputPropsMixin.meta,
      });
}
