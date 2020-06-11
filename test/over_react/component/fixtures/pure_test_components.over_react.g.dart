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
    backingProps == null
        ? _$$PureTestWrapperProps$JsMap(JsBackedMap())
        : _$$PureTestWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$PureTestWrapperProps extends UiProps
    with
        SharedPureTestPropsMixin,
        $SharedPureTestPropsMixin, // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        PureTestWrapperPropsMixin,
        $PureTestWrapperPropsMixin // If this generated mixin is undefined, it's likely because PureTestWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of PureTestWrapperPropsMixin.
    implements
        PureTestWrapperProps {
  _$$PureTestWrapperProps._();

  factory _$$PureTestWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PureTestWrapperProps$JsMap(backingMap);
    } else {
      return _$$PureTestWrapperProps$PlainMap(backingMap);
    }
  }

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
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestWrapperProps$PlainMap extends _$$PureTestWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWrapperProps$PlainMap(Map backingMap)
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
class _$$PureTestWrapperProps$JsMap extends _$$PureTestWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWrapperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$PureTestWrapperComponent extends PureTestWrapperComponent {
  _$$PureTestWrapperProps$JsMap _cachedTypedProps;

  @override
  _$$PureTestWrapperProps$JsMap get props => _cachedTypedProps;

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
  _$$PureTestWrapperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestWrapperProps$JsMap(backingMap);

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
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because PureTestWrapperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of PureTestWrapperPropsMixin.
        PureTestWrapperPropsMixin: $PureTestWrapperPropsMixin.meta,
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

_$$PureTestProps _$PureTest([Map backingProps]) => backingProps == null
    ? _$$PureTestProps$JsMap(JsBackedMap())
    : _$$PureTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$PureTestProps extends UiProps
    with
        SharedPureTestPropsMixin,
        $SharedPureTestPropsMixin, // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        SharedPureTestChildPropsMixin,
        $SharedPureTestChildPropsMixin // If this generated mixin is undefined, it's likely because SharedPureTestChildPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildPropsMixin.
    implements
        PureTestProps {
  _$$PureTestProps._();

  factory _$$PureTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PureTestProps$JsMap(backingMap);
    } else {
      return _$$PureTestProps$PlainMap(backingMap);
    }
  }

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
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestProps$PlainMap extends _$$PureTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestProps$PlainMap(Map backingMap)
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
class _$$PureTestProps$JsMap extends _$$PureTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$PureTestState extends UiState
    with
        SharedPureTestChildStateMixin,
        $SharedPureTestChildStateMixin // If this generated mixin is undefined, it's likely because SharedPureTestChildStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildStateMixin.
    implements
        PureTestState {
  _$$PureTestState._();

  factory _$$PureTestState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PureTestState$JsMap(backingMap);
    } else {
      return _$$PureTestState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestState$PlainMap extends _$$PureTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestState$PlainMap(Map backingMap)
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
class _$$PureTestState$JsMap extends _$$PureTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestState$JsMap(JsBackedMap backingMap)
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
class _$PureTestComponent extends PureTestComponent {
  _$$PureTestProps$JsMap _cachedTypedProps;

  @override
  _$$PureTestProps$JsMap get props => _cachedTypedProps;

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
  _$$PureTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestProps$JsMap(backingMap);

  @override
  _$$PureTestProps typedPropsFactory(Map backingMap) =>
      _$$PureTestProps(backingMap);

  _$$PureTestState$JsMap _cachedTypedState;
  @override
  _$$PureTestState$JsMap get state => _cachedTypedState;

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
  _$$PureTestState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$PureTestState$JsMap(backingMap);

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
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because SharedPureTestChildPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildPropsMixin.
        SharedPureTestChildPropsMixin: $SharedPureTestChildPropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $PureTestWithoutChildrenSupportComponentFactory = registerComponent2(
  () => _$PureTestWithoutChildrenSupportComponent(),
  builderFactory: _$PureTestWithoutChildrenSupport,
  componentClass: PureTestWithoutChildrenSupportComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'PureTestWithoutChildrenSupport',
);

_$$PureTestWithoutChildrenSupportProps _$PureTestWithoutChildrenSupport(
        [Map backingProps]) =>
    backingProps == null
        ? _$$PureTestWithoutChildrenSupportProps$JsMap(JsBackedMap())
        : _$$PureTestWithoutChildrenSupportProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$PureTestWithoutChildrenSupportProps extends UiProps
    with
        SharedPureTestPropsMixin,
        $SharedPureTestPropsMixin, // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        SharedPureTestChildPropsMixin,
        $SharedPureTestChildPropsMixin // If this generated mixin is undefined, it's likely because SharedPureTestChildPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildPropsMixin.
    implements
        PureTestWithoutChildrenSupportProps {
  _$$PureTestWithoutChildrenSupportProps._();

  factory _$$PureTestWithoutChildrenSupportProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PureTestWithoutChildrenSupportProps$JsMap(backingMap);
    } else {
      return _$$PureTestWithoutChildrenSupportProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PureTestWithoutChildrenSupportComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestWithoutChildrenSupportProps$PlainMap
    extends _$$PureTestWithoutChildrenSupportProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWithoutChildrenSupportProps$PlainMap(Map backingMap)
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
class _$$PureTestWithoutChildrenSupportProps$JsMap
    extends _$$PureTestWithoutChildrenSupportProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWithoutChildrenSupportProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$PureTestWithoutChildrenSupportState extends UiState
    with
        SharedPureTestChildStateMixin,
        $SharedPureTestChildStateMixin // If this generated mixin is undefined, it's likely because SharedPureTestChildStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildStateMixin.
    implements
        PureTestWithoutChildrenSupportState {
  _$$PureTestWithoutChildrenSupportState._();

  factory _$$PureTestWithoutChildrenSupportState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PureTestWithoutChildrenSupportState$JsMap(backingMap);
    } else {
      return _$$PureTestWithoutChildrenSupportState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$PureTestWithoutChildrenSupportState$PlainMap
    extends _$$PureTestWithoutChildrenSupportState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWithoutChildrenSupportState$PlainMap(Map backingMap)
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
class _$$PureTestWithoutChildrenSupportState$JsMap
    extends _$$PureTestWithoutChildrenSupportState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PureTestWithoutChildrenSupportState$JsMap(JsBackedMap backingMap)
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
class _$PureTestWithoutChildrenSupportComponent
    extends PureTestWithoutChildrenSupportComponent {
  _$$PureTestWithoutChildrenSupportProps$JsMap _cachedTypedProps;

  @override
  _$$PureTestWithoutChildrenSupportProps$JsMap get props => _cachedTypedProps;

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
  _$$PureTestWithoutChildrenSupportProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$PureTestWithoutChildrenSupportProps$JsMap(backingMap);

  @override
  _$$PureTestWithoutChildrenSupportProps typedPropsFactory(Map backingMap) =>
      _$$PureTestWithoutChildrenSupportProps(backingMap);

  _$$PureTestWithoutChildrenSupportState$JsMap _cachedTypedState;
  @override
  _$$PureTestWithoutChildrenSupportState$JsMap get state => _cachedTypedState;

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
  _$$PureTestWithoutChildrenSupportState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$PureTestWithoutChildrenSupportState$JsMap(backingMap);

  @override
  _$$PureTestWithoutChildrenSupportState typedStateFactory(Map backingMap) =>
      _$$PureTestWithoutChildrenSupportState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by PureTestWithoutChildrenSupportProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SharedPureTestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestPropsMixin.
        SharedPureTestPropsMixin: $SharedPureTestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because SharedPureTestChildPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SharedPureTestChildPropsMixin.
        SharedPureTestChildPropsMixin: $SharedPureTestChildPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $PureTestWrapperPropsMixin on PureTestWrapperPropsMixin {
  static const PropsMeta meta = _$metaForPureTestWrapperPropsMixin;
  @override
  UiFactory<SharedPureTestChildPropsMixin> get childFactory =>
      props[_$key__childFactory__PureTestWrapperPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childFactory(UiFactory<SharedPureTestChildPropsMixin> value) =>
      props[_$key__childFactory__PureTestWrapperPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__childFactory__PureTestWrapperPropsMixin =
      PropDescriptor(_$key__childFactory__PureTestWrapperPropsMixin);
  static const String _$key__childFactory__PureTestWrapperPropsMixin =
      'PureTestWrapperPropsMixin.childFactory';

  static const List<PropDescriptor> $props = [
    _$prop__childFactory__PureTestWrapperPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__childFactory__PureTestWrapperPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForPureTestWrapperPropsMixin = PropsMeta(
  fields: $PureTestWrapperPropsMixin.$props,
  keys: $PureTestWrapperPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SharedPureTestPropsMixin on SharedPureTestPropsMixin {
  static const PropsMeta meta = _$metaForSharedPureTestPropsMixin;
  @override
  bool get sharedBoolProp =>
      props[_$key__sharedBoolProp__SharedPureTestPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set sharedBoolProp(bool value) =>
      props[_$key__sharedBoolProp__SharedPureTestPropsMixin] = value;
  @override
  ReactElement get someVDomEl =>
      props[_$key__someVDomEl__SharedPureTestPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
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
mixin $SharedPureTestChildPropsMixin on SharedPureTestChildPropsMixin {
  static const PropsMeta meta = _$metaForSharedPureTestChildPropsMixin;
  @override
  bool get childBoolProp =>
      props[_$key__childBoolProp__SharedPureTestChildPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childBoolProp(bool value) =>
      props[_$key__childBoolProp__SharedPureTestChildPropsMixin] = value;
  @override
  void Function() get childFuncProp =>
      props[_$key__childFuncProp__SharedPureTestChildPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childFuncProp(void Function() value) =>
      props[_$key__childFuncProp__SharedPureTestChildPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__childBoolProp__SharedPureTestChildPropsMixin =
      PropDescriptor(_$key__childBoolProp__SharedPureTestChildPropsMixin);
  static const PropDescriptor
      _$prop__childFuncProp__SharedPureTestChildPropsMixin =
      PropDescriptor(_$key__childFuncProp__SharedPureTestChildPropsMixin);
  static const String _$key__childBoolProp__SharedPureTestChildPropsMixin =
      'SharedPureTestChildPropsMixin.childBoolProp';
  static const String _$key__childFuncProp__SharedPureTestChildPropsMixin =
      'SharedPureTestChildPropsMixin.childFuncProp';

  static const List<PropDescriptor> $props = [
    _$prop__childBoolProp__SharedPureTestChildPropsMixin,
    _$prop__childFuncProp__SharedPureTestChildPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__childBoolProp__SharedPureTestChildPropsMixin,
    _$key__childFuncProp__SharedPureTestChildPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSharedPureTestChildPropsMixin = PropsMeta(
  fields: $SharedPureTestChildPropsMixin.$props,
  keys: $SharedPureTestChildPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SharedPureTestChildStateMixin on SharedPureTestChildStateMixin {
  static const StateMeta meta = _$metaForSharedPureTestChildStateMixin;
  @override
  bool get childBoolState =>
      state[_$key__childBoolState__SharedPureTestChildStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childBoolState(bool value) =>
      state[_$key__childBoolState__SharedPureTestChildStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__childBoolState__SharedPureTestChildStateMixin =
      StateDescriptor(_$key__childBoolState__SharedPureTestChildStateMixin);
  static const String _$key__childBoolState__SharedPureTestChildStateMixin =
      'SharedPureTestChildStateMixin.childBoolState';

  static const List<StateDescriptor> $state = [
    _$prop__childBoolState__SharedPureTestChildStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__childBoolState__SharedPureTestChildStateMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForSharedPureTestChildStateMixin = StateMeta(
  fields: $SharedPureTestChildStateMixin.$state,
  keys: $SharedPureTestChildStateMixin.$stateKeys,
);
