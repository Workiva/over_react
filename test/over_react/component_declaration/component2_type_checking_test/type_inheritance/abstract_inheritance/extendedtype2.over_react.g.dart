// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'extendedtype2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestExtendtype2ComponentFactory = registerComponent2(
  () => _$TestExtendtype2Component(),
  builderFactory: _$TestExtendtype2,
  componentClass: TestExtendtype2Component,
  isWrapper: false,
  parentType: $TestAbstract2ComponentFactory,
  /* from `subtypeOf: TestAbstract2Component` */
  displayName: 'TestExtendtype2',
);

abstract class _$TestExtendtype2PropsAccessorsMixin
    implements _$TestExtendtype2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestExtendtype2Props = PropsMeta(
  fields: _$TestExtendtype2PropsAccessorsMixin.$props,
  keys: _$TestExtendtype2PropsAccessorsMixin.$propKeys,
);

class TestExtendtype2Props extends _$TestExtendtype2Props
    with _$TestExtendtype2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestExtendtype2Props;
}

_$$TestExtendtype2Props _$TestExtendtype2([Map backingProps]) =>
    _$$TestExtendtype2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestExtendtype2Props extends _$TestExtendtype2Props
    with _$TestExtendtype2PropsAccessorsMixin
    implements TestExtendtype2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestExtendtype2Props(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestExtendtype2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestExtendtype2Props.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestExtendtype2Component extends TestExtendtype2Component {
  _$$TestExtendtype2Props _cachedTypedProps;

  @override
  _$$TestExtendtype2Props get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$TestExtendtype2Props typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestExtendtype2Props(backingMap);

  @override
  _$$TestExtendtype2Props typedPropsFactory(Map backingMap) =>
      _$$TestExtendtype2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestExtendtype2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestExtendtype2Props
  ];
}
