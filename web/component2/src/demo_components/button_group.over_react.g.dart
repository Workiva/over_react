// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonGroupComponentFactory = registerComponent2(
  () => new _$ButtonGroupComponent(),
  builderFactory: ButtonGroup,
  componentClass: ButtonGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ButtonGroup',
);

abstract class _$ButtonGroupPropsAccessorsMixin implements _$ButtonGroupProps {
  @override
  Map get props;

  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonGroupProps.size] -->
  @override
  ButtonGroupSize get size => props[_$key__size___$ButtonGroupProps];

  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonGroupProps.size] -->
  @override
  set size(ButtonGroupSize value) =>
      props[_$key__size___$ButtonGroupProps] = value;

  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ///
  /// <!-- Generated from [_$ButtonGroupProps.skin] -->
  @override
  ButtonSkin get skin => props[_$key__skin___$ButtonGroupProps];

  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ///
  /// <!-- Generated from [_$ButtonGroupProps.skin] -->
  @override
  set skin(ButtonSkin value) => props[_$key__skin___$ButtonGroupProps] = value;

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonGroupProps.isVertical] -->
  @override
  bool get isVertical => props[_$key__isVertical___$ButtonGroupProps];

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonGroupProps.isVertical] -->
  @override
  set isVertical(bool value) =>
      props[_$key__isVertical___$ButtonGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__size___$ButtonGroupProps =
      const PropDescriptor(_$key__size___$ButtonGroupProps);
  static const PropDescriptor _$prop__skin___$ButtonGroupProps =
      const PropDescriptor(_$key__skin___$ButtonGroupProps);
  static const PropDescriptor _$prop__isVertical___$ButtonGroupProps =
      const PropDescriptor(_$key__isVertical___$ButtonGroupProps);
  static const String _$key__size___$ButtonGroupProps = 'ButtonGroupProps.size';
  static const String _$key__skin___$ButtonGroupProps = 'ButtonGroupProps.skin';
  static const String _$key__isVertical___$ButtonGroupProps =
      'ButtonGroupProps.isVertical';

  static const List<PropDescriptor> $props = const [
    _$prop__size___$ButtonGroupProps,
    _$prop__skin___$ButtonGroupProps,
    _$prop__isVertical___$ButtonGroupProps
  ];
  static const List<String> $propKeys = const [
    _$key__size___$ButtonGroupProps,
    _$key__skin___$ButtonGroupProps,
    _$key__isVertical___$ButtonGroupProps
  ];
}

const PropsMeta _$metaForButtonGroupProps = const PropsMeta(
  fields: _$ButtonGroupPropsAccessorsMixin.$props,
  keys: _$ButtonGroupPropsAccessorsMixin.$propKeys,
);

class ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForButtonGroupProps;
}

_$$ButtonGroupProps _$ButtonGroup([Map backingProps]) => backingProps == null
    ? new _$$ButtonGroupProps$JsMap(new JsBackedMap())
    : new _$$ButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin
    implements ButtonGroupProps {
  _$$ButtonGroupProps._();

  factory _$$ButtonGroupProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ButtonGroupProps$JsMap(backingMap);
    } else {
      return new _$$ButtonGroupProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonGroupProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ButtonGroupProps$PlainMap extends _$$ButtonGroupProps {
  _$$ButtonGroupProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ButtonGroupProps$JsMap extends _$$ButtonGroupProps {
  _$$ButtonGroupProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

abstract class _$ButtonGroupStateAccessorsMixin implements _$ButtonGroupState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForButtonGroupState = const StateMeta(
  fields: _$ButtonGroupStateAccessorsMixin.$state,
  keys: _$ButtonGroupStateAccessorsMixin.$stateKeys,
);

class ButtonGroupState extends _$ButtonGroupState
    with _$ButtonGroupStateAccessorsMixin {
  static const StateMeta meta = _$metaForButtonGroupState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ButtonGroupState extends _$ButtonGroupState
    with _$ButtonGroupStateAccessorsMixin
    implements ButtonGroupState {
  _$$ButtonGroupState._();

  factory _$$ButtonGroupState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ButtonGroupState$JsMap(backingMap);
    } else {
      return new _$$ButtonGroupState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ButtonGroupState$PlainMap extends _$$ButtonGroupState {
  _$$ButtonGroupState$PlainMap(Map backingMap)
      : this.state = backingMap ?? {},
        super._();

  /// The backing state map proxied by this class.
  @override
  final Map state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ButtonGroupState$JsMap extends _$$ButtonGroupState {
  _$$ButtonGroupState$JsMap(JsBackedMap backingMap)
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
class _$ButtonGroupComponent extends ButtonGroupComponent {
  _$$ButtonGroupProps$JsMap _cachedTypedProps;

  @override
  _$$ButtonGroupProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$ButtonGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ButtonGroupProps$JsMap(backingMap);

  @override
  _$$ButtonGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ButtonGroupProps(backingMap);

  _$$ButtonGroupState$JsMap _cachedTypedState;
  @override
  _$$ButtonGroupState$JsMap get state => _cachedTypedState;

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
  _$$ButtonGroupState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$ButtonGroupState$JsMap(backingMap);

  @override
  _$$ButtonGroupState typedStateFactory(Map backingMap) =>
      new _$$ButtonGroupState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ButtonGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForButtonGroupProps
  ];
}
