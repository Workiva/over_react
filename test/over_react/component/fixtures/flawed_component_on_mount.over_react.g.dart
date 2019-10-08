// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flawed_component_on_mount.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedOnMountComponentFactory = registerComponent(
    () => new _$FlawedOnMountComponent(),
    builderFactory: FlawedOnMount,
    componentClass: FlawedOnMountComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'FlawedOnMount');

abstract class _$FlawedOnMountPropsAccessorsMixin
    implements _$FlawedOnMountProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForFlawedOnMountProps = const PropsMeta(
  fields: _$FlawedOnMountPropsAccessorsMixin.$props,
  keys: _$FlawedOnMountPropsAccessorsMixin.$propKeys,
);

_$$FlawedOnMountProps _$FlawedOnMount([Map backingProps]) =>
    new _$$FlawedOnMountProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedOnMountProps extends _$FlawedOnMountProps
    with _$FlawedOnMountPropsAccessorsMixin
    implements FlawedOnMountProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedOnMountProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $FlawedOnMountComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedOnMountProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FlawedOnMountComponent extends FlawedOnMountComponent {
  @override
  _$$FlawedOnMountProps typedPropsFactory(Map backingMap) =>
      new _$$FlawedOnMountProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FlawedOnMountProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedOnMountProps
  ];
}
