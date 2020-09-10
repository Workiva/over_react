// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'string_example_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $StringExampleComponentFactory = registerComponent2(
  () => _$StringExampleComponent(),
  builderFactory: _$StringExample,
  componentClass: StringExampleComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'StringExample',
);

abstract class _$StringExamplePropsAccessorsMixin
    implements _$StringExampleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForStringExampleProps = PropsMeta(
  fields: _$StringExamplePropsAccessorsMixin.$props,
  keys: _$StringExamplePropsAccessorsMixin.$propKeys,
);

_$$StringExampleProps _$StringExample([Map backingProps]) =>
    backingProps == null
        ? _$$StringExampleProps(JsBackedMap())
        : _$$StringExampleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$StringExampleProps extends _$StringExampleProps
    with _$StringExamplePropsAccessorsMixin
    implements StringExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StringExampleProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $StringExampleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'StringExampleProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$StringExampleComponent extends StringExampleComponent {
  _$$StringExampleProps _cachedTypedProps;

  @override
  _$$StringExampleProps get props => _cachedTypedProps;

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
  _$$StringExampleProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$StringExampleProps(backingMap);

  @override
  _$$StringExampleProps typedPropsFactory(Map backingMap) =>
      _$$StringExampleProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$StringExampleProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForStringExampleProps
  ];
}
