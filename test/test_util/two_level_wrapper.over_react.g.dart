// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
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

class TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTwoLevelWrapperProps;
}

_$$TwoLevelWrapperProps _$TwoLevelWrapper([Map backingProps]) =>
    new _$$TwoLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin
    implements TwoLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TwoLevelWrapperProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  ReactComponentFactoryProxy _factoryOverride;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      _factoryOverride ?? $TwoLevelWrapperComponentFactory;
  @override
  set componentFactory(ReactComponentFactoryProxy v) => _factoryOverride = v;

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
  _$$TwoLevelWrapperProps typedPropsFactory(Map backingMap) =>
      new _$$TwoLevelWrapperProps(backingMap);

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
