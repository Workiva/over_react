import 'package:over_react/over_react.dart';

import 'basic_with_state.dart';

final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

mixin $BasicPropsMixin implements BasicPropsMixin {
  @override
  Map get props;

  @override String get basicProp => props[_$key__basicProp___$BasicProps] ?? null;
  @override set basicProp(String value) => props[_$key__basicProp___$BasicProps] = value;

  @override String get basic1 => props[_$key__basic1___$BasicProps] ?? null;
  @override set basic1(String value) => props[_$key__basic1___$BasicProps] = value;

  @override String get basic2 => props[_$key__basic2___$BasicProps] ?? null;
  @override set basic2(String value) => props[_$key__basic2___$BasicProps] = value;

  @override String get basic3 => props[_$key__basic3___$BasicProps] ?? null;
  @override set basic3(String value) => props[_$key__basic3___$BasicProps] = value;

  @override String get basic4 => props[_$key__basic4___$BasicProps] ?? null;
  @override set basic4(String value) => props[_$key__basic4___$BasicProps] = value;

  @override String get basic5 => props[_$key__basic5___$BasicProps] ?? null;
  @override set basic5(String value) => props[_$key__basic5___$BasicProps] = value;

  static const _$prop__basicProp___$BasicProps = PropDescriptor(_$key__basicProp___$BasicProps);
  static const _$prop__basic1___$BasicProps = PropDescriptor(_$key__basic1___$BasicProps);
  static const _$prop__basic2___$BasicProps = PropDescriptor(_$key__basic2___$BasicProps);
  static const _$prop__basic3___$BasicProps = PropDescriptor(_$key__basic3___$BasicProps);
  static const _$prop__basic4___$BasicProps = PropDescriptor(_$key__basic4___$BasicProps);
  static const _$prop__basic5___$BasicProps = PropDescriptor(_$key__basic5___$BasicProps);
  static const _$key__basicProp___$BasicProps = 'BasicProps.basicProp';
  static const _$key__basic1___$BasicProps = 'BasicProps.basic1';
  static const _$key__basic2___$BasicProps = 'BasicProps.basic2';
  static const _$key__basic3___$BasicProps = 'BasicProps.basic3';
  static const _$key__basic4___$BasicProps = 'BasicProps.basic4';
  static const _$key__basic5___$BasicProps = 'BasicProps.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp___$BasicProps,
    _$prop__basic1___$BasicProps,
    _$prop__basic2___$BasicProps,
    _$prop__basic3___$BasicProps,
    _$prop__basic4___$BasicProps,
    _$prop__basic5___$BasicProps
  ];
  static const List<String> $propKeys = [
    _$key__basicProp___$BasicProps,
    _$key__basic1___$BasicProps,
    _$key__basic2___$BasicProps,
    _$key__basic3___$BasicProps,
    _$key__basic4___$BasicProps,
    _$key__basic5___$BasicProps
  ];
}

const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: $BasicPropsMixin.$props,
  keys: $BasicPropsMixin.$propKeys,
);

$BasicProps $Basic([Map backingProps]) =>
    backingProps == null ? _$$BasicProps$JsMap(JsBackedMap()) : $BasicProps(backingProps);

class $BasicProps extends BasicProps with BasicPropsMixin, $BasicPropsMixin {
  $BasicProps._();

  static const PropsMeta meta = _$metaForBasicProps;

  factory $BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  @override
  Map get props;

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $BasicComponentFactory;

  @override
  String get propKeyNamespace => 'BasicProps.';
}

class _$$BasicProps$PlainMap extends $BasicProps {
  _$$BasicProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$BasicProps$JsMap extends $BasicProps {
  _$$BasicProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $BasicStateMixin implements BasicStateMixin {
  @override
  Map get state;

  @override String get basicState => state[_$key__basicState___$BasicState] ?? null;
  @override set basicState(String value) => state[_$key__basicState___$BasicState] = value;

  static const _$prop__basicState___$BasicState = StateDescriptor(_$key__basicState___$BasicState);
  static const _$key__basicState___$BasicState = 'BasicState.basicState';

  static const List<StateDescriptor> $state = [_$prop__basicState___$BasicState];
  static const List<String> $stateKeys = [_$key__basicState___$BasicState];
}

const StateMeta _$metaForBasicState = StateMeta(
  fields: $BasicStateMixin.$state,
  keys: $BasicStateMixin.$stateKeys,
);

class $BasicState extends BasicState with BasicStateMixin, $BasicStateMixin {
  $BasicState._();

  factory $BasicState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicState$JsMap(backingMap);
    } else {
      return _$$BasicState$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;
}

class _$$BasicState$PlainMap extends $BasicState {
  _$$BasicState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  @override
  Map get state => _state;
  Map _state;
}

class _$$BasicState$JsMap extends $BasicState {
  _$$BasicState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$BasicProps$JsMap(backingMap);

  @override
  $BasicProps typedPropsFactory(Map backingMap) => $BasicProps(backingMap);

  _$$BasicState$JsMap _cachedTypedState;
  @override
  _$$BasicState$JsMap get state => _cachedTypedState;

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
  _$$BasicState$JsMap typedStateFactoryJs(JsBackedMap backingMap) => _$$BasicState$JsMap(backingMap);

  @override
  $BasicState typedStateFactory(Map backingMap) => $BasicState(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
