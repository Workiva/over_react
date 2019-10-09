// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flawed_component_that_renders_nothing.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedWithNoChildComponentFactory = registerComponent(
    () => new _$FlawedWithNoChildComponent(),
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

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForFlawedWithNoChildProps = const PropsMeta(
  fields: _$FlawedWithNoChildPropsAccessorsMixin.$props,
  keys: _$FlawedWithNoChildPropsAccessorsMixin.$propKeys,
);

_$$FlawedWithNoChildProps _$FlawedWithNoChild([Map backingProps]) =>
    new _$$FlawedWithNoChildProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedWithNoChildProps extends _$FlawedWithNoChildProps
    with _$FlawedWithNoChildPropsAccessorsMixin
    implements FlawedWithNoChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedWithNoChildProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $FlawedWithNoChildComponentFactory;

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
      new _$$FlawedWithNoChildProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FlawedWithNoChildProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedWithNoChildProps
  ];
}
