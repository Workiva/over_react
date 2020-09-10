// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_child_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicChildComponentFactory = registerComponent2(
  () => _$BasicChildComponent(),
  builderFactory: _$BasicChild,
  componentClass: BasicChildComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'BasicChild',
);

abstract class _$BasicChildPropsAccessorsMixin implements _$BasicChildProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForBasicChildProps = PropsMeta(
  fields: _$BasicChildPropsAccessorsMixin.$props,
  keys: _$BasicChildPropsAccessorsMixin.$propKeys,
);

class BasicChildProps extends _$BasicChildProps
    with _$BasicChildPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicChildProps;
}

_$$BasicChildProps _$BasicChild([Map backingProps]) => backingProps == null
    ? _$$BasicChildProps(JsBackedMap())
    : _$$BasicChildProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicChildProps extends _$BasicChildProps
    with _$BasicChildPropsAccessorsMixin
    implements BasicChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicChildProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $BasicChildComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicChildProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$BasicChildComponent extends BasicChildComponent {
  _$$BasicChildProps _cachedTypedProps;

  @override
  _$$BasicChildProps get props => _cachedTypedProps;

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
  _$$BasicChildProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicChildProps(backingMap);

  @override
  _$$BasicChildProps typedPropsFactory(Map backingMap) =>
      _$$BasicChildProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicChildProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasicChildProps
  ];
}
