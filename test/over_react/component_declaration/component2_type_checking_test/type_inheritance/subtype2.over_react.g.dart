// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'subtype2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubtype2ComponentFactory = registerComponent2(
  () => _$TestSubtype2Component(),
  builderFactory: _$TestSubtype2,
  componentClass: TestSubtype2Component,
  isWrapper: false,
  parentType: $TestParent2ComponentFactory,
  /* from `subtypeOf: TestParent2Component` */
  displayName: 'TestSubtype2',
);

abstract class _$TestSubtype2PropsAccessorsMixin
    implements _$TestSubtype2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubtype2Props = PropsMeta(
  fields: _$TestSubtype2PropsAccessorsMixin.$props,
  keys: _$TestSubtype2PropsAccessorsMixin.$propKeys,
);

class TestSubtype2Props extends _$TestSubtype2Props
    with _$TestSubtype2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubtype2Props;
}

_$$TestSubtype2Props _$TestSubtype2([Map backingProps]) => backingProps == null
    ? _$$TestSubtype2Props(JsBackedMap())
    : _$$TestSubtype2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubtype2Props extends _$TestSubtype2Props
    with _$TestSubtype2PropsAccessorsMixin
    implements TestSubtype2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubtype2Props(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $TestSubtype2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubtype2Props.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubtype2Component extends TestSubtype2Component {
  _$$TestSubtype2Props _cachedTypedProps;

  @override
  _$$TestSubtype2Props get props => _cachedTypedProps;

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
  _$$TestSubtype2Props typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestSubtype2Props(backingMap);

  @override
  _$$TestSubtype2Props typedPropsFactory(Map backingMap) =>
      _$$TestSubtype2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubtype2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubtype2Props
  ];
}
