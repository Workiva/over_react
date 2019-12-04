// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:over_react/over_react.dart';

import 'generic_inheritance_sub.dart';
import 'generic_inheritance_super.dart';

final $GenericSubComponentFactory = registerComponent2(
  () => _$GenericSubComponent(),
  builderFactory: GenericSub,
  componentClass: GenericSubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSub',
);

mixin $GenericSubPropsMixin implements GenericSubPropsMixin {
  @override
  Map get props;

  @override String get subProp => props[_$key__subProp___$GenericSubProps] ?? null;
  @override set subProp(String value) => props[_$key__subProp___$GenericSubProps] = value;

  static const _$prop__subProp___$GenericSubProps = PropDescriptor(_$key__subProp___$GenericSubProps);
  static const _$key__subProp___$GenericSubProps = 'GenericSubProps.subProp';

  static const List<PropDescriptor> $props = [_$prop__subProp___$GenericSubProps];
  static const List<String> $propKeys = [_$key__subProp___$GenericSubProps];
}

const PropsMeta _$metaForGenericSubProps = PropsMeta(
  fields: $GenericSubPropsMixin.$props,
  keys: $GenericSubPropsMixin.$propKeys,
);

$GenericSubProps $GenericSub([Map backingProps]) =>
    backingProps == null ? _$$GenericSubProps$JsMap(JsBackedMap()) : $GenericSubProps(backingProps);

class $GenericSubProps extends GenericSubProps with $GenericSuperPropsMixin, $GenericSubPropsMixin {
  $GenericSubProps._();

  static const PropsMeta meta = _$metaForGenericSubProps;

  factory $GenericSubProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSubProps$JsMap(backingMap);
    } else {
      return _$$GenericSubProps$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;

  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $GenericSubComponentFactory;

  @override
  String get propKeyNamespace => 'GenericSubProps.';
}

class _$$GenericSubProps$PlainMap extends $GenericSubProps {
  _$$GenericSubProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}

class _$$GenericSubProps$JsMap extends $GenericSubProps {
  _$$GenericSubProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $GenericSubStateMixin implements GenericSubState {
  @override
  Map get state;

  @override String get subState => state[_$key__subState___$GenericSubState] ?? null;
  @override set subState(String value) => state[_$key__subState___$GenericSubState] = value;

  static const _$prop__subState___$GenericSubState = StateDescriptor(_$key__subState___$GenericSubState);
  static const _$key__subState___$GenericSubState = 'GenericSubState.subState';

  static const List<StateDescriptor> $state = [_$prop__subState___$GenericSubState];
  static const List<String> $stateKeys = [_$key__subState___$GenericSubState];
}

const StateMeta _$metaForGenericSubState = StateMeta(
  fields: $GenericSubStateMixin.$state,
  keys: $GenericSubStateMixin.$stateKeys,
);

class $GenericSubState extends GenericSubState with $GenericSuperStateMixin, $GenericSubStateMixin {
  $GenericSubState._();

  static const StateMeta meta = _$metaForGenericSubState;

  factory $GenericSubState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSubState$JsMap(backingMap);
    } else {
      return _$$GenericSubState$PlainMap(backingMap);
    }
  }

  @override
  bool get $isClassGenerated => true;
}

class _$$GenericSubState$PlainMap extends $GenericSubState {
  _$$GenericSubState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  @override
  Map get state => _state;
  Map _state;
}

class _$$GenericSubState$JsMap extends $GenericSubState {
  _$$GenericSubState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

class _$GenericSubComponent extends GenericSubComponent {
  _$$GenericSubProps$JsMap _cachedTypedProps;

  @override
  _$$GenericSubProps$JsMap get props => _cachedTypedProps;

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
  _$$GenericSubProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) => _$$GenericSubProps$JsMap(backingMap);

  @override
  $GenericSubProps typedPropsFactory(Map backingMap) => $GenericSubProps(backingMap);

  _$$GenericSubState$JsMap _cachedTypedState;
  @override
  _$$GenericSubState$JsMap get state => _cachedTypedState;

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
  _$$GenericSubState$JsMap typedStateFactoryJs(JsBackedMap backingMap) => _$$GenericSubState$JsMap(backingMap);

  @override
  $GenericSubState typedStateFactory(Map backingMap) => $GenericSubState(backingMap);

  @override
  bool get $isClassGenerated => true;

  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForGenericSubProps];
}
