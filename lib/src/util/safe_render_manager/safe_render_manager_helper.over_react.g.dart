// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'safe_render_manager_helper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $SafeRenderManagerHelperComponentFactory = registerComponent2(
  () => _$SafeRenderManagerHelperComponent(),
  builderFactory: _$SafeRenderManagerHelper,
  componentClass: SafeRenderManagerHelperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'SafeRenderManagerHelper',
);

_$$SafeRenderManagerHelperProps _$SafeRenderManagerHelper([Map backingProps]) =>
    _$$SafeRenderManagerHelperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SafeRenderManagerHelperProps extends UiProps
    with SafeRenderManagerHelperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperProps(Map backingMap)
      : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SafeRenderManagerHelperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SafeRenderManagerHelperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SafeRenderManagerHelperProps, and check that $SafeRenderManagerHelperProps is exported/imported properly.
        SafeRenderManagerHelperProps: $SafeRenderManagerHelperProps.meta,
      });
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SafeRenderManagerHelperState extends UiState
    with SafeRenderManagerHelperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperState(Map backingMap)
      : this.state = backingMap ?? ({});

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
class _$SafeRenderManagerHelperComponent
    extends SafeRenderManagerHelperComponent {
  _$$SafeRenderManagerHelperProps _cachedTypedProps;

  @override
  _$$SafeRenderManagerHelperProps get props => _cachedTypedProps;

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
  _$$SafeRenderManagerHelperProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$SafeRenderManagerHelperProps(backingMap);

  @override
  _$$SafeRenderManagerHelperProps typedPropsFactory(Map backingMap) =>
      _$$SafeRenderManagerHelperProps(backingMap);

  _$$SafeRenderManagerHelperState _cachedTypedState;
  @override
  _$$SafeRenderManagerHelperState get state => _cachedTypedState;

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
  _$$SafeRenderManagerHelperState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$SafeRenderManagerHelperState(backingMap);

  @override
  _$$SafeRenderManagerHelperState typedStateFactory(Map backingMap) =>
      _$$SafeRenderManagerHelperState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by SafeRenderManagerHelperProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SafeRenderManagerHelperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SafeRenderManagerHelperProps, and check that $SafeRenderManagerHelperProps is exported/imported properly.
        SafeRenderManagerHelperProps: $SafeRenderManagerHelperProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SafeRenderManagerHelperProps on SafeRenderManagerHelperProps {
  static const PropsMeta meta = _$metaForSafeRenderManagerHelperProps;
  @override
  @requiredProp
  ReactElement Function() get getInitialContent =>
      (props[_$key__getInitialContent__SafeRenderManagerHelperProps] ?? null)
          as ReactElement Function();
  @override
  @requiredProp
  set getInitialContent(ReactElement Function() value) =>
      props[_$key__getInitialContent__SafeRenderManagerHelperProps] = value;
  @override
  dynamic get contentRef =>
      (props[_$key__contentRef__SafeRenderManagerHelperProps] ?? null)
          as dynamic;
  @override
  set contentRef(dynamic value) =>
      props[_$key__contentRef__SafeRenderManagerHelperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__getInitialContent__SafeRenderManagerHelperProps = PropDescriptor(
          _$key__getInitialContent__SafeRenderManagerHelperProps,
          isRequired: true);
  static const PropDescriptor _$prop__contentRef__SafeRenderManagerHelperProps =
      PropDescriptor(_$key__contentRef__SafeRenderManagerHelperProps);
  static const String _$key__getInitialContent__SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.getInitialContent';
  static const String _$key__contentRef__SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.contentRef';

  static const List<PropDescriptor> $props = [
    _$prop__getInitialContent__SafeRenderManagerHelperProps,
    _$prop__contentRef__SafeRenderManagerHelperProps
  ];
  static const List<String> $propKeys = [
    _$key__getInitialContent__SafeRenderManagerHelperProps,
    _$key__contentRef__SafeRenderManagerHelperProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSafeRenderManagerHelperProps = PropsMeta(
  fields: $SafeRenderManagerHelperProps.$props,
  keys: $SafeRenderManagerHelperProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SafeRenderManagerHelperState on SafeRenderManagerHelperState {
  static const StateMeta meta = _$metaForSafeRenderManagerHelperState;
  @override
  ReactElement get content =>
      (state[_$key__content__SafeRenderManagerHelperState] ?? null)
          as ReactElement;
  @override
  set content(ReactElement value) =>
      state[_$key__content__SafeRenderManagerHelperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__content__SafeRenderManagerHelperState =
      StateDescriptor(_$key__content__SafeRenderManagerHelperState);
  static const String _$key__content__SafeRenderManagerHelperState =
      'SafeRenderManagerHelperState.content';

  static const List<StateDescriptor> $state = [
    _$prop__content__SafeRenderManagerHelperState
  ];
  static const List<String> $stateKeys = [
    _$key__content__SafeRenderManagerHelperState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForSafeRenderManagerHelperState = StateMeta(
  fields: $SafeRenderManagerHelperState.$state,
  keys: $SafeRenderManagerHelperState.$stateKeys,
);
