// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'pure_test_components.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $PureTestWrapperComponentFactory = registerComponent2(
  () => _$PureTestWrapperComponent(),
  builderFactory: _$PureTestWrapper,
  componentClass: PureTestWrapperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'PureTestWrapper',
);

_$$PureTestWrapperProps _$PureTestWrapper([Map backingProps]) =>
    _$$PureTestWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestWrapperProps extends PureTestWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWrapperProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PureTestWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPureTestPropsMixin, and check that $SharedPureTestPropsMixin is exported/imported properly.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
      });
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$PureTestWrapperComponent extends PureTestWrapperComponent {
  _$$PureTestWrapperProps _cachedTypedProps;

  @override
  _$$PureTestWrapperProps get props => _cachedTypedProps;

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
  _$$PureTestWrapperProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestWrapperProps(backingMap);

  @override
  _$$PureTestWrapperProps typedPropsFactory(Map backingMap) =>
      _$$PureTestWrapperProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by PureTestWrapperProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPureTestPropsMixin, and check that $SharedPureTestPropsMixin is exported/imported properly.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $PureTestComponentFactory = registerComponent2(
  () => _$PureTestComponent(),
  builderFactory: _$PureTest,
  componentClass: PureTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'PureTest',
);

_$$PureTestProps _$PureTest([Map backingProps]) =>
    _$$PureTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestProps extends PureTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PureTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPureTestPropsMixin, and check that $SharedPureTestPropsMixin is exported/imported properly.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because PureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of PureTestPropsMixin, and check that $PureTestPropsMixin is exported/imported properly.
        PureTestPropsMixin: $PureTestPropsMixin.meta,
      });
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestState extends UiState with PureTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestState(Map backingMap) : this.state = backingMap ?? ({});

  /// The backing state map proxied by this class.
  @override
  final Map state;

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$PureTestComponent extends PureTestComponent {
  _$$PureTestProps _cachedTypedProps;

  @override
  _$$PureTestProps get props => _cachedTypedProps;

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
  _$$PureTestProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestProps(backingMap);

  @override
  _$$PureTestProps typedPropsFactory(Map backingMap) =>
      _$$PureTestProps(backingMap);

  _$$PureTestState _cachedTypedState;
  @override
  _$$PureTestState get state => _cachedTypedState;

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
  _$$PureTestState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestState(backingMap);

  @override
  _$$PureTestState typedStateFactory(Map backingMap) =>
      _$$PureTestState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by PureTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPureTestPropsMixin, and check that $SharedPureTestPropsMixin is exported/imported properly.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because PureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of PureTestPropsMixin, and check that $PureTestPropsMixin is exported/imported properly.
        PureTestPropsMixin: $PureTestPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $PureTestPropsMixin on PureTestPropsMixin {
  static const PropsMeta meta = _$metaForPureTestPropsMixin;
  @override
  bool get childBoolProp =>
      (props[_$key__childBoolProp__PureTestPropsMixin] ?? null) as bool;
  @override
  set childBoolProp(bool value) =>
      props[_$key__childBoolProp__PureTestPropsMixin] = value;
  @override
  void Function() get childFuncProp =>
      (props[_$key__childFuncProp__PureTestPropsMixin] ?? null) as void
          Function();
  @override
  set childFuncProp(void Function() value) =>
      props[_$key__childFuncProp__PureTestPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__childBoolProp__PureTestPropsMixin =
      PropDescriptor(_$key__childBoolProp__PureTestPropsMixin);
  static const PropDescriptor _$prop__childFuncProp__PureTestPropsMixin =
      PropDescriptor(_$key__childFuncProp__PureTestPropsMixin);
  static const String _$key__childBoolProp__PureTestPropsMixin =
      'PureTestPropsMixin.childBoolProp';
  static const String _$key__childFuncProp__PureTestPropsMixin =
      'PureTestPropsMixin.childFuncProp';

  static const List<PropDescriptor> $props = [
    _$prop__childBoolProp__PureTestPropsMixin,
    _$prop__childFuncProp__PureTestPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__childBoolProp__PureTestPropsMixin,
    _$key__childFuncProp__PureTestPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForPureTestPropsMixin = PropsMeta(
  fields: $PureTestPropsMixin.$props,
  keys: $PureTestPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SharedPureTestPropsMixin on SharedPureTestPropsMixin {
  static const PropsMeta meta = _$metaForSharedPureTestPropsMixin;
  @override
  bool get sharedBoolProp =>
      (props[_$key__sharedBoolProp__SharedPureTestPropsMixin] ?? null) as bool;
  @override
  set sharedBoolProp(bool value) =>
      props[_$key__sharedBoolProp__SharedPureTestPropsMixin] = value;
  @override
  ReactElement get someVDomEl =>
      (props[_$key__someVDomEl__SharedPureTestPropsMixin] ?? null)
          as ReactElement;
  @override
  set someVDomEl(ReactElement value) =>
      props[_$key__someVDomEl__SharedPureTestPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__sharedBoolProp__SharedPureTestPropsMixin =
      PropDescriptor(_$key__sharedBoolProp__SharedPureTestPropsMixin);
  static const PropDescriptor _$prop__someVDomEl__SharedPureTestPropsMixin =
      PropDescriptor(_$key__someVDomEl__SharedPureTestPropsMixin);
  static const String _$key__sharedBoolProp__SharedPureTestPropsMixin =
      'SharedPureTestPropsMixin.sharedBoolProp';
  static const String _$key__someVDomEl__SharedPureTestPropsMixin =
      'SharedPureTestPropsMixin.someVDomEl';

  static const List<PropDescriptor> $props = [
    _$prop__sharedBoolProp__SharedPureTestPropsMixin,
    _$prop__someVDomEl__SharedPureTestPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__sharedBoolProp__SharedPureTestPropsMixin,
    _$key__someVDomEl__SharedPureTestPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSharedPureTestPropsMixin = PropsMeta(
  fields: $SharedPureTestPropsMixin.$props,
  keys: $SharedPureTestPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $PureTestState on PureTestState {
  static const StateMeta meta = _$metaForPureTestState;
  @override
  bool get childBoolState =>
      (state[_$key__childBoolState__PureTestState] ?? null) as bool;
  @override
  set childBoolState(bool value) =>
      state[_$key__childBoolState__PureTestState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__childBoolState__PureTestState =
      StateDescriptor(_$key__childBoolState__PureTestState);
  static const String _$key__childBoolState__PureTestState =
      'PureTestState.childBoolState';

  static const List<StateDescriptor> $state = [
    _$prop__childBoolState__PureTestState
  ];
  static const List<String> $stateKeys = [_$key__childBoolState__PureTestState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForPureTestState = StateMeta(
  fields: $PureTestState.$state,
  keys: $PureTestState.$stateKeys,
);
