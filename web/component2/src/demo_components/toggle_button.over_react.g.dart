// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'toggle_button.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ToggleButtonComponentFactory = registerComponent2(
  () => _$ToggleButtonComponent(),
  builderFactory: _$ToggleButton,
  componentClass: ToggleButtonComponent,
  isWrapper: false,
  parentType: $ButtonComponentFactory,
  /* from `subtypeOf: ButtonComponent` */
  displayName: 'ToggleButton',
);

_$$ToggleButtonProps _$ToggleButton([Map backingProps]) => backingProps == null
    ? _$$ToggleButtonProps$JsMap(JsBackedMap())
    : _$$ToggleButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ToggleButtonProps extends UiProps
    with
        ButtonProps,
        $ButtonProps, // If this generated mixin is undefined, it's likely because ButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ButtonProps, and check that $ButtonProps is exported/imported properly.
        ToggleButtonPropsMixin,
        $ToggleButtonPropsMixin, // If this generated mixin is undefined, it's likely because ToggleButtonPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ToggleButtonPropsMixin, and check that $ToggleButtonPropsMixin is exported/imported properly.
        AbstractInputPropsMixin,
        $AbstractInputPropsMixin // If this generated mixin is undefined, it's likely because AbstractInputPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of AbstractInputPropsMixin, and check that $AbstractInputPropsMixin is exported/imported properly.
    implements
        ToggleButtonProps {
  _$$ToggleButtonProps._();

  factory _$$ToggleButtonProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonProps$JsMap(backingMap);
    } else {
      return _$$ToggleButtonProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ToggleButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get $meta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ButtonProps, and check that $ButtonProps is exported/imported properly.
        ButtonProps: $ButtonProps.meta,
        // If this generated mixin is undefined, it's likely because ToggleButtonPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ToggleButtonPropsMixin, and check that $ToggleButtonPropsMixin is exported/imported properly.
        ToggleButtonPropsMixin: $ToggleButtonPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because AbstractInputPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of AbstractInputPropsMixin, and check that $AbstractInputPropsMixin is exported/imported properly.
        AbstractInputPropsMixin: $AbstractInputPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ToggleButtonProps$PlainMap extends _$$ToggleButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonProps$PlainMap(Map backingMap)
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
class _$$ToggleButtonProps$JsMap extends _$$ToggleButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$ToggleButtonState extends UiState
    with
        ButtonState,
        $ButtonState, // If this generated mixin is undefined, it's likely because ButtonState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of ButtonState, and check that $ButtonState is exported/imported properly.
        ToggleButtonStateMixin,
        $ToggleButtonStateMixin, // If this generated mixin is undefined, it's likely because ToggleButtonStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of ToggleButtonStateMixin, and check that $ToggleButtonStateMixin is exported/imported properly.
        AbstractInputStateMixin,
        $AbstractInputStateMixin // If this generated mixin is undefined, it's likely because AbstractInputStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of AbstractInputStateMixin, and check that $AbstractInputStateMixin is exported/imported properly.
    implements
        ToggleButtonState {
  _$$ToggleButtonState._();

  factory _$$ToggleButtonState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonState$JsMap(backingMap);
    } else {
      return _$$ToggleButtonState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ToggleButtonState$PlainMap extends _$$ToggleButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonState$PlainMap(Map backingMap)
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
class _$$ToggleButtonState$JsMap extends _$$ToggleButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonState$JsMap(JsBackedMap backingMap)
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
class _$ToggleButtonComponent extends ToggleButtonComponent {
  _$$ToggleButtonProps$JsMap _cachedTypedProps;

  @override
  _$$ToggleButtonProps$JsMap get props => _cachedTypedProps;

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
  _$$ToggleButtonProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonProps$JsMap(backingMap);

  @override
  _$$ToggleButtonProps typedPropsFactory(Map backingMap) =>
      _$$ToggleButtonProps(backingMap);

  _$$ToggleButtonState$JsMap _cachedTypedState;
  @override
  _$$ToggleButtonState$JsMap get state => _cachedTypedState;

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
  _$$ToggleButtonState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonState$JsMap(backingMap);

  @override
  _$$ToggleButtonState typedStateFactory(Map backingMap) =>
      _$$ToggleButtonState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ToggleButtonProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ButtonProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ButtonProps, and check that $ButtonProps is exported/imported properly.
        ButtonProps: $ButtonProps.meta,
        // If this generated mixin is undefined, it's likely because ToggleButtonPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ToggleButtonPropsMixin, and check that $ToggleButtonPropsMixin is exported/imported properly.
        ToggleButtonPropsMixin: $ToggleButtonPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because AbstractInputPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of AbstractInputPropsMixin, and check that $AbstractInputPropsMixin is exported/imported properly.
        AbstractInputPropsMixin: $AbstractInputPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ToggleButtonPropsMixin on ToggleButtonPropsMixin {
  static const PropsMeta meta = _$metaForToggleButtonPropsMixin;
  @override
  @Accessor(keyNamespace: '')
  bool get autoFocus =>
      props[_$key__autoFocus__ToggleButtonPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: '')
  set autoFocus(bool value) =>
      props[_$key__autoFocus__ToggleButtonPropsMixin] = value;
  @override
  @Accessor(keyNamespace: '')
  bool get defaultChecked =>
      props[_$key__defaultChecked__ToggleButtonPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: '')
  set defaultChecked(bool value) =>
      props[_$key__defaultChecked__ToggleButtonPropsMixin] = value;
  @override
  @Accessor(keyNamespace: '')
  bool get checked =>
      props[_$key__checked__ToggleButtonPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: '')
  set checked(bool value) =>
      props[_$key__checked__ToggleButtonPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__autoFocus__ToggleButtonPropsMixin =
      PropDescriptor(_$key__autoFocus__ToggleButtonPropsMixin);
  static const PropDescriptor _$prop__defaultChecked__ToggleButtonPropsMixin =
      PropDescriptor(_$key__defaultChecked__ToggleButtonPropsMixin);
  static const PropDescriptor _$prop__checked__ToggleButtonPropsMixin =
      PropDescriptor(_$key__checked__ToggleButtonPropsMixin);
  static const String _$key__autoFocus__ToggleButtonPropsMixin = 'autoFocus';
  static const String _$key__defaultChecked__ToggleButtonPropsMixin =
      'defaultChecked';
  static const String _$key__checked__ToggleButtonPropsMixin = 'checked';

  static const List<PropDescriptor> $props = [
    _$prop__autoFocus__ToggleButtonPropsMixin,
    _$prop__defaultChecked__ToggleButtonPropsMixin,
    _$prop__checked__ToggleButtonPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__autoFocus__ToggleButtonPropsMixin,
    _$key__defaultChecked__ToggleButtonPropsMixin,
    _$key__checked__ToggleButtonPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForToggleButtonPropsMixin = PropsMeta(
  fields: $ToggleButtonPropsMixin.$props,
  keys: $ToggleButtonPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ToggleButtonStateMixin on ToggleButtonStateMixin {
  static const StateMeta meta = _$metaForToggleButtonStateMixin;
  @override
  bool get isFocused =>
      state[_$key__isFocused__ToggleButtonStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isFocused(bool value) =>
      state[_$key__isFocused__ToggleButtonStateMixin] = value;
  @override
  bool get isChecked =>
      state[_$key__isChecked__ToggleButtonStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isChecked(bool value) =>
      state[_$key__isChecked__ToggleButtonStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__isFocused__ToggleButtonStateMixin =
      StateDescriptor(_$key__isFocused__ToggleButtonStateMixin);
  static const StateDescriptor _$prop__isChecked__ToggleButtonStateMixin =
      StateDescriptor(_$key__isChecked__ToggleButtonStateMixin);
  static const String _$key__isFocused__ToggleButtonStateMixin =
      'ToggleButtonStateMixin.isFocused';
  static const String _$key__isChecked__ToggleButtonStateMixin =
      'ToggleButtonStateMixin.isChecked';

  static const List<StateDescriptor> $state = [
    _$prop__isFocused__ToggleButtonStateMixin,
    _$prop__isChecked__ToggleButtonStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__isFocused__ToggleButtonStateMixin,
    _$key__isChecked__ToggleButtonStateMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForToggleButtonStateMixin = StateMeta(
  fields: $ToggleButtonStateMixin.$state,
  keys: $ToggleButtonStateMixin.$stateKeys,
);
