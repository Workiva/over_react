// @dart=2.11
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'private_props_ddc_bug.dart';

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
);

abstract class _$FooPropsAccessorsMixin implements _$FooProps {
  @override
  Map get props;

  /// <!-- Generated from [_$FooProps._privateProp] -->
  @override
  String get _privateProp =>
      (props[_$key___privateProp___$FooProps] ?? null) as String;

  /// <!-- Generated from [_$FooProps._privateProp] -->
  @override
  set _privateProp(String value) =>
      props[_$key___privateProp___$FooProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop___privateProp___$FooProps =
      PropDescriptor(_$key___privateProp___$FooProps);
  static const String _$key___privateProp___$FooProps = 'FooProps._privateProp';

  static const List<PropDescriptor> $props = [_$prop___privateProp___$FooProps];
  static const List<String> $propKeys = [_$key___privateProp___$FooProps];
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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$FooProps(accessMap, (map) => _$$FooProps(map));

  @override
  // ignore: must_call_super
  validateRequiredProps() {
    // Disable required prop validation, until this component is null safe, by not calling super.
  }

  @override
  Set<String> get requiredPropNamesToSkipValidation => const {'_privateProp'};
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$FooProps = getPropKey;

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

  @override
  String get displayName => 'Foo';

  /// The default consumed props, taken from _$FooProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForFooProps];
}
