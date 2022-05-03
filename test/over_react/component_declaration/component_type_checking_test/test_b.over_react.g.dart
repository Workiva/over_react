// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'test_b.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestBComponentFactory = registerComponent(
  () => _$TestBComponent(),
  builderFactory: _$TestB,
  componentClass: TestBComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'TestB',
);

abstract class _$TestBPropsAccessorsMixin implements _$TestBProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestBProps = PropsMeta(
  fields: _$TestBPropsAccessorsMixin.$props,
  keys: _$TestBPropsAccessorsMixin.$propKeys,
);

class TestBProps extends _$TestBProps with _$TestBPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestBProps;
}

_$$TestBProps _$TestB([Map backingProps]) => _$$TestBProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestBProps extends _$TestBProps
    with _$TestBPropsAccessorsMixin
    implements TestBProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestBProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestBComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestBProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestBComponent extends TestBComponent {
  @override
  _$$TestBProps typedPropsFactory(Map backingMap) => _$$TestBProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestBProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestBProps];
}
