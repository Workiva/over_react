// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'subtype.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubtypeComponentFactory =
    registerComponent(() => new _$TestSubtypeComponent(),
        builderFactory: TestSubtype,
        componentClass: TestSubtypeComponent,
        isWrapper: false,
        parentType: $TestParentComponentFactory,
        /* from `subtypeOf: TestParentComponent` */
        displayName: 'TestSubtype');

abstract class _$TestSubtypePropsAccessorsMixin implements _$TestSubtypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubtypeProps = PropsMeta(
  fields: _$TestSubtypePropsAccessorsMixin.$props,
  keys: _$TestSubtypePropsAccessorsMixin.$propKeys,
);

class TestSubtypeProps extends _$TestSubtypeProps
    with _$TestSubtypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubtypeProps;
}

_$$TestSubtypeProps _$TestSubtype([Map backingProps]) =>
    new _$$TestSubtypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubtypeProps extends _$TestSubtypeProps
    with _$TestSubtypePropsAccessorsMixin
    implements TestSubtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubtypeProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestSubtypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubtypeProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubtypeComponent extends TestSubtypeComponent {
  @override
  _$$TestSubtypeProps typedPropsFactory(Map backingMap) =>
      new _$$TestSubtypeProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubtypeProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubtypeProps
  ];
}
