// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:over_react/over_react.dart';

import 'abstract_inheritance.dart';

final $SubComponentFactory = registerComponent2(
  () => _$SubComponent(),
  builderFactory: Sub,
  componentClass: SubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Sub',
);

mixin $SubPropsMixin implements SubPropsMixin {
  @override
  Map get props;

  @override String get subProp => props[_$key__subProp___$SubProps] ?? null;
  @override set subProp(String value) => props[_$key__subProp___$SubProps] = value;

  static const _$prop__subProp___$SubProps = PropDescriptor(_$key__subProp___$SubProps);
  static const _$key__subProp___$SubProps = 'SubProps.subProp';

  static const List<PropDescriptor> $props = [_$prop__subProp___$SubProps];
  static const List<String> $propKeys = [_$key__subProp___$SubProps];
}

const PropsMeta _$metaForSubProps = PropsMeta(
  fields: $SubPropsMixin.$props,
  keys: $SubPropsMixin.$propKeys,
);

$SubProps $Sub([Map backingProps]) => backingProps == null ? _$$SubProps$JsMap(JsBackedMap()) : $SubProps(backingProps);

class $SubProps extends SubProps with $SuperPropsMixin, $SubPropsMixin {
  $SubProps._();

  static const PropsMeta meta = _$metaForSubProps;

  factory $SubProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubProps$JsMap(backingMap);
    } else {
      return _$$SubProps$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $SubComponentFactory;

  @override
  String get propKeyNamespace => 'SubProps.';
}

class _$$SubProps$PlainMap extends $SubProps {
  _$$SubProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$SubProps$JsMap extends $SubProps {
  _$$SubProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $SubStateMixin implements SubStateMixin {
  @override
  Map get state;

  @override String get subState => state[_$key__subState___$SubState] ?? null;
  @override set subState(String value) => state[_$key__subState___$SubState] = value;

  static const _$prop__subState___$SubState = StateDescriptor(_$key__subState___$SubState);
  static const _$key__subState___$SubState = 'SubState.subState';

  static const List<StateDescriptor> $state = [_$prop__subState___$SubState];
  static const List<String> $stateKeys = [_$key__subState___$SubState];
}

const StateMeta _$metaForSubState = StateMeta(
  fields: $SubStateMixin.$state,
  keys: $SubStateMixin.$stateKeys,
);

abstract class $SubState extends SubState with $SuperStateMixin, $SubStateMixin {
  $SubState._();

  static const StateMeta meta = _$metaForSubState;

  factory $SubState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubState$JsMap(backingMap);
    } else {
      return _$$SubState$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;
}

class _$$SubState$PlainMap extends $SubState with SubStateMixin, $SubStateMixin {
  _$$SubState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  @override
  Map get state => _state;
  Map _state;
}

class _$$SubState$JsMap extends $SubState with SubStateMixin, $SubStateMixin {
  _$$SubState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

class _$SubComponent extends SubComponent {
  _$$SubProps$JsMap _cachedTypedProps;

  @override
  _$$SubProps$JsMap get props => _cachedTypedProps;

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
  _$$SubProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$SubProps$JsMap(backingMap);

  @override
  $SubProps typedPropsFactory(Map backingMap) => $SubProps(backingMap);

  _$$SubState$JsMap _cachedTypedState;
  @override
  _$$SubState$JsMap get state => _cachedTypedState;

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
  _$$SubState$JsMap typedStateFactoryJs(JsBackedMap backingMap) => _$$SubState$JsMap(backingMap);

  @override
  $SubState typedStateFactory(Map backingMap) => $SubState(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForSubProps];
}

mixin $SuperPropsMixin implements SuperPropsMixin {
  @override
  Map get props;

  @override String get superProp => props[_$key__superProp___$SuperProps] ?? null;
  @override set superProp(String value) => props[_$key__superProp___$SuperProps] = value;

  static const _$prop__superProp___$SuperProps = PropDescriptor(_$key__superProp___$SuperProps);
  static const _$key__superProp___$SuperProps = 'SuperProps.superProp';

  static const List<PropDescriptor> $props = [_$prop__superProp___$SuperProps];
  static const List<String> $propKeys = [_$key__superProp___$SuperProps];
}

const PropsMeta _$metaForSuperProps = PropsMeta(
  fields: $SuperPropsMixin.$props,
  keys: $SuperPropsMixin.$propKeys,
);

class $SuperProps extends UiProps with SuperPropsMixin, $SuperPropsMixin {
  static const PropsMeta meta = _$metaForSuperProps;
}

mixin $SuperStateMixin implements SuperStateMixin {
  static const StateMeta meta = _$metaForSuperState;

  @override
  Map get state;

  @override String get superState => state[_$key__superState___$SuperState] ?? null;
  @override set superState(String value) => state[_$key__superState___$SuperState] = value;

  static const _$prop__superState___$SuperState = StateDescriptor(_$key__superState___$SuperState);
  static const _$key__superState___$SuperState = 'SuperState.superState';

  static const List<StateDescriptor> $state = [_$prop__superState___$SuperState];
  static const List<String> $stateKeys = [_$key__superState___$SuperState];
}

const StateMeta _$metaForSuperState = StateMeta(
  fields: $SuperStateMixin.$state,
  keys: $SuperStateMixin.$stateKeys,
);
