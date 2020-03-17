// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'custom_error_boundary_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $CustomErrorBoundaryComponentFactory = registerComponent2(
  () => _$CustomErrorBoundaryComponent(),
  builderFactory: CustomErrorBoundary,
  componentClass: CustomErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'CustomErrorBoundary',
  skipMethods: const [],
);

_$$CustomErrorBoundaryProps _$CustomErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? _$$CustomErrorBoundaryProps$JsMap(JsBackedMap())
        : _$$CustomErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$CustomErrorBoundaryProps extends UiProps
    with
        ErrorBoundaryPropsMixin,
        $ErrorBoundaryPropsMixin // If this generated mixin is undefined, it's likely because ErrorBoundaryPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ErrorBoundaryPropsMixin.
    implements
        CustomErrorBoundaryProps {
  _$$CustomErrorBoundaryProps._();

  factory _$$CustomErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$CustomErrorBoundaryProps$JsMap(backingMap);
    } else {
      return _$$CustomErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CustomErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$CustomErrorBoundaryProps$PlainMap extends _$$CustomErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryProps$PlainMap(Map backingMap)
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
class _$$CustomErrorBoundaryProps$JsMap extends _$$CustomErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$CustomErrorBoundaryState extends UiState
    with
        ErrorBoundaryStateMixin,
        $ErrorBoundaryStateMixin // If this generated mixin is undefined, it's likely because ErrorBoundaryStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of ErrorBoundaryStateMixin.
    implements
        CustomErrorBoundaryState {
  _$$CustomErrorBoundaryState._();

  factory _$$CustomErrorBoundaryState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$CustomErrorBoundaryState$JsMap(backingMap);
    } else {
      return _$$CustomErrorBoundaryState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$CustomErrorBoundaryState$PlainMap extends _$$CustomErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryState$PlainMap(Map backingMap)
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
class _$$CustomErrorBoundaryState$JsMap extends _$$CustomErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryState$JsMap(JsBackedMap backingMap)
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
class _$CustomErrorBoundaryComponent extends CustomErrorBoundaryComponent {
  _$$CustomErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$CustomErrorBoundaryProps$JsMap get props => _cachedTypedProps;

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
  _$$CustomErrorBoundaryProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$CustomErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$CustomErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$CustomErrorBoundaryProps(backingMap);

  _$$CustomErrorBoundaryState$JsMap _cachedTypedState;
  @override
  _$$CustomErrorBoundaryState$JsMap get state => _cachedTypedState;

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
  _$$CustomErrorBoundaryState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$CustomErrorBoundaryState$JsMap(backingMap);

  @override
  _$$CustomErrorBoundaryState typedStateFactory(Map backingMap) =>
      _$$CustomErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from CustomErrorBoundaryProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps => const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ErrorBoundaryPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ErrorBoundaryPropsMixin.
        ErrorBoundaryPropsMixin: $ErrorBoundaryPropsMixin.meta,
      });
}
