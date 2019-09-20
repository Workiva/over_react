// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TwoLevelWrapper2ComponentFactory = registerComponent(
    () => new _$TwoLevelWrapper2Component(),
    builderFactory: TwoLevelWrapper2,
    componentClass: TwoLevelWrapper2Component,
    isWrapper: true,
    parentType: null,
    displayName: 'TwoLevelWrapper2');

abstract class _$TwoLevelWrapper2PropsAccessorsMixin
    implements _$TwoLevelWrapper2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTwoLevelWrapper2Props = const PropsMeta(
  fields: _$TwoLevelWrapper2PropsAccessorsMixin.$props,
  keys: _$TwoLevelWrapper2PropsAccessorsMixin.$propKeys,
);

class TwoLevelWrapper2Props extends _$TwoLevelWrapper2Props
    with _$TwoLevelWrapper2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTwoLevelWrapper2Props;
}

_$$TwoLevelWrapper2Props _$TwoLevelWrapper2([Map backingProps]) =>
    new _$$TwoLevelWrapper2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TwoLevelWrapper2Props extends _$TwoLevelWrapper2Props
    with _$TwoLevelWrapper2PropsAccessorsMixin
    implements TwoLevelWrapper2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapper2Props(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
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
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TwoLevelWrapper2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TwoLevelWrapper2Props.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TwoLevelWrapper2Component extends TwoLevelWrapper2Component {
  @override
  _$$TwoLevelWrapper2Props typedPropsFactory(Map backingMap) =>
      new _$$TwoLevelWrapper2Props(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TwoLevelWrapper2Props.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTwoLevelWrapper2Props
  ];
}
