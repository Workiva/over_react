// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ErrorBoundaryComponentFactory = registerComponent2(
  () => new _$ErrorBoundaryComponent(),
  builderFactory: ErrorBoundary,
  componentClass: ErrorBoundaryComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'ErrorBoundary',
  skipMethods: const [],
);

abstract class _$ErrorBoundaryPropsAccessorsMixin
    implements _$ErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForErrorBoundaryProps = const PropsMeta(
  fields: _$ErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$ErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForErrorBoundaryProps;
}

_$$ErrorBoundaryProps _$ErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? new _$$ErrorBoundaryProps$JsMap(new JsBackedMap())
        : new _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin
    implements ErrorBoundaryProps {
  _$$ErrorBoundaryProps._();

  factory _$$ErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ErrorBoundaryProps$JsMap(backingMap);
    } else {
      return new _$$ErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ErrorBoundaryProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ErrorBoundaryProps$PlainMap extends _$$ErrorBoundaryProps {
  _$$ErrorBoundaryProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ErrorBoundaryProps$JsMap extends _$$ErrorBoundaryProps {
  _$$ErrorBoundaryProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
}

abstract class _$ErrorBoundaryStateAccessorsMixin
    implements _$ErrorBoundaryState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForErrorBoundaryState = const StateMeta(
  fields: _$ErrorBoundaryStateAccessorsMixin.$state,
  keys: _$ErrorBoundaryStateAccessorsMixin.$stateKeys,
);

class ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin
    implements ErrorBoundaryState {
  _$$ErrorBoundaryState._();

  factory _$$ErrorBoundaryState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$ErrorBoundaryState$JsMap(backingMap);
    } else {
      return new _$$ErrorBoundaryState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ErrorBoundaryState$PlainMap extends _$$ErrorBoundaryState {
  _$$ErrorBoundaryState$PlainMap(Map backingMap)
      : this.state = backingMap ?? {},
        super._();

  /// The backing state map proxied by this class.
  @override
  final Map state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$ErrorBoundaryState$JsMap extends _$$ErrorBoundaryState {
  _$$ErrorBoundaryState$JsMap(JsBackedMap backingMap)
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
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  _$$ErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$ErrorBoundaryProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$ErrorBoundaryProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$ErrorBoundaryProps(backingMap);

  _$$ErrorBoundaryState$JsMap _cachedTypedState;
  @override
  _$$ErrorBoundaryState$JsMap get state => _cachedTypedState;

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
  _$$ErrorBoundaryState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$ErrorBoundaryState$JsMap(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map backingMap) =>
      new _$$ErrorBoundaryState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForErrorBoundaryProps
  ];
}
