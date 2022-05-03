// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'test_a.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestAComponentFactory = registerComponent(
  () => _$TestAComponent(),
  builderFactory: _$TestA,
  componentClass: TestAComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'TestA',
);

abstract class _$TestAPropsAccessorsMixin implements _$TestAProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestAProps = PropsMeta(
  fields: _$TestAPropsAccessorsMixin.$props,
  keys: _$TestAPropsAccessorsMixin.$propKeys,
);

class TestAProps extends _$TestAProps with _$TestAPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestAProps;
}

_$$TestAProps _$TestA([Map backingProps]) => _$$TestAProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestAProps extends _$TestAProps
    with _$TestAPropsAccessorsMixin
    implements TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestAProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestAComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestAProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestAComponent extends TestAComponent {
  @override
  _$$TestAProps typedPropsFactory(Map backingMap) => _$$TestAProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestAProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestAProps];
}
