import 'package:over_react/over_react.dart';

import 'basic_library.dart';

final $BasicPartOfLibComponentFactory = registerComponent2(
  () => _$BasicPartOfLibComponent(),
  builderFactory: BasicPartOfLib,
  componentClass: BasicPartOfLibComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'BasicPartOfLib',
);

mixin $BasicPartOfLibPropsMixin implements BasicPartOfLibPropsMixin {
  @override
  Map get props;

  @override
  String get basicProp => props[_$key__basicProp___$BasicPartOfLibProps] ?? null;

  @override
  set basicProp(String value) => props[_$key__basicProp___$BasicPartOfLibProps] = value;

  @override
  String get basic1 => props[_$key__basic1___$BasicPartOfLibProps] ?? null;

  @override
  set basic1(String value) => props[_$key__basic1___$BasicPartOfLibProps] = value;

  @override
  String get basic2 => props[_$key__basic2___$BasicPartOfLibProps] ?? null;

  @override
  set basic2(String value) => props[_$key__basic2___$BasicPartOfLibProps] = value;

  @override
  String get basic3 => props[_$key__basic3___$BasicPartOfLibProps] ?? null;

  @override
  set basic3(String value) => props[_$key__basic3___$BasicPartOfLibProps] = value;

  @override
  String get basic4 => props[_$key__basic4___$BasicPartOfLibProps] ?? null;

  @override
  set basic4(String value) => props[_$key__basic4___$BasicPartOfLibProps] = value;

  @override
  String get basic5 => props[_$key__basic5___$BasicPartOfLibProps] ?? null;

  @override
  set basic5(String value) => props[_$key__basic5___$BasicPartOfLibProps] = value;

  static const _$prop__basicProp___$BasicPartOfLibProps = PropDescriptor(_$key__basicProp___$BasicPartOfLibProps);
  static const _$prop__basic1___$BasicPartOfLibProps = PropDescriptor(_$key__basic1___$BasicPartOfLibProps);
  static const _$prop__basic2___$BasicPartOfLibProps = PropDescriptor(_$key__basic2___$BasicPartOfLibProps);
  static const _$prop__basic3___$BasicPartOfLibProps = PropDescriptor(_$key__basic3___$BasicPartOfLibProps);
  static const _$prop__basic4___$BasicPartOfLibProps = PropDescriptor(_$key__basic4___$BasicPartOfLibProps);
  static const _$prop__basic5___$BasicPartOfLibProps = PropDescriptor(_$key__basic5___$BasicPartOfLibProps);
  static const _$key__basicProp___$BasicPartOfLibProps = 'BasicPartOfLibProps.basicProp';
  static const _$key__basic1___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic1';
  static const _$key__basic2___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic2';
  static const _$key__basic3___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic3';
  static const _$key__basic4___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic4';
  static const _$key__basic5___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp___$BasicPartOfLibProps,
    _$prop__basic1___$BasicPartOfLibProps,
    _$prop__basic2___$BasicPartOfLibProps,
    _$prop__basic3___$BasicPartOfLibProps,
    _$prop__basic4___$BasicPartOfLibProps,
    _$prop__basic5___$BasicPartOfLibProps
  ];
  static const List<String> $propKeys = [
    _$key__basicProp___$BasicPartOfLibProps,
    _$key__basic1___$BasicPartOfLibProps,
    _$key__basic2___$BasicPartOfLibProps,
    _$key__basic3___$BasicPartOfLibProps,
    _$key__basic4___$BasicPartOfLibProps,
    _$key__basic5___$BasicPartOfLibProps
  ];
}

const PropsMeta _$metaForBasicPartOfLibProps = PropsMeta(
  fields: $BasicPartOfLibPropsMixin.$props,
  keys: $BasicPartOfLibPropsMixin.$propKeys,
);

$BasicPartOfLibProps $BasicPartOfLib([Map backingProps]) =>
    backingProps == null ? _$$BasicPartOfLibProps$JsMap(JsBackedMap()) : $BasicPartOfLibProps(backingProps);

class $BasicPartOfLibProps extends BasicPartOfLibProps with BasicPartOfLibPropsMixin, $BasicPartOfLibPropsMixin {
  $BasicPartOfLibProps._();

  factory $BasicPartOfLibProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicPartOfLibProps$JsMap(backingMap);
    } else {
      return _$$BasicPartOfLibProps$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $BasicPartOfLibComponentFactory;

  @override
  String get propKeyNamespace => 'BasicPartOfLibProps.';
}

