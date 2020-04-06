// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'non_component_two_counter.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $NonComponentTwoCounterComponentFactory = registerComponent(
  () => _$NonComponentTwoCounterComponent(),
  builderFactory: _$NonComponentTwoCounter,
  componentClass: NonComponentTwoCounterComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'NonComponentTwoCounter',
);

abstract class _$NonComponentTwoCounterPropsAccessorsMixin
    implements _$NonComponentTwoCounterProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForNonComponentTwoCounterProps = PropsMeta(
  fields: _$NonComponentTwoCounterPropsAccessorsMixin.$props,
  keys: _$NonComponentTwoCounterPropsAccessorsMixin.$propKeys,
);

class NonComponentTwoCounterProps extends _$NonComponentTwoCounterProps
    with _$NonComponentTwoCounterPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForNonComponentTwoCounterProps;
}

_$$NonComponentTwoCounterProps _$NonComponentTwoCounter([Map backingProps]) =>
    _$$NonComponentTwoCounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$NonComponentTwoCounterProps extends _$NonComponentTwoCounterProps
    with _$NonComponentTwoCounterPropsAccessorsMixin
    implements NonComponentTwoCounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NonComponentTwoCounterProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $NonComponentTwoCounterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'NonComponentTwoCounterProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$NonComponentTwoCounterComponent
    extends NonComponentTwoCounterComponent {
  @override
  _$$NonComponentTwoCounterProps typedPropsFactory(Map backingMap) =>
      _$$NonComponentTwoCounterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$NonComponentTwoCounterProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForNonComponentTwoCounterProps
  ];
}
