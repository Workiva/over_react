// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'one_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $OneLevelWrapperComponentFactory = registerComponent(
  () => _$OneLevelWrapperComponent(),
  builderFactory: _$OneLevelWrapper,
  componentClass: OneLevelWrapperComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'OneLevelWrapper',
);

abstract class _$OneLevelWrapperPropsAccessorsMixin
    implements _$OneLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForOneLevelWrapperProps = PropsMeta(
  fields: _$OneLevelWrapperPropsAccessorsMixin.$props,
  keys: _$OneLevelWrapperPropsAccessorsMixin.$propKeys,
);

class OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForOneLevelWrapperProps;
}

_$$OneLevelWrapperProps _$OneLevelWrapper([Map backingProps]) =>
    _$$OneLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin
    implements OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapperProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $OneLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'OneLevelWrapperProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$OneLevelWrapperComponent extends OneLevelWrapperComponent {
  @override
  _$$OneLevelWrapperProps typedPropsFactory(Map backingMap) =>
      _$$OneLevelWrapperProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$OneLevelWrapperProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForOneLevelWrapperProps
  ];
}
