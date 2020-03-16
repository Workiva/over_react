// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_ui_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicUiComponentComponentFactory = registerComponent(
    () => _$BasicUiComponentComponent(),
    builderFactory: BasicUiComponent,
    componentClass: BasicUiComponentComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'BasicUiComponent');

abstract class _$BasicUiComponentPropsAccessorsMixin
    implements _$BasicUiComponentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForBasicUiComponentProps = PropsMeta(
  fields: _$BasicUiComponentPropsAccessorsMixin.$props,
  keys: _$BasicUiComponentPropsAccessorsMixin.$propKeys,
);

class BasicUiComponentProps extends _$BasicUiComponentProps
    with _$BasicUiComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicUiComponentProps;
}

_$$BasicUiComponentProps _$BasicUiComponent([Map backingProps]) =>
    _$$BasicUiComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicUiComponentProps extends _$BasicUiComponentProps
    with _$BasicUiComponentPropsAccessorsMixin
    implements BasicUiComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicUiComponentProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $BasicUiComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicUiComponentProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$BasicUiComponentComponent extends BasicUiComponentComponent {
  @override
  _$$BasicUiComponentProps typedPropsFactory(Map backingMap) =>
      _$$BasicUiComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicUiComponentProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasicUiComponentProps
  ];
}
