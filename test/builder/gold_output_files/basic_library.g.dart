part of basic.library;

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicPartOfLibComponentFactory = registerComponent(() => new _$BasicPartOfLibComponent(),
    builderFactory: BasicPartOfLib,
    componentClass: BasicPartOfLibComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'BasicPartOfLib'
);

abstract class _$BasicPartOfLibPropsAccessorsMixin implements _$BasicPartOfLibProps {
  @override  Map get props;

  @override
  String get basicProp => props[_$key__basicProp___$BasicPartOfLibProps];
  @override
  set basicProp(String value) => props[_$key__basicProp___$BasicPartOfLibProps] = value;
  @override
  String get basic1 => props[_$key__basic1___$BasicPartOfLibProps];
  @override
  set basic1(String value) => props[_$key__basic1___$BasicPartOfLibProps] = value;
  @override
  String get basic2 => props[_$key__basic2___$BasicPartOfLibProps];
  @override
  set basic2(String value) => props[_$key__basic2___$BasicPartOfLibProps] = value;
  @override
  String get basic3 => props[_$key__basic3___$BasicPartOfLibProps];
  @override
  set basic3(String value) => props[_$key__basic3___$BasicPartOfLibProps] = value;
  @override
  String get basic4 => props[_$key__basic4___$BasicPartOfLibProps];
  @override
  set basic4(String value) => props[_$key__basic4___$BasicPartOfLibProps] = value;
  @override
  String get basic5 => props[_$key__basic5___$BasicPartOfLibProps];
  @override
  set basic5(String value) => props[_$key__basic5___$BasicPartOfLibProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp___$BasicPartOfLibProps = const PropDescriptor(_$key__basicProp___$BasicPartOfLibProps);
  static const PropDescriptor _$prop__basic1___$BasicPartOfLibProps = const PropDescriptor(_$key__basic1___$BasicPartOfLibProps);
  static const PropDescriptor _$prop__basic2___$BasicPartOfLibProps = const PropDescriptor(_$key__basic2___$BasicPartOfLibProps);
  static const PropDescriptor _$prop__basic3___$BasicPartOfLibProps = const PropDescriptor(_$key__basic3___$BasicPartOfLibProps);
  static const PropDescriptor _$prop__basic4___$BasicPartOfLibProps = const PropDescriptor(_$key__basic4___$BasicPartOfLibProps);
  static const PropDescriptor _$prop__basic5___$BasicPartOfLibProps = const PropDescriptor(_$key__basic5___$BasicPartOfLibProps);
  static const String _$key__basicProp___$BasicPartOfLibProps = 'BasicPartOfLibProps.basicProp';
  static const String _$key__basic1___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic1';
  static const String _$key__basic2___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic2';
  static const String _$key__basic3___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic3';
  static const String _$key__basic4___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic4';
  static const String _$key__basic5___$BasicPartOfLibProps = 'BasicPartOfLibProps.basic5';

  static const List<PropDescriptor> $props = const [_$prop__basicProp___$BasicPartOfLibProps, _$prop__basic1___$BasicPartOfLibProps, _$prop__basic2___$BasicPartOfLibProps, _$prop__basic3___$BasicPartOfLibProps, _$prop__basic4___$BasicPartOfLibProps, _$prop__basic5___$BasicPartOfLibProps];
  static const List<String> $propKeys = const [_$key__basicProp___$BasicPartOfLibProps, _$key__basic1___$BasicPartOfLibProps, _$key__basic2___$BasicPartOfLibProps, _$key__basic3___$BasicPartOfLibProps, _$key__basic4___$BasicPartOfLibProps, _$key__basic5___$BasicPartOfLibProps];
}

const PropsMeta $metaForBasicPartOfLibProps = const PropsMeta(
  fields: _$BasicPartOfLibPropsAccessorsMixin.$props,
  keys: _$BasicPartOfLibPropsAccessorsMixin.$propKeys,
);

_$$BasicPartOfLibProps $BasicPartOfLib([Map backingProps]) => new _$$BasicPartOfLibProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicPartOfLibProps extends _$BasicPartOfLibProps with _$BasicPartOfLibPropsAccessorsMixin implements BasicPartOfLibProps {
  _$$BasicPartOfLibProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $BasicPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicPartOfLibProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

abstract class _$BasicPartOfLibStateAccessorsMixin implements _$BasicPartOfLibState {
  @override  Map get state;

  @override
  String get basicState => state[_$key__basicState___$BasicPartOfLibState];
  @override
  set basicState(String value) => state[_$key__basicState___$BasicPartOfLibState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState___$BasicPartOfLibState = const StateDescriptor(_$key__basicState___$BasicPartOfLibState);
  static const String _$key__basicState___$BasicPartOfLibState = 'BasicPartOfLibState.basicState';

  static const List<StateDescriptor> $state = const [_$prop__basicState___$BasicPartOfLibState];
  static const List<String> $stateKeys = const [_$key__basicState___$BasicPartOfLibState];
}

const StateMeta $metaForBasicPartOfLibState = const StateMeta(
  fields: _$BasicPartOfLibStateAccessorsMixin.$state,
  keys: _$BasicPartOfLibStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$BasicPartOfLibState extends _$BasicPartOfLibState with _$BasicPartOfLibStateAccessorsMixin implements BasicPartOfLibState{
  _$$BasicPartOfLibState(Map backingMap) : this._state = ({}) {
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
class _$BasicPartOfLibComponent extends BasicPartOfLibComponent {
  @override
  _$$BasicPartOfLibProps typedPropsFactory(Map backingMap) => new _$$BasicPartOfLibProps(backingMap);

  @override
  typedStateFactory(Map backingMap) => new _$$BasicPartOfLibState(backingMap) as dynamic;
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicPartOfLibProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForBasicPartOfLibProps];
}
// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SubPartOfLibComponentFactory = registerComponent(() => new _$SubPartOfLibComponent(),
    builderFactory: SubPartOfLib,
    componentClass: SubPartOfLibComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'SubPartOfLib'
);

abstract class _$SubPartOfLibPropsAccessorsMixin implements _$SubPartOfLibProps {
  @override  Map get props;

  @override
  String get subProp => props[_$key__subProp___$SubPartOfLibProps];
  @override
  set subProp(String value) => props[_$key__subProp___$SubPartOfLibProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp___$SubPartOfLibProps = const PropDescriptor(_$key__subProp___$SubPartOfLibProps);
  static const String _$key__subProp___$SubPartOfLibProps = 'SubPartOfLibProps.subProp';

  static const List<PropDescriptor> $props = const [_$prop__subProp___$SubPartOfLibProps];
  static const List<String> $propKeys = const [_$key__subProp___$SubPartOfLibProps];
}

const PropsMeta $metaForSubPartOfLibProps = const PropsMeta(
  fields: _$SubPartOfLibPropsAccessorsMixin.$props,
  keys: _$SubPartOfLibPropsAccessorsMixin.$propKeys,
);

_$$SubPartOfLibProps $SubPartOfLib([Map backingProps]) => new _$$SubPartOfLibProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$SubPartOfLibProps extends _$SubPartOfLibProps with _$SubPartOfLibPropsAccessorsMixin implements SubPartOfLibProps {
  _$$SubPartOfLibProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $SubPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SubPartOfLibProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$SubPartOfLibComponent extends SubPartOfLibComponent {
  @override
  _$$SubPartOfLibProps typedPropsFactory(Map backingMap) => new _$$SubPartOfLibProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SubPartOfLibProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForSubPartOfLibProps];
}
abstract class _$SuperPartOfLibPropsAccessorsMixin implements _$SuperPartOfLibProps {
  @override  Map get props;

  @override
  String get superProp => props[_$key__superProp___$SuperPartOfLibProps];
  @override
  set superProp(String value) => props[_$key__superProp___$SuperPartOfLibProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__superProp___$SuperPartOfLibProps = const PropDescriptor(_$key__superProp___$SuperPartOfLibProps);
  static const String _$key__superProp___$SuperPartOfLibProps = 'SuperPartOfLibProps.superProp';

  static const List<PropDescriptor> $props = const [_$prop__superProp___$SuperPartOfLibProps];
  static const List<String> $propKeys = const [_$key__superProp___$SuperPartOfLibProps];
}

const PropsMeta $metaForSuperPartOfLibProps = const PropsMeta(
  fields: _$SuperPartOfLibPropsAccessorsMixin.$props,
  keys: _$SuperPartOfLibPropsAccessorsMixin.$propKeys,
);

