// GENERATED CODE - DO NOT MODIFY BY HAND

part of abstract_transition_test;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TransitionerComponentFactory = registerComponent(
    () => new _$TransitionerComponent(),
    builderFactory: Transitioner,
    componentClass: TransitionerComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Transitioner');

abstract class _$TransitionerPropsAccessorsMixin
    implements _$TransitionerProps {
  @override
  Map get props;

  /// Go to [_$TransitionerProps.onHandlePreShowing] to see the source code for this prop
  @override
  Callback get onHandlePreShowing =>
      props['TransitionerProps.onHandlePreShowing'];

  /// Go to [_$TransitionerProps.onHandlePreShowing] to see the source code for this prop
  @override
  set onHandlePreShowing(Callback value) =>
      props['TransitionerProps.onHandlePreShowing'] = value;

  /// Go to [_$TransitionerProps.onHandleShowing] to see the source code for this prop
  @override
  Callback get onHandleShowing => props['TransitionerProps.onHandleShowing'];

  /// Go to [_$TransitionerProps.onHandleShowing] to see the source code for this prop
  @override
  set onHandleShowing(Callback value) =>
      props['TransitionerProps.onHandleShowing'] = value;

  /// Go to [_$TransitionerProps.onHandleShown] to see the source code for this prop
  @override
  Callback get onHandleShown => props['TransitionerProps.onHandleShown'];

  /// Go to [_$TransitionerProps.onHandleShown] to see the source code for this prop
  @override
  set onHandleShown(Callback value) =>
      props['TransitionerProps.onHandleShown'] = value;

  /// Go to [_$TransitionerProps.onHandleHiding] to see the source code for this prop
  @override
  Callback get onHandleHiding => props['TransitionerProps.onHandleHiding'];

  /// Go to [_$TransitionerProps.onHandleHiding] to see the source code for this prop
  @override
  set onHandleHiding(Callback value) =>
      props['TransitionerProps.onHandleHiding'] = value;

  /// Go to [_$TransitionerProps.onHandleHidden] to see the source code for this prop
  @override
  Callback get onHandleHidden => props['TransitionerProps.onHandleHidden'];

  /// Go to [_$TransitionerProps.onHandleHidden] to see the source code for this prop
  @override
  set onHandleHidden(Callback value) =>
      props['TransitionerProps.onHandleHidden'] = value;

  /// Go to [_$TransitionerProps.onPrepareShow] to see the source code for this prop
  @override
  Callback get onPrepareShow => props['TransitionerProps.onPrepareShow'];

  /// Go to [_$TransitionerProps.onPrepareShow] to see the source code for this prop
  @override
  set onPrepareShow(Callback value) =>
      props['TransitionerProps.onPrepareShow'] = value;

  /// Go to [_$TransitionerProps.onPrepareHide] to see the source code for this prop
  @override
  Callback get onPrepareHide => props['TransitionerProps.onPrepareHide'];

  /// Go to [_$TransitionerProps.onPrepareHide] to see the source code for this prop
  @override
  set onPrepareHide(Callback value) =>
      props['TransitionerProps.onPrepareHide'] = value;

  /// Go to [_$TransitionerProps.hasTransition] to see the source code for this prop
  @override
  bool get hasTransition => props['TransitionerProps.hasTransition'];

  /// Go to [_$TransitionerProps.hasTransition] to see the source code for this prop
  @override
  set hasTransition(bool value) =>
      props['TransitionerProps.hasTransition'] = value;

  /// Go to [_$TransitionerProps.initiallyShown] to see the source code for this prop
  @override
  bool get initiallyShown => props['TransitionerProps.initiallyShown'];

  /// Go to [_$TransitionerProps.initiallyShown] to see the source code for this prop
  @override
  set initiallyShown(bool value) =>
      props['TransitionerProps.initiallyShown'] = value;

  /// Go to [_$TransitionerProps.transitionTimeout] to see the source code for this prop
  @override
  Duration get transitionTimeout =>
      props['TransitionerProps.transitionTimeout'];

  /// Go to [_$TransitionerProps.transitionTimeout] to see the source code for this prop
  @override
  set transitionTimeout(Duration value) =>
      props['TransitionerProps.transitionTimeout'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('TransitionerProps.onHandlePreShowing'),
    const PropDescriptor('TransitionerProps.onHandleShowing'),
    const PropDescriptor('TransitionerProps.onHandleShown'),
    const PropDescriptor('TransitionerProps.onHandleHiding'),
    const PropDescriptor('TransitionerProps.onHandleHidden'),
    const PropDescriptor('TransitionerProps.onPrepareShow'),
    const PropDescriptor('TransitionerProps.onPrepareHide'),
    const PropDescriptor('TransitionerProps.hasTransition'),
    const PropDescriptor('TransitionerProps.initiallyShown'),
    const PropDescriptor('TransitionerProps.transitionTimeout')
  ];
  static const List<String> $propKeys = const [
    'TransitionerProps.onHandlePreShowing',
    'TransitionerProps.onHandleShowing',
    'TransitionerProps.onHandleShown',
    'TransitionerProps.onHandleHiding',
    'TransitionerProps.onHandleHidden',
    'TransitionerProps.onPrepareShow',
    'TransitionerProps.onPrepareHide',
    'TransitionerProps.hasTransition',
    'TransitionerProps.initiallyShown',
    'TransitionerProps.transitionTimeout'
  ];
}

const PropsMeta _$metaForTransitionerProps = const PropsMeta(
  fields: _$TransitionerPropsAccessorsMixin.$props,
  keys: _$TransitionerPropsAccessorsMixin.$propKeys,
);

class TransitionerProps extends _$TransitionerProps
    with _$TransitionerPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTransitionerProps;
}

_$$TransitionerProps _$Transitioner([Map backingProps]) =>
    new _$$TransitionerProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TransitionerProps extends _$TransitionerProps
    with _$TransitionerPropsAccessorsMixin
    implements TransitionerProps {
  _$$TransitionerProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TransitionerComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TransitionerProps.';
}

abstract class _$TransitionerStateAccessorsMixin
    implements _$TransitionerState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTransitionerState = const StateMeta(
  fields: _$TransitionerStateAccessorsMixin.$state,
  keys: _$TransitionerStateAccessorsMixin.$stateKeys,
);

class TransitionerState extends _$TransitionerState
    with _$TransitionerStateAccessorsMixin {
  static const StateMeta meta = _$metaForTransitionerState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TransitionerState extends _$TransitionerState
    with _$TransitionerStateAccessorsMixin
    implements TransitionerState {
  _$$TransitionerState(Map backingMap) : this._state = backingMap ?? {};

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  final Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TransitionerComponent extends TransitionerComponent {
  @override
  _$$TransitionerProps typedPropsFactory(Map backingMap) =>
      new _$$TransitionerProps(backingMap);

  @override
  _$$TransitionerState typedStateFactory(Map backingMap) =>
      new _$$TransitionerState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TransitionerProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTransitionerProps
  ];
}
