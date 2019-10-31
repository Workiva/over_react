// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'flawed_component_that_renders_nothing.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedWithNoChildComponentFactory = registerComponent(
    () => _$FlawedWithNoChildComponent(),
    builderFactory: FlawedWithNoChild,
    componentClass: FlawedWithNoChildComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'FlawedWithNoChild');

abstract class _$FlawedWithNoChildPropsAccessorsMixin
    implements _$FlawedWithNoChildProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForFlawedWithNoChildProps = PropsMeta(
  fields: _$FlawedWithNoChildPropsAccessorsMixin.$props,
  keys: _$FlawedWithNoChildPropsAccessorsMixin.$propKeys,
);

_$$FlawedWithNoChildProps _$FlawedWithNoChild([Map backingProps]) =>
    _$$FlawedWithNoChildProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedWithNoChildProps extends _$FlawedWithNoChildProps
    with _$FlawedWithNoChildPropsAccessorsMixin
    implements FlawedWithNoChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$FlawedWithNoChildProps(Map backingMap) : this._props = {} {
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
      $FlawedWithNoChildComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedWithNoChildProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FlawedWithNoChildComponent extends FlawedWithNoChildComponent {
  @override
  _$$FlawedWithNoChildProps typedPropsFactory(Map backingMap) =>
      _$$FlawedWithNoChildProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FlawedWithNoChildProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedWithNoChildProps
  ];
}
