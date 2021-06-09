// @dart=2.7
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'abstract_transition_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $TransitionerComponentFactory = registerComponent2(
  () => _$TransitionerComponent(),
  builderFactory: _$Transitioner,
  componentClass: TransitionerComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Transitioner',
);

_$$TransitionerProps _$Transitioner([Map backingProps]) => backingProps == null
    ? _$$TransitionerProps$JsMap(JsBackedMap())
    : _$$TransitionerProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TransitionerProps extends UiProps
    with
        TransitionerPropsMixin,
        $TransitionerPropsMixin, // If this generated mixin is undefined, it's likely because TransitionerPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionerPropsMixin, and check that $TransitionerPropsMixin is exported/imported properly.
        TransitionPropsMixin,
        $TransitionPropsMixin // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
    implements
        TransitionerProps {
  _$$TransitionerProps._();

  factory _$$TransitionerProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TransitionerProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TransitionerProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TransitionerComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TransitionerPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionerPropsMixin, and check that $TransitionerPropsMixin is exported/imported properly.
        TransitionerPropsMixin: $TransitionerPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
        TransitionPropsMixin: $TransitionPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TransitionerProps$PlainMap extends _$$TransitionerProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TransitionerProps$PlainMap(Map backingMap)
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
class _$$TransitionerProps$JsMap extends _$$TransitionerProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TransitionerProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$TransitionerState extends UiState
    with
        AbstractTransitionState,
        $AbstractTransitionState // If this generated mixin is undefined, it's likely because AbstractTransitionState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of AbstractTransitionState, and check that $AbstractTransitionState is exported/imported properly.
    implements
        TransitionerState {
  _$$TransitionerState._();

  factory _$$TransitionerState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TransitionerState$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TransitionerState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TransitionerState$PlainMap extends _$$TransitionerState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TransitionerState$PlainMap(Map backingMap)
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
class _$$TransitionerState$JsMap extends _$$TransitionerState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TransitionerState$JsMap(JsBackedMap backingMap)
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
class _$TransitionerComponent extends TransitionerComponent {
  _$$TransitionerProps$JsMap _cachedTypedProps;

  @override
  _$$TransitionerProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$TransitionerProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TransitionerProps$JsMap(backingMap);

  @override
  _$$TransitionerProps typedPropsFactory(Map backingMap) =>
      _$$TransitionerProps(backingMap);

  _$$TransitionerState$JsMap _cachedTypedState;
  @override
  _$$TransitionerState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TransitionerState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$TransitionerState$JsMap(backingMap);

  @override
  _$$TransitionerState typedStateFactory(Map backingMap) =>
      _$$TransitionerState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by TransitionerProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TransitionerPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionerPropsMixin, and check that $TransitionerPropsMixin is exported/imported properly.
        TransitionerPropsMixin: $TransitionerPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TransitionPropsMixin, and check that $TransitionPropsMixin is exported/imported properly.
        TransitionPropsMixin: $TransitionPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TransitionerPropsMixin on TransitionerPropsMixin {
  static const PropsMeta meta = _$metaForTransitionerPropsMixin;
  @override
  Callback get onHandlePreShowing =>
      (props[_$key__onHandlePreShowing__TransitionerPropsMixin] ?? null)
          as Callback;
  @override
  set onHandlePreShowing(Callback value) =>
      props[_$key__onHandlePreShowing__TransitionerPropsMixin] = value;
  @override
  Callback get onHandleShowing =>
      (props[_$key__onHandleShowing__TransitionerPropsMixin] ?? null)
          as Callback;
  @override
  set onHandleShowing(Callback value) =>
      props[_$key__onHandleShowing__TransitionerPropsMixin] = value;
  @override
  Callback get onHandleShown =>
      (props[_$key__onHandleShown__TransitionerPropsMixin] ?? null) as Callback;
  @override
  set onHandleShown(Callback value) =>
      props[_$key__onHandleShown__TransitionerPropsMixin] = value;
  @override
  Callback get onHandleHiding =>
      (props[_$key__onHandleHiding__TransitionerPropsMixin] ?? null)
          as Callback;
  @override
  set onHandleHiding(Callback value) =>
      props[_$key__onHandleHiding__TransitionerPropsMixin] = value;
  @override
  Callback get onHandleHidden =>
      (props[_$key__onHandleHidden__TransitionerPropsMixin] ?? null)
          as Callback;
  @override
  set onHandleHidden(Callback value) =>
      props[_$key__onHandleHidden__TransitionerPropsMixin] = value;
  @override
  Callback get onPrepareShow =>
      (props[_$key__onPrepareShow__TransitionerPropsMixin] ?? null) as Callback;
  @override
  set onPrepareShow(Callback value) =>
      props[_$key__onPrepareShow__TransitionerPropsMixin] = value;
  @override
  Callback get onPrepareHide =>
      (props[_$key__onPrepareHide__TransitionerPropsMixin] ?? null) as Callback;
  @override
  set onPrepareHide(Callback value) =>
      props[_$key__onPrepareHide__TransitionerPropsMixin] = value;
  @override
  bool get hasTransition =>
      (props[_$key__hasTransition__TransitionerPropsMixin] ?? null) as bool;
  @override
  set hasTransition(bool value) =>
      props[_$key__hasTransition__TransitionerPropsMixin] = value;
  @override
  bool get initiallyShown =>
      (props[_$key__initiallyShown__TransitionerPropsMixin] ?? null) as bool;
  @override
  set initiallyShown(bool value) =>
      props[_$key__initiallyShown__TransitionerPropsMixin] = value;
  @override
  Duration get transitionTimeout =>
      (props[_$key__transitionTimeout__TransitionerPropsMixin] ?? null)
          as Duration;
  @override
  set transitionTimeout(Duration value) =>
      props[_$key__transitionTimeout__TransitionerPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onHandlePreShowing__TransitionerPropsMixin =
      PropDescriptor(_$key__onHandlePreShowing__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onHandleShowing__TransitionerPropsMixin =
      PropDescriptor(_$key__onHandleShowing__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onHandleShown__TransitionerPropsMixin =
      PropDescriptor(_$key__onHandleShown__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onHandleHiding__TransitionerPropsMixin =
      PropDescriptor(_$key__onHandleHiding__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onHandleHidden__TransitionerPropsMixin =
      PropDescriptor(_$key__onHandleHidden__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onPrepareShow__TransitionerPropsMixin =
      PropDescriptor(_$key__onPrepareShow__TransitionerPropsMixin);
  static const PropDescriptor _$prop__onPrepareHide__TransitionerPropsMixin =
      PropDescriptor(_$key__onPrepareHide__TransitionerPropsMixin);
  static const PropDescriptor _$prop__hasTransition__TransitionerPropsMixin =
      PropDescriptor(_$key__hasTransition__TransitionerPropsMixin);
  static const PropDescriptor _$prop__initiallyShown__TransitionerPropsMixin =
      PropDescriptor(_$key__initiallyShown__TransitionerPropsMixin);
  static const PropDescriptor
      _$prop__transitionTimeout__TransitionerPropsMixin =
      PropDescriptor(_$key__transitionTimeout__TransitionerPropsMixin);
  static const String _$key__onHandlePreShowing__TransitionerPropsMixin =
      'TransitionerPropsMixin.onHandlePreShowing';
  static const String _$key__onHandleShowing__TransitionerPropsMixin =
      'TransitionerPropsMixin.onHandleShowing';
  static const String _$key__onHandleShown__TransitionerPropsMixin =
      'TransitionerPropsMixin.onHandleShown';
  static const String _$key__onHandleHiding__TransitionerPropsMixin =
      'TransitionerPropsMixin.onHandleHiding';
  static const String _$key__onHandleHidden__TransitionerPropsMixin =
      'TransitionerPropsMixin.onHandleHidden';
  static const String _$key__onPrepareShow__TransitionerPropsMixin =
      'TransitionerPropsMixin.onPrepareShow';
  static const String _$key__onPrepareHide__TransitionerPropsMixin =
      'TransitionerPropsMixin.onPrepareHide';
  static const String _$key__hasTransition__TransitionerPropsMixin =
      'TransitionerPropsMixin.hasTransition';
  static const String _$key__initiallyShown__TransitionerPropsMixin =
      'TransitionerPropsMixin.initiallyShown';
  static const String _$key__transitionTimeout__TransitionerPropsMixin =
      'TransitionerPropsMixin.transitionTimeout';

  static const List<PropDescriptor> $props = [
    _$prop__onHandlePreShowing__TransitionerPropsMixin,
    _$prop__onHandleShowing__TransitionerPropsMixin,
    _$prop__onHandleShown__TransitionerPropsMixin,
    _$prop__onHandleHiding__TransitionerPropsMixin,
    _$prop__onHandleHidden__TransitionerPropsMixin,
    _$prop__onPrepareShow__TransitionerPropsMixin,
    _$prop__onPrepareHide__TransitionerPropsMixin,
    _$prop__hasTransition__TransitionerPropsMixin,
    _$prop__initiallyShown__TransitionerPropsMixin,
    _$prop__transitionTimeout__TransitionerPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__onHandlePreShowing__TransitionerPropsMixin,
    _$key__onHandleShowing__TransitionerPropsMixin,
    _$key__onHandleShown__TransitionerPropsMixin,
    _$key__onHandleHiding__TransitionerPropsMixin,
    _$key__onHandleHidden__TransitionerPropsMixin,
    _$key__onPrepareShow__TransitionerPropsMixin,
    _$key__onPrepareHide__TransitionerPropsMixin,
    _$key__hasTransition__TransitionerPropsMixin,
    _$key__initiallyShown__TransitionerPropsMixin,
    _$key__transitionTimeout__TransitionerPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTransitionerPropsMixin = PropsMeta(
  fields: $TransitionerPropsMixin.$props,
  keys: $TransitionerPropsMixin.$propKeys,
);
