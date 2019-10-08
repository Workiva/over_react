// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flawed_component_that_renders_a_string.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedWithStringChildComponentFactory = registerComponent(
    () => new _$FlawedWithStringChildComponent(),
    builderFactory: FlawedWithStringChild,
    componentClass: FlawedWithStringChildComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'FlawedWithStringChild');

abstract class _$FlawedWithStringChildPropsAccessorsMixin
    implements _$FlawedWithStringChildProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForFlawedWithStringChildProps = const PropsMeta(
  fields: _$FlawedWithStringChildPropsAccessorsMixin.$props,
  keys: _$FlawedWithStringChildPropsAccessorsMixin.$propKeys,
);

_$$FlawedWithStringChildProps _$FlawedWithStringChild([Map backingProps]) =>
    new _$$FlawedWithStringChildProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedWithStringChildProps extends _$FlawedWithStringChildProps
    with _$FlawedWithStringChildPropsAccessorsMixin
    implements FlawedWithStringChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$FlawedWithStringChildProps(Map backingMap) : this._props = {} {
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
      $FlawedWithStringChildComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedWithStringChildProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FlawedWithStringChildComponent extends FlawedWithStringChildComponent {
  @override
  _$$FlawedWithStringChildProps typedPropsFactory(Map backingMap) =>
      new _$$FlawedWithStringChildProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FlawedWithStringChildProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedWithStringChildProps
  ];
}
