// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $CustomErrorBoundaryComponentFactory = registerComponent2(
  () => new _$CustomErrorBoundaryComponent(),
  builderFactory: CustomErrorBoundary,
  componentClass: CustomErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'CustomErrorBoundary',
  skipMethods: const [],
);

abstract class _$CustomErrorBoundaryPropsAccessorsMixin
    implements _$CustomErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForCustomErrorBoundaryProps = const PropsMeta(
  fields: _$CustomErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$CustomErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps
    with _$CustomErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForCustomErrorBoundaryProps;
}

_$$CustomErrorBoundaryProps _$CustomErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? new _$$CustomErrorBoundaryProps$JsMap(new JsBackedMap())
        : new _$$CustomErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps
    with _$CustomErrorBoundaryPropsAccessorsMixin
    implements CustomErrorBoundaryProps {
  _$$CustomErrorBoundaryProps._();

  factory _$$CustomErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$CustomErrorBoundaryProps$JsMap(backingMap);
    } else {
      return new _$$CustomErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CustomErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'CustomErrorBoundaryProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$CustomErrorBoundaryProps$PlainMap extends _$$CustomErrorBoundaryProps {
  _$$CustomErrorBoundaryProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$CustomErrorBoundaryProps$JsMap extends _$$CustomErrorBoundaryProps {
  _$$CustomErrorBoundaryProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

abstract class _$CustomErrorBoundaryStateAccessorsMixin
    implements _$CustomErrorBoundaryState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForCustomErrorBoundaryState = const StateMeta(
  fields: _$CustomErrorBoundaryStateAccessorsMixin.$state,
  keys: _$CustomErrorBoundaryStateAccessorsMixin.$stateKeys,
);

class CustomErrorBoundaryState extends _$CustomErrorBoundaryState
    with _$CustomErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForCustomErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$CustomErrorBoundaryState extends _$CustomErrorBoundaryState
    with _$CustomErrorBoundaryStateAccessorsMixin
    implements CustomErrorBoundaryState {
  _$$CustomErrorBoundaryState._();

  factory _$$CustomErrorBoundaryState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$CustomErrorBoundaryState$JsMap(backingMap);
    } else {
      return new _$$CustomErrorBoundaryState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$CustomErrorBoundaryState$PlainMap extends _$$CustomErrorBoundaryState {
  _$$CustomErrorBoundaryState$PlainMap(Map backingMap)
      : this.state = backingMap ?? {},
        super._();

  /// The backing state map proxied by this class.
  @override
  final Map state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$CustomErrorBoundaryState$JsMap extends _$$CustomErrorBoundaryState {
  _$$CustomErrorBoundaryState$JsMap(JsBackedMap backingMap)
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
class _$CustomErrorBoundaryComponent extends CustomErrorBoundaryComponent {
  _$$CustomErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$CustomErrorBoundaryProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$CustomErrorBoundaryProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$CustomErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$CustomErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$CustomErrorBoundaryProps(backingMap);

  _$$CustomErrorBoundaryState$JsMap _cachedTypedState;
  @override
  _$$CustomErrorBoundaryState$JsMap get state => _cachedTypedState;

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
  _$$CustomErrorBoundaryState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      new _$$CustomErrorBoundaryState$JsMap(backingMap);

  @override
  _$$CustomErrorBoundaryState typedStateFactory(Map backingMap) =>
      new _$$CustomErrorBoundaryState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$CustomErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForCustomErrorBoundaryProps
  ];
}
