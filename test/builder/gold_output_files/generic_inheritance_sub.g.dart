part of 'generic_inheritance_sub.dart';

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSubComponentFactory = registerComponent(() => new _$GenericSubComponent(),
    builderFactory: GenericSub,
    componentClass: GenericSubComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'GenericSub'
);

abstract class _$GenericSubPropsAccessorsMixin implements _$GenericSubProps {
  @override  Map get props;

  @override
  String get subProp => props[_$key__subProp___$GenericSubProps];
  @override
  set subProp(String value) => props[_$key__subProp___$GenericSubProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp___$GenericSubProps = const PropDescriptor(_$key__subProp___$GenericSubProps);
  static const String _$key__subProp___$GenericSubProps = 'GenericSubProps.subProp';

  static const List<PropDescriptor> $props = const [_$prop__subProp___$GenericSubProps];
  static const List<String> $propKeys = const [_$key__subProp___$GenericSubProps];
}

const PropsMeta $metaForGenericSubProps = const PropsMeta(
  fields: _$GenericSubPropsAccessorsMixin.$props,
  keys: _$GenericSubPropsAccessorsMixin.$propKeys,
);

_$$GenericSubProps $GenericSub([Map backingProps]) => new _$$GenericSubProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$GenericSubProps extends _$GenericSubProps with _$GenericSubPropsAccessorsMixin implements GenericSubProps {
  _$$GenericSubProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? ({});
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $GenericSubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSubProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

abstract class _$GenericSubStateAccessorsMixin implements _$GenericSubState {
  @override  Map get state;

  @override
  String get subState => state[_$key__subState___$GenericSubState];
  @override
  set subState(String value) => state[_$key__subState___$GenericSubState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__subState___$GenericSubState = const StateDescriptor(_$key__subState___$GenericSubState);
  static const String _$key__subState___$GenericSubState = 'GenericSubState.subState';

  static const List<StateDescriptor> $state = const [_$prop__subState___$GenericSubState];
  static const List<String> $stateKeys = const [_$key__subState___$GenericSubState];
}

const StateMeta $metaForGenericSubState = const StateMeta(
  fields: _$GenericSubStateAccessorsMixin.$state,
  keys: _$GenericSubStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$GenericSubState extends _$GenericSubState with _$GenericSubStateAccessorsMixin implements GenericSubState{
  _$$GenericSubState(Map backingMap) : this._state = ({}) {
    this._state = backingMap ?? ({});
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;


  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$GenericSubComponent extends GenericSubComponent {
  @override
  _$$GenericSubProps typedPropsFactory(Map backingMap) => new _$$GenericSubProps(backingMap);

  @override
  typedStateFactory(Map backingMap) => new _$$GenericSubState(backingMap) as dynamic;
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForGenericSubProps];
}
