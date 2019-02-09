// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ProgressComponentFactory = registerComponent(
    () => new _$ProgressComponent(),
    builderFactory: Progress,
    componentClass: ProgressComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Progress');

abstract class _$ProgressPropsAccessorsMixin implements _$ProgressProps {
  @override
  Map get props;

  /// Go to [_$ProgressProps.value] to see the source code for this prop
  @override
  double get value => props['ProgressProps.value'];

  /// Go to [_$ProgressProps.value] to see the source code for this prop
  @override
  set value(double value) => props['ProgressProps.value'] = value;

  /// Go to [_$ProgressProps.min] to see the source code for this prop
  @override
  double get min => props['ProgressProps.min'];

  /// Go to [_$ProgressProps.min] to see the source code for this prop
  @override
  set min(double value) => props['ProgressProps.min'] = value;

  /// Go to [_$ProgressProps.max] to see the source code for this prop
  @override
  double get max => props['ProgressProps.max'];

  /// Go to [_$ProgressProps.max] to see the source code for this prop
  @override
  set max(double value) => props['ProgressProps.max'] = value;

  /// Go to [_$ProgressProps.skin] to see the source code for this prop
  @override
  ProgressSkin get skin => props['ProgressProps.skin'];

  /// Go to [_$ProgressProps.skin] to see the source code for this prop
  @override
  set skin(ProgressSkin value) => props['ProgressProps.skin'] = value;

  /// Go to [_$ProgressProps.isStriped] to see the source code for this prop
  @override
  bool get isStriped => props['ProgressProps.isStriped'];

  /// Go to [_$ProgressProps.isStriped] to see the source code for this prop
  @override
  set isStriped(bool value) => props['ProgressProps.isStriped'] = value;

  /// Go to [_$ProgressProps.isAnimated] to see the source code for this prop
  @override
  bool get isAnimated => props['ProgressProps.isAnimated'];

  /// Go to [_$ProgressProps.isAnimated] to see the source code for this prop
  @override
  set isAnimated(bool value) => props['ProgressProps.isAnimated'] = value;

  /// Go to [_$ProgressProps.caption] to see the source code for this prop
  @override
  String get caption => props['ProgressProps.caption'];

  /// Go to [_$ProgressProps.caption] to see the source code for this prop
  @override
  set caption(String value) => props['ProgressProps.caption'] = value;

  /// Go to [_$ProgressProps.captionProps] to see the source code for this prop
  @override
  Map get captionProps => props['ProgressProps.captionProps'];

  /// Go to [_$ProgressProps.captionProps] to see the source code for this prop
  @override
  set captionProps(Map value) => props['ProgressProps.captionProps'] = value;

  /// Go to [_$ProgressProps.showCaption] to see the source code for this prop
  @override
  bool get showCaption => props['ProgressProps.showCaption'];

  /// Go to [_$ProgressProps.showCaption] to see the source code for this prop
  @override
  set showCaption(bool value) => props['ProgressProps.showCaption'] = value;

  /// Go to [_$ProgressProps.showPercentComplete] to see the source code for this prop
  @override
  bool get showPercentComplete => props['ProgressProps.showPercentComplete'];

  /// Go to [_$ProgressProps.showPercentComplete] to see the source code for this prop
  @override
  set showPercentComplete(bool value) =>
      props['ProgressProps.showPercentComplete'] = value;

  /// Go to [_$ProgressProps.rootNodeProps] to see the source code for this prop
  @override
  Map get rootNodeProps => props['ProgressProps.rootNodeProps'];

  /// Go to [_$ProgressProps.rootNodeProps] to see the source code for this prop
  @override
  set rootNodeProps(Map value) => props['ProgressProps.rootNodeProps'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ProgressProps.value'),
    const PropDescriptor('ProgressProps.min'),
    const PropDescriptor('ProgressProps.max'),
    const PropDescriptor('ProgressProps.skin'),
    const PropDescriptor('ProgressProps.isStriped'),
    const PropDescriptor('ProgressProps.isAnimated'),
    const PropDescriptor('ProgressProps.caption'),
    const PropDescriptor('ProgressProps.captionProps'),
    const PropDescriptor('ProgressProps.showCaption'),
    const PropDescriptor('ProgressProps.showPercentComplete'),
    const PropDescriptor('ProgressProps.rootNodeProps')
  ];
  static const List<String> $propKeys = const [
    'ProgressProps.value',
    'ProgressProps.min',
    'ProgressProps.max',
    'ProgressProps.skin',
    'ProgressProps.isStriped',
    'ProgressProps.isAnimated',
    'ProgressProps.caption',
    'ProgressProps.captionProps',
    'ProgressProps.showCaption',
    'ProgressProps.showPercentComplete',
    'ProgressProps.rootNodeProps'
  ];
}

const PropsMeta _$metaForProgressProps = const PropsMeta(
  fields: _$ProgressPropsAccessorsMixin.$props,
  keys: _$ProgressPropsAccessorsMixin.$propKeys,
);

class ProgressProps extends _$ProgressProps with _$ProgressPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForProgressProps;
}

_$$ProgressProps _$Progress([Map backingProps]) =>
    new _$$ProgressProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ProgressProps extends _$ProgressProps
    with _$ProgressPropsAccessorsMixin
    implements ProgressProps {
  _$$ProgressProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $ProgressComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ProgressProps.';
}

abstract class _$ProgressStateAccessorsMixin implements _$ProgressState {
  @override
  Map get state;

  /// Go to [_$ProgressState.id] to see the source code for this prop
  @override
  String get id => state['ProgressState.id'];

  /// Go to [_$ProgressState.id] to see the source code for this prop
  @override
  set id(String value) => state['ProgressState.id'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('ProgressState.id')
  ];
  static const List<String> $stateKeys = const ['ProgressState.id'];
}

const StateMeta _$metaForProgressState = const StateMeta(
  fields: _$ProgressStateAccessorsMixin.$state,
  keys: _$ProgressStateAccessorsMixin.$stateKeys,
);

class ProgressState extends _$ProgressState with _$ProgressStateAccessorsMixin {
  static const StateMeta meta = _$metaForProgressState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ProgressState extends _$ProgressState
    with _$ProgressStateAccessorsMixin
    implements ProgressState {
  _$$ProgressState(Map backingMap) : this._state = backingMap ?? {};

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
class _$ProgressComponent extends ProgressComponent {
  @override
  _$$ProgressProps typedPropsFactory(Map backingMap) =>
      new _$$ProgressProps(backingMap);

  @override
  _$$ProgressState typedStateFactory(Map backingMap) =>
      new _$$ProgressState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ProgressProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForProgressProps
  ];
}
