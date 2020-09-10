// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'test_a2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestA2ComponentFactory = registerComponent2(
  () => _$TestA2Component(),
  builderFactory: _$TestA2,
  componentClass: TestA2Component,
  isWrapper: false,
  parentType: null,
  displayName: 'TestA2',
);

abstract class _$TestA2PropsAccessorsMixin implements _$TestA2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestA2Props = PropsMeta(
  fields: _$TestA2PropsAccessorsMixin.$props,
  keys: _$TestA2PropsAccessorsMixin.$propKeys,
);

class TestA2Props extends _$TestA2Props with _$TestA2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestA2Props;
}

_$$TestA2Props _$TestA2([Map backingProps]) => backingProps == null
    ? _$$TestA2Props(JsBackedMap())
    : _$$TestA2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestA2Props extends _$TestA2Props
    with _$TestA2PropsAccessorsMixin
    implements TestA2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestA2Props(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $TestA2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestA2Props.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestA2Component extends TestA2Component {
  _$$TestA2Props _cachedTypedProps;

  @override
  _$$TestA2Props get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$TestA2Props typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestA2Props(backingMap);

  @override
  _$$TestA2Props typedPropsFactory(Map backingMap) =>
      _$$TestA2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestA2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestA2Props
  ];
}
