// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_group.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonGroupComponentFactory = registerComponent(
    () => new _$ButtonGroupComponent(),
    builderFactory: ButtonGroup,
    componentClass: ButtonGroupComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ButtonGroup');

abstract class _$ButtonGroupPropsAccessorsMixin implements _$ButtonGroupProps {
  @override
  Map get props;

  /// Go to [_$ButtonGroupProps.size] to see the source code for this prop
  @override
  ButtonGroupSize get size =>
      props[_$key__size___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ButtonGroupProps.size] to see the source code for this prop
  @override
  set size(ButtonGroupSize value) =>
      props[_$key__size___$ButtonGroupProps] = value;

  /// Go to [_$ButtonGroupProps.skin] to see the source code for this prop
  @override
  ButtonSkin get skin =>
      props[_$key__skin___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ButtonGroupProps.skin] to see the source code for this prop
  @override
  set skin(ButtonSkin value) => props[_$key__skin___$ButtonGroupProps] = value;

  /// Go to [_$ButtonGroupProps.isVertical] to see the source code for this prop
  @override
  bool get isVertical =>
      props[_$key__isVertical___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ButtonGroupProps.isVertical] to see the source code for this prop
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
class _$$ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin
    implements ButtonGroupProps {
  _$$ButtonGroupProps._();
  factory _$$ButtonGroupProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$ButtonGroupProps$PlainMap(backingMap);
    } else {
      return new _$$ButtonGroupProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonGroupProps.';
}

class _$$ButtonGroupProps$PlainMap extends _$$ButtonGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ButtonGroupProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$ButtonGroupProps$JsMap extends _$$ButtonGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ButtonGroupProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
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
class _$$ButtonGroupState extends _$ButtonGroupState
    with _$ButtonGroupStateAccessorsMixin
    implements ButtonGroupState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ButtonGroupState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ButtonGroupComponent extends ButtonGroupComponent {
  @override
  _$$ButtonGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ButtonGroupProps(backingMap);
  @override
  _$$ButtonGroupProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ButtonGroupProps$JsMap(backingMap);

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
  _$$ButtonGroupProps$JsMap _cachedTypedProps;
  @override
  _$$ButtonGroupProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
