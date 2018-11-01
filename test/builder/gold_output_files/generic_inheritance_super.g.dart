part of 'generic_inheritance_super.dart';

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSuperComponentFactory = registerComponent(() => new _$GenericSuperComponent(),
    builderFactory: GenericSuper,
    componentClass: GenericSuperComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'GenericSuper'
);

abstract class _$GenericSuperPropsAccessorsMixin implements _$GenericSuperProps {
  @override  Map get props;

  @override
  String get otherSuperProp => props[_$key__otherSuperProp___$GenericSuperProps];
  @override
  set otherSuperProp(String value) => props[_$key__otherSuperProp___$GenericSuperProps] = value;
  @override
  String get superProp => props[_$key__superProp___$GenericSuperProps];
  @override
  set superProp(String value) => props[_$key__superProp___$GenericSuperProps] = value;
  @override
  String get superProp1 => props[_$key__superProp1___$GenericSuperProps];
  @override
  set superProp1(String value) => props[_$key__superProp1___$GenericSuperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__otherSuperProp___$GenericSuperProps = const PropDescriptor(_$key__otherSuperProp___$GenericSuperProps);
  static const PropDescriptor _$prop__superProp___$GenericSuperProps = const PropDescriptor(_$key__superProp___$GenericSuperProps);
  static const PropDescriptor _$prop__superProp1___$GenericSuperProps = const PropDescriptor(_$key__superProp1___$GenericSuperProps);
  static const String _$key__otherSuperProp___$GenericSuperProps = 'GenericSuperProps.otherSuperProp';
  static const String _$key__superProp___$GenericSuperProps = 'GenericSuperProps.superProp';
  static const String _$key__superProp1___$GenericSuperProps = 'GenericSuperProps.superProp1';

  static const List<PropDescriptor> $props = const [_$prop__otherSuperProp___$GenericSuperProps, _$prop__superProp___$GenericSuperProps, _$prop__superProp1___$GenericSuperProps];
  static const List<String> $propKeys = const [_$key__otherSuperProp___$GenericSuperProps, _$key__superProp___$GenericSuperProps, _$key__superProp1___$GenericSuperProps];
}

const PropsMeta $metaForGenericSuperProps = const PropsMeta(
  fields: _$GenericSuperPropsAccessorsMixin.$props,
  keys: _$GenericSuperPropsAccessorsMixin.$propKeys,
);

_$$GenericSuperProps $GenericSuper([Map backingProps]) => new _$$GenericSuperProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$GenericSuperProps extends _$GenericSuperProps with _$GenericSuperPropsAccessorsMixin implements GenericSuperProps {
  _$$GenericSuperProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $GenericSuperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSuperProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

abstract class _$GenericSuperStateAccessorsMixin implements _$GenericSuperState {
  @override  Map get state;

  @override
  String get superState => state[_$key__superState___$GenericSuperState];
  @override
  set superState(String value) => state[_$key__superState___$GenericSuperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__superState___$GenericSuperState = const StateDescriptor(_$key__superState___$GenericSuperState);
  static const String _$key__superState___$GenericSuperState = 'GenericSuperState.superState';

  static const List<StateDescriptor> $state = const [_$prop__superState___$GenericSuperState];
  static const List<String> $stateKeys = const [_$key__superState___$GenericSuperState];
}

const StateMeta $metaForGenericSuperState = const StateMeta(
  fields: _$GenericSuperStateAccessorsMixin.$state,
  keys: _$GenericSuperStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$GenericSuperState extends _$GenericSuperState with _$GenericSuperStateAccessorsMixin implements GenericSuperState{
  _$$GenericSuperState(Map backingMap) : this._state = ({}) {
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
class _$GenericSuperComponent extends GenericSuperComponent {
  @override
  _$$GenericSuperProps typedPropsFactory(Map backingMap) => new _$$GenericSuperProps(backingMap);

  @override
  typedStateFactory(Map backingMap) => new _$$GenericSuperState(backingMap) as dynamic;
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSuperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForGenericSuperProps];
}
