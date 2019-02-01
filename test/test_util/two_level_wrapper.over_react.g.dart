// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_util.two_level_wrapper;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TwoLevelWrapperComponentFactory = registerComponent(
    () => new _$TwoLevelWrapperComponent(),
    builderFactory: TwoLevelWrapper,
    componentClass: TwoLevelWrapperComponent,
    isWrapper: true,
    parentType: null,
    displayName: 'TwoLevelWrapper');

abstract class _$TwoLevelWrapperPropsAccessorsMixin
    implements _$TwoLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTwoLevelWrapperProps = const PropsMeta(
  fields: _$TwoLevelWrapperPropsAccessorsMixin.$props,
  keys: _$TwoLevelWrapperPropsAccessorsMixin.$propKeys,
);

_$$TwoLevelWrapperProps _$TwoLevelWrapper([Map backingProps]) =>
    new _$$TwoLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin
    implements TwoLevelWrapperProps {
  _$$TwoLevelWrapperProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TwoLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TwoLevelWrapperProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TwoLevelWrapperComponent extends TwoLevelWrapperComponent {
  @override
  typedPropsFactory(Map backingMap) => new _$$TwoLevelWrapperProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TwoLevelWrapperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTwoLevelWrapperProps
  ];
}