class _$$BasicPartOfLibProps$PlainMap extends $BasicPartOfLibProps
    with BasicPartOfLibPropsMixin, $BasicPartOfLibPropsMixin {
  _$$BasicPartOfLibProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$BasicPartOfLibProps$JsMap extends $BasicPartOfLibProps
    with BasicPartOfLibPropsMixin, $BasicPartOfLibPropsMixin {
  _$$BasicPartOfLibProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $BasicPartOfLibStateMixin implements BasicPartOfLibStateMixin {
  @override
  Map get state;

  @override
  String get basicState => state[_$key__basicState___$BasicPartOfLibState] ?? null;

  @override
  set basicState(String value) => state[_$key__basicState___$BasicPartOfLibState] = value;

  static const _$prop__basicState___$BasicPartOfLibState = StateDescriptor(_$key__basicState___$BasicPartOfLibState);
  static const _$key__basicState___$BasicPartOfLibState = 'BasicPartOfLibState.basicState';

  static const List<StateDescriptor> $state = [_$prop__basicState___$BasicPartOfLibState];
  static const List<String> $stateKeys = [_$key__basicState___$BasicPartOfLibState];
}

const StateMeta _$metaForBasicPartOfLibState = StateMeta(
  fields: $BasicPartOfLibStateMixin.$state,
  keys: $BasicPartOfLibStateMixin.$stateKeys,
);

class $BasicPartOfLibState extends BasicPartOfLibState with BasicPartOfLibStateMixin, $BasicPartOfLibStateMixin {
  $BasicPartOfLibState._();

  static const StateMeta meta = _$metaForBasicPartOfLibState;

  factory $BasicPartOfLibState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicPartOfLibState$JsMap(backingMap);
    } else {
      return _$$BasicPartOfLibState$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;
}

class _$$BasicPartOfLibState$PlainMap extends $BasicPartOfLibState
    with BasicPartOfLibStateMixin, $BasicPartOfLibStateMixin {
  _$$BasicPartOfLibState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  @override
  Map get state => _state;
  Map _state;
}

class _$$BasicPartOfLibState$JsMap extends $BasicPartOfLibState
    with BasicPartOfLibStateMixin, $BasicPartOfLibStateMixin {
  _$$BasicPartOfLibState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

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
  _$$BasicPartOfLibProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$BasicPartOfLibProps$JsMap(backingMap);

  @override
  $BasicPartOfLibProps typedPropsFactory(Map backingMap) => $BasicPartOfLibProps(backingMap);

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
  _$$BasicPartOfLibState$JsMap typedStateFactoryJs(JsBackedMap backingMap) => _$$BasicPartOfLibState$JsMap(backingMap);

  @override
  $BasicPartOfLibState typedStateFactory(Map backingMap) => $BasicPartOfLibState(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicPartOfLibProps];
}

final $SubPartOfLibComponentFactory = registerComponent(() => _$SubPartOfLibComponent(),
    builderFactory: SubPartOfLib,
    componentClass: SubPartOfLibComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'SubPartOfLib');

mixin $SubPartOfLibPropsMixin implements SubPartOfLibPropsMixin {
  @override
  Map get props;

  @override
  String get subProp => props[_$key__subProp___$SubPartOfLibProps] ?? null;

  @override
  set subProp(String value) => props[_$key__subProp___$SubPartOfLibProps] = value;

  static const _$prop__subProp___$SubPartOfLibProps = PropDescriptor(_$key__subProp___$SubPartOfLibProps);
  static const _$key__subProp___$SubPartOfLibProps = 'SubPartOfLibProps.subProp';

  static const List<PropDescriptor> $props = [_$prop__subProp___$SubPartOfLibProps];
  static const List<String> $propKeys = [_$key__subProp___$SubPartOfLibProps];
}

const PropsMeta _$metaForSubPartOfLibProps = PropsMeta(
  fields: $SubPartOfLibPropsMixin.$props,
  keys: $SubPartOfLibPropsMixin.$propKeys,
);

$SubPartOfLibProps $SubPartOfLib([Map backingProps]) =>
    backingProps == null ? _$$SubPartOfLibProps$JsMap(JsBackedMap()) : $SubPartOfLibProps(backingProps);

class $SubPartOfLibProps extends SubPartOfLibProps with SubPartOfLibPropsMixin, $SubPartOfLibPropsMixin {
  $SubPartOfLibProps._();

  static const PropsMeta meta = _$metaForSubPartOfLibProps;

  factory $SubPartOfLibProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubPartOfLibProps$JsMap(backingMap);
    } else {
      return _$$SubPartOfLibProps$PlainMap(backingMap);
    }
  }

  @override
  Map get props;

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $SubPartOfLibComponentFactory;

  @override
  String get propKeyNamespace => 'SubPartOfLibProps.';
}

class _$$SubPartOfLibProps$JsMap extends $SubPartOfLibProps with SubPartOfLibPropsMixin, $SubPartOfLibPropsMixin {
  _$$SubPartOfLibProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

class _$$SubPartOfLibProps$PlainMap extends $SubPartOfLibProps with SubPartOfLibPropsMixin, $SubPartOfLibPropsMixin {
  _$$SubPartOfLibProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

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
  _$$SubPartOfLibProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$SubPartOfLibProps$JsMap(backingMap);

  @override
  $SubPartOfLibProps typedPropsFactory(Map backingMap) => $SubPartOfLibProps(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForSubPartOfLibProps];
}

mixin $SuperPartOfLibPropsMixin implements SuperPartOfLibPropsMixin {
  static const PropsMeta meta = _$metaForSuperPartOfLibProps;

  @override
  Map get props;

  @override
  String get superProp => props[_$key__superProp___$SuperPartOfLibProps] ?? null;

  @override
  set superProp(String value) => props[_$key__superProp___$SuperPartOfLibProps] = value;

  static const _$prop__superProp___$SuperPartOfLibProps = PropDescriptor(_$key__superProp___$SuperPartOfLibProps);
  static const _$key__superProp___$SuperPartOfLibProps = 'SuperPartOfLibProps.superProp';

  static const List<PropDescriptor> $props = [_$prop__superProp___$SuperPartOfLibProps];
  static const List<String> $propKeys = [_$key__superProp___$SuperPartOfLibProps];
}

const PropsMeta _$metaForSuperPartOfLibProps = PropsMeta(
  fields: $SuperPartOfLibPropsMixin.$props,
  keys: $SuperPartOfLibPropsMixin.$propKeys,
);
