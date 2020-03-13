// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_library.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $BasicPartOfLibComponentFactory = registerComponent2(
  () => _$BasicPartOfLibComponent(),
  builderFactory: BasicPartOfLib,
  componentClass: BasicPartOfLibComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'BasicPartOfLib',
);

_$$BasicPartOfLibProps _$BasicPartOfLib([Map backingProps]) =>
    backingProps == null
        ? _$$BasicPartOfLibProps$JsMap(JsBackedMap())
        : _$$BasicPartOfLibProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicPartOfLibProps extends UiProps
    with
        ExamplePropsMixin,
        $ExamplePropsMixin,
        BasicPartOfLibPropsMixin,
        $BasicPartOfLibPropsMixin
    implements BasicPartOfLibProps {
  _$$BasicPartOfLibProps._();

  factory _$$BasicPartOfLibProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicPartOfLibProps$JsMap(backingMap);
    } else {
      return _$$BasicPartOfLibProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicPartOfLibProps$PlainMap extends _$$BasicPartOfLibProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicPartOfLibProps$PlainMap(Map backingMap)
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
class _$$BasicPartOfLibProps$JsMap extends _$$BasicPartOfLibProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicPartOfLibProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$BasicPartOfLibState extends UiState
    with
        ExampleStateMixin,
        $ExampleStateMixin,
        BasicPartOfLibStateMixin,
        $BasicPartOfLibStateMixin
    implements BasicPartOfLibState {
  _$$BasicPartOfLibState._();

  factory _$$BasicPartOfLibState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicPartOfLibState$JsMap(backingMap);
    } else {
      return _$$BasicPartOfLibState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicPartOfLibState$PlainMap extends _$$BasicPartOfLibState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicPartOfLibState$PlainMap(Map backingMap)
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
class _$$BasicPartOfLibState$JsMap extends _$$BasicPartOfLibState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicPartOfLibState$JsMap(JsBackedMap backingMap)
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
class _$BasicPartOfLibComponent extends BasicPartOfLibComponent {
  _$$BasicPartOfLibProps$JsMap _cachedTypedProps;

  @override
  _$$BasicPartOfLibProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicPartOfLibProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicPartOfLibProps$JsMap(backingMap);

  @override
  _$$BasicPartOfLibProps typedPropsFactory(Map backingMap) =>
      _$$BasicPartOfLibProps(backingMap);

  _$$BasicPartOfLibState$JsMap _cachedTypedState;
  @override
  _$$BasicPartOfLibState$JsMap get state => _cachedTypedState;

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
  _$$BasicPartOfLibState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$BasicPartOfLibState$JsMap(backingMap);

  @override
  _$$BasicPartOfLibState typedStateFactory(Map backingMap) =>
      _$$BasicPartOfLibState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from BasicPartOfLibProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        ExamplePropsMixin: $ExamplePropsMixin.meta,
        BasicPartOfLibPropsMixin: $BasicPartOfLibPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicPartOfLibPropsMixin on BasicPartOfLibPropsMixin {
  static const PropsMeta meta = _$metaForBasicPartOfLibPropsMixin;
  @override
  String get basicProp =>
      props[_$key__basicProp__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicProp(String value) =>
      props[_$key__basicProp__BasicPartOfLibPropsMixin] = value;
  @override
  String get basic1 =>
      props[_$key__basic1__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic1(String value) =>
      props[_$key__basic1__BasicPartOfLibPropsMixin] = value;
  @override
  String get basic2 =>
      props[_$key__basic2__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic2(String value) =>
      props[_$key__basic2__BasicPartOfLibPropsMixin] = value;
  @override
  String get basic3 =>
      props[_$key__basic3__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic3(String value) =>
      props[_$key__basic3__BasicPartOfLibPropsMixin] = value;
  @override
  String get basic4 =>
      props[_$key__basic4__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic4(String value) =>
      props[_$key__basic4__BasicPartOfLibPropsMixin] = value;
  @override
  String get basic5 =>
      props[_$key__basic5__BasicPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic5(String value) =>
      props[_$key__basic5__BasicPartOfLibPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basicProp__BasicPartOfLibPropsMixin);
  static const PropDescriptor _$prop__basic1__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basic1__BasicPartOfLibPropsMixin);
  static const PropDescriptor _$prop__basic2__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basic2__BasicPartOfLibPropsMixin);
  static const PropDescriptor _$prop__basic3__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basic3__BasicPartOfLibPropsMixin);
  static const PropDescriptor _$prop__basic4__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basic4__BasicPartOfLibPropsMixin);
  static const PropDescriptor _$prop__basic5__BasicPartOfLibPropsMixin =
      PropDescriptor(_$key__basic5__BasicPartOfLibPropsMixin);
  static const String _$key__basicProp__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basicProp';
  static const String _$key__basic1__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basic1';
  static const String _$key__basic2__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basic2';
  static const String _$key__basic3__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basic3';
  static const String _$key__basic4__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basic4';
  static const String _$key__basic5__BasicPartOfLibPropsMixin =
      'BasicPartOfLibPropsMixin.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp__BasicPartOfLibPropsMixin,
    _$prop__basic1__BasicPartOfLibPropsMixin,
    _$prop__basic2__BasicPartOfLibPropsMixin,
    _$prop__basic3__BasicPartOfLibPropsMixin,
    _$prop__basic4__BasicPartOfLibPropsMixin,
    _$prop__basic5__BasicPartOfLibPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__basicProp__BasicPartOfLibPropsMixin,
    _$key__basic1__BasicPartOfLibPropsMixin,
    _$key__basic2__BasicPartOfLibPropsMixin,
    _$key__basic3__BasicPartOfLibPropsMixin,
    _$key__basic4__BasicPartOfLibPropsMixin,
    _$key__basic5__BasicPartOfLibPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicPartOfLibPropsMixin = PropsMeta(
  fields: $BasicPartOfLibPropsMixin.$props,
  keys: $BasicPartOfLibPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicPartOfLibStateMixin on BasicPartOfLibStateMixin {
  static const StateMeta meta = _$metaForBasicPartOfLibStateMixin;
  @override
  String get basicState =>
      state[_$key__basicState__BasicPartOfLibStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicState(String value) =>
      state[_$key__basicState__BasicPartOfLibStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState__BasicPartOfLibStateMixin =
      StateDescriptor(_$key__basicState__BasicPartOfLibStateMixin);
  static const String _$key__basicState__BasicPartOfLibStateMixin =
      'BasicPartOfLibStateMixin.basicState';

  static const List<StateDescriptor> $state = [
    _$prop__basicState__BasicPartOfLibStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__basicState__BasicPartOfLibStateMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForBasicPartOfLibStateMixin = StateMeta(
  fields: $BasicPartOfLibStateMixin.$state,
  keys: $BasicPartOfLibStateMixin.$stateKeys,
);

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $SubPartOfLibComponentFactory = registerComponent2(
  () => _$SubPartOfLibComponent(),
  builderFactory: SubPartOfLib,
  componentClass: SubPartOfLibComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'SubPartOfLib',
);

_$$SubPartOfLibProps _$SubPartOfLib([Map backingProps]) => backingProps == null
    ? _$$SubPartOfLibProps$JsMap(JsBackedMap())
    : _$$SubPartOfLibProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SubPartOfLibProps extends UiProps
    with
        SuperPartOfLibPropsMixin,
        $SuperPartOfLibPropsMixin,
        SubPartOfLibPropsMixin,
        $SubPartOfLibPropsMixin
    implements SubPartOfLibProps {
  _$$SubPartOfLibProps._();

  factory _$$SubPartOfLibProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubPartOfLibProps$JsMap(backingMap);
    } else {
      return _$$SubPartOfLibProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SubPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SubPartOfLibProps$PlainMap extends _$$SubPartOfLibProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubPartOfLibProps$PlainMap(Map backingMap)
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
class _$$SubPartOfLibProps$JsMap extends _$$SubPartOfLibProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubPartOfLibProps$JsMap(JsBackedMap backingMap)
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
class _$SubPartOfLibComponent extends SubPartOfLibComponent {
  _$$SubPartOfLibProps$JsMap _cachedTypedProps;

  @override
  _$$SubPartOfLibProps$JsMap get props => _cachedTypedProps;

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
  _$$SubPartOfLibProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$SubPartOfLibProps$JsMap(backingMap);

  @override
  _$$SubPartOfLibProps typedPropsFactory(Map backingMap) =>
      _$$SubPartOfLibProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from SubPartOfLibProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        SuperPartOfLibPropsMixin: $SuperPartOfLibPropsMixin.meta,
        SubPartOfLibPropsMixin: $SubPartOfLibPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SuperPartOfLibPropsMixin on SuperPartOfLibPropsMixin {
  static const PropsMeta meta = _$metaForSuperPartOfLibPropsMixin;
  @override
  String get superProp =>
      props[_$key__superProp__SuperPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superProp(String value) =>
      props[_$key__superProp__SuperPartOfLibPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__superProp__SuperPartOfLibPropsMixin =
      PropDescriptor(_$key__superProp__SuperPartOfLibPropsMixin);
  static const String _$key__superProp__SuperPartOfLibPropsMixin =
      'SuperPartOfLibPropsMixin.superProp';

  static const List<PropDescriptor> $props = [
    _$prop__superProp__SuperPartOfLibPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__superProp__SuperPartOfLibPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSuperPartOfLibPropsMixin = PropsMeta(
  fields: $SuperPartOfLibPropsMixin.$props,
  keys: $SuperPartOfLibPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SubPartOfLibPropsMixin on SubPartOfLibPropsMixin {
  static const PropsMeta meta = _$metaForSubPartOfLibPropsMixin;
  @override
  String get subProp =>
      props[_$key__subProp__SubPartOfLibPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set subProp(String value) =>
      props[_$key__subProp__SubPartOfLibPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp__SubPartOfLibPropsMixin =
      PropDescriptor(_$key__subProp__SubPartOfLibPropsMixin);
  static const String _$key__subProp__SubPartOfLibPropsMixin =
      'SubPartOfLibPropsMixin.subProp';

  static const List<PropDescriptor> $props = [
    _$prop__subProp__SubPartOfLibPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__subProp__SubPartOfLibPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSubPartOfLibPropsMixin = PropsMeta(
  fields: $SubPartOfLibPropsMixin.$props,
  keys: $SubPartOfLibPropsMixin.$propKeys,
);
