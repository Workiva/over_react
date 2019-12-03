import 'package:over_react/over_react.dart';

import 'generic_inheritance_super.dart';

final $GenericSuperComponentFactory = registerComponent2(
  () => _$GenericSuperComponent(),
  builderFactory: GenericSuper,
  componentClass: GenericSuperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSuper',
);

mixin $GenericSuperPropsMixin implements GenericSuperProps {
  @override
  Map get props;

  @override String get otherSuperProp => props[_$key__otherSuperProp___$GenericSuperProps] ?? null;
  @override set otherSuperProp(String value) => props[_$key__otherSuperProp___$GenericSuperProps] = value;

  @override String get superProp => props[_$key__superProp___$GenericSuperProps] ?? null;
  @override set superProp(String value) => props[_$key__superProp___$GenericSuperProps] = value;

  @override String get superProp1 => props[_$key__superProp1___$GenericSuperProps] ?? null;
  @override set superProp1(String value) => props[_$key__superProp1___$GenericSuperProps] = value;

  static const _$prop__otherSuperProp___$GenericSuperProps = PropDescriptor(_$key__otherSuperProp___$GenericSuperProps);
  static const _$prop__superProp___$GenericSuperProps = PropDescriptor(_$key__superProp___$GenericSuperProps);
  static const _$prop__superProp1___$GenericSuperProps = PropDescriptor(_$key__superProp1___$GenericSuperProps);
  static const _$key__otherSuperProp___$GenericSuperProps = 'GenericSuperProps.otherSuperProp';
  static const _$key__superProp___$GenericSuperProps = 'GenericSuperProps.superProp';
  static const _$key__superProp1___$GenericSuperProps = 'GenericSuperProps.superProp1';

  static const List<PropDescriptor> $props = [
    _$prop__otherSuperProp___$GenericSuperProps,
    _$prop__superProp___$GenericSuperProps,
    _$prop__superProp1___$GenericSuperProps
  ];
  static const List<String> $propKeys = [
    _$key__otherSuperProp___$GenericSuperProps,
    _$key__superProp___$GenericSuperProps,
    _$key__superProp1___$GenericSuperProps
  ];
}

const PropsMeta _$metaForGenericSuperProps = PropsMeta(
  fields: $GenericSuperPropsMixin.$props,
  keys: $GenericSuperPropsMixin.$propKeys,
);

$GenericSuperProps $GenericSuper([Map backingProps]) =>
    backingProps == null ? _$$GenericSuperProps$JsMap(JsBackedMap()) : $GenericSuperProps(backingProps);

abstract class $GenericSuperProps extends GenericSuperProps with GenericSuperPropsMixin, $GenericSuperPropsMixin {
  $GenericSuperProps._();

  static const PropsMeta meta = _$metaForGenericSuperProps;

  factory $GenericSuperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSuperProps$JsMap(backingMap);
    } else {
      return _$$GenericSuperProps$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $GenericSuperComponentFactory;

  @override
  String get propKeyNamespace => 'GenericSuperProps.';
}

class _$$GenericSuperProps$PlainMap extends $GenericSuperProps {
  _$$GenericSuperProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$GenericSuperProps$JsMap extends $GenericSuperProps {
  _$$GenericSuperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $GenericSuperStateMixin implements GenericSuperStateMixin {
  @override
  Map get state;

  @override String get superState => state[_$key__superState___$GenericSuperState] ?? null;
  @override set superState(String value) => state[_$key__superState___$GenericSuperState] = value;

  static const _$prop__superState___$GenericSuperState = StateDescriptor(_$key__superState___$GenericSuperState);
  static const _$key__superState___$GenericSuperState = 'GenericSuperState.superState';

  static const List<StateDescriptor> $state = [_$prop__superState___$GenericSuperState];
  static const List<String> $stateKeys = [_$key__superState___$GenericSuperState];
}

const StateMeta _$metaForGenericSuperState = StateMeta(
  fields: $GenericSuperStateMixin.$state,
  keys: $GenericSuperStateMixin.$stateKeys,
);

class $GenericSuperState extends UiState with GenericSuperStateMixin, $GenericSuperStateMixin {
  $GenericSuperState._();

  static const StateMeta meta = _$metaForGenericSuperState;

  factory $GenericSuperState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSuperState$JsMap(backingMap);
    } else {
      return _$$GenericSuperState$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;
}

class _$$GenericSuperState$PlainMap extends $GenericSuperState {
  _$$GenericSuperState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  @override
  Map get state => _state;
  Map _state;
}

class _$$GenericSuperState$JsMap extends $GenericSuperState {
  _$$GenericSuperState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

class _$GenericSuperComponent extends GenericSuperComponent {
  _$$GenericSuperProps$JsMap _cachedTypedProps;

  @override
  _$$GenericSuperProps$JsMap get props => _cachedTypedProps;

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
  _$$GenericSuperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$GenericSuperProps$JsMap(backingMap);

  @override
  $GenericSuperProps typedPropsFactory(Map backingMap) => $GenericSuperProps(backingMap);

  _$$GenericSuperState$JsMap _cachedTypedState;
  @override
  _$$GenericSuperState$JsMap get state => _cachedTypedState;

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
  _$$GenericSuperState$JsMap typedStateFactoryJs(JsBackedMap backingMap) => _$$GenericSuperState$JsMap(backingMap);

  @override
  $GenericSuperState typedStateFactory(Map backingMap) => $GenericSuperState(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForGenericSuperProps];
}
