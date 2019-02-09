// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prop_key_util_test_dart2.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestComponentFactory = registerComponent(() => new _$TestComponent(),
    builderFactory: Test,
    componentClass: TestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Test');

abstract class _$TestPropsAccessorsMixin implements _$TestProps {
  @override
  Map get props;

  /// Go to [_$TestProps.foo] to see the source code for this prop
  @override
  String get foo => props['TestProps.foo'];

  /// Go to [_$TestProps.foo] to see the source code for this prop
  @override
  set foo(String value) => props['TestProps.foo'] = value;

  /// Go to [_$TestProps.bar] to see the source code for this prop
  @override
  String get bar => props['TestProps.bar'];

  /// Go to [_$TestProps.bar] to see the source code for this prop
  @override
  set bar(String value) => props['TestProps.bar'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('TestProps.foo'),
    const PropDescriptor('TestProps.bar')
  ];
  static const List<String> $propKeys = const [
    'TestProps.foo',
    'TestProps.bar'
  ];
}

const PropsMeta _$metaForTestProps = const PropsMeta(
  fields: _$TestPropsAccessorsMixin.$props,
  keys: _$TestPropsAccessorsMixin.$propKeys,
);

class TestProps extends _$TestProps with _$TestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestProps;
}

_$$TestProps _$Test([Map backingProps]) => new _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestProps extends _$TestProps
    with _$TestPropsAccessorsMixin
    implements TestProps {
  _$$TestProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestComponent extends TestComponent {
  @override
  _$$TestProps typedPropsFactory(Map backingMap) =>
      new _$$TestProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestProps];
}
