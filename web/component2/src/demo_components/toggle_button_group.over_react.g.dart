// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ToggleButtonGroupComponentFactory = registerComponent2(
  () => new _$ToggleButtonGroupComponent(),
  builderFactory: ToggleButtonGroup,
  componentClass: ToggleButtonGroupComponent,
  isWrapper: false,
  parentType: $ButtonGroupComponentFactory,
  /* from `subtypeOf: ButtonGroupComponent` */
  displayName: 'ToggleButtonGroup',
);

abstract class _$ToggleButtonGroupPropsAccessorsMixin
    implements _$ToggleButtonGroupProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForToggleButtonGroupProps = const PropsMeta(
  fields: _$ToggleButtonGroupPropsAccessorsMixin.$props,
  keys: _$ToggleButtonGroupPropsAccessorsMixin.$propKeys,
);

class ToggleButtonGroupProps extends _$ToggleButtonGroupProps
    with _$ToggleButtonGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForToggleButtonGroupProps;
}

_$$ToggleButtonGroupProps _$ToggleButtonGroup([Map backingProps]) =>
    backingProps == null
        ? new _$$ToggleButtonGroupProps$JsMap(new JsBackedMap())
        : new _$$ToggleButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ToggleButtonGroupProps extends _$ToggleButtonGroupProps
    with _$ToggleButtonGroupPropsAccessorsMixin
    implements ToggleButtonGroupProps {
  _$$ToggleButtonGroupProps._();

  factory _$$ToggleButtonGroupProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ToggleButtonGroupProps$JsMap(backingMap);
    } else {
      return new _$$ToggleButtonGroupProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ToggleButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ToggleButtonGroupProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ToggleButtonGroupProps$PlainMap extends _$$ToggleButtonGroupProps {
  _$$ToggleButtonGroupProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ToggleButtonGroupProps$JsMap extends _$$ToggleButtonGroupProps {
  _$$ToggleButtonGroupProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

abstract class _$ToggleButtonGroupStateAccessorsMixin
    implements _$ToggleButtonGroupState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForToggleButtonGroupState = const StateMeta(
  fields: _$ToggleButtonGroupStateAccessorsMixin.$state,
  keys: _$ToggleButtonGroupStateAccessorsMixin.$stateKeys,
);

class ToggleButtonGroupState extends _$ToggleButtonGroupState
    with _$ToggleButtonGroupStateAccessorsMixin {
  static const StateMeta meta = _$metaForToggleButtonGroupState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ToggleButtonGroupState extends _$ToggleButtonGroupState
    with _$ToggleButtonGroupStateAccessorsMixin
    implements ToggleButtonGroupState {
  _$$ToggleButtonGroupState._();

  factory _$$ToggleButtonGroupState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ToggleButtonGroupState$JsMap(backingMap);
    } else {
      return new _$$ToggleButtonGroupState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ToggleButtonGroupState$PlainMap extends _$$ToggleButtonGroupState {
  _$$ToggleButtonGroupState$PlainMap(Map backingMap)
      : this.state = backingMap ?? {},
        super._();

  /// The backing state map proxied by this class.
  @override
  final Map state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ToggleButtonGroupState$JsMap extends _$$ToggleButtonGroupState {
  _$$ToggleButtonGroupState$JsMap(JsBackedMap backingMap)
      : this.state = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing state map proxied by this class.
  @override
  final JsBackedMap state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ToggleButtonGroupComponent extends ToggleButtonGroupComponent {
  _$$ToggleButtonGroupProps$JsMap _cachedTypedProps;

  @override
  _$$ToggleButtonGroupProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$ToggleButtonGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ToggleButtonGroupProps$JsMap(backingMap);

  @override
  _$$ToggleButtonGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ToggleButtonGroupProps(backingMap);

  _$$ToggleButtonGroupState$JsMap _cachedTypedState;
  @override
  _$$ToggleButtonGroupState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initializeState (within the init lifecycle method) or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$ToggleButtonGroupState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$ToggleButtonGroupState$JsMap(backingMap);

  @override
  _$$ToggleButtonGroupState typedStateFactory(Map backingMap) =>
      new _$$ToggleButtonGroupState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ToggleButtonGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForToggleButtonGroupProps
  ];
}
