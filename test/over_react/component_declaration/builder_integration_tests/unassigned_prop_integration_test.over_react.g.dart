// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'unassigned_prop_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FooComponentFactory = registerComponent(
  () => _$FooComponent(),
  builderFactory: _$Foo,
  componentClass: FooComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Foo',
);

abstract class _$FooPropsAccessorsMixin implements _$FooProps {
  @override
  Map get props;

  /// <!-- Generated from [_$FooProps.stringProp] -->
  @override
  String get stringProp =>
      props[_$key__stringProp___$FooProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FooProps.stringProp] -->
  @override
  set stringProp(String value) => props[_$key__stringProp___$FooProps] = value;

  /// <!-- Generated from [_$FooProps.unassignedProp] -->
  @override
  String get unassignedProp =>
      props[_$key__unassignedProp___$FooProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FooProps.unassignedProp] -->
  @override
  set unassignedProp(String value) =>
      props[_$key__unassignedProp___$FooProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp___$FooProps =
      PropDescriptor(_$key__stringProp___$FooProps);
  static const PropDescriptor _$prop__unassignedProp___$FooProps =
      PropDescriptor(_$key__unassignedProp___$FooProps);
  static const String _$key__stringProp___$FooProps = 'FooProps.stringProp';
  static const String _$key__unassignedProp___$FooProps =
      'FooProps.unassignedProp';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp___$FooProps,
    _$prop__unassignedProp___$FooProps
  ];
  static const List<String> $propKeys = [
    _$key__stringProp___$FooProps,
    _$key__unassignedProp___$FooProps
  ];
}

const PropsMeta _$metaForFooProps = PropsMeta(
  fields: _$FooPropsAccessorsMixin.$props,
  keys: _$FooPropsAccessorsMixin.$propKeys,
);

class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForFooProps;
}

_$$FooProps _$Foo([Map backingProps]) => _$$FooProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FooProps extends _$FooProps
    with _$FooPropsAccessorsMixin
    implements FooProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $FooComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FooProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FooComponent extends FooComponent {
  @override
  _$$FooProps typedPropsFactory(Map backingMap) => _$$FooProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FooProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForFooProps];
}
