// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'subsubtype.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubsubtypeComponentFactory = registerComponent(
  () => _$TestSubsubtypeComponent(),
  builderFactory: _$TestSubsubtype,
  componentClass: TestSubsubtypeComponent,
  isWrapper: false,
  parentType: $TestSubtypeComponentFactory,
  /* from `subtypeOf: TestSubtypeComponent` */
  displayName: 'TestSubsubtype',
);

abstract class _$TestSubsubtypePropsAccessorsMixin
    implements _$TestSubsubtypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubsubtypeProps = PropsMeta(
  fields: _$TestSubsubtypePropsAccessorsMixin.$props,
  keys: _$TestSubsubtypePropsAccessorsMixin.$propKeys,
);

class TestSubsubtypeProps extends _$TestSubsubtypeProps
    with _$TestSubsubtypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubsubtypeProps;
}

_$$TestSubsubtypeProps _$TestSubsubtype([Map? backingProps]) =>
    _$$TestSubsubtypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubsubtypeProps extends _$TestSubsubtypeProps
    with _$TestSubsubtypePropsAccessorsMixin
    implements TestSubsubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtypeProps(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $TestSubsubtypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubsubtypeProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubsubtypeComponent extends TestSubsubtypeComponent {
  @override
  _$$TestSubsubtypeProps typedPropsFactory(Map? backingMap) =>
      _$$TestSubsubtypeProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubsubtypeProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubsubtypeProps
  ];
}
