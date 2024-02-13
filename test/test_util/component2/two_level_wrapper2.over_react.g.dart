// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'two_level_wrapper2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TwoLevelWrapper2ComponentFactory = registerComponent2(
  () => _$TwoLevelWrapper2Component(),
  builderFactory: _$TwoLevelWrapper2,
  componentClass: TwoLevelWrapper2Component,
  isWrapper: true,
  parentType: null,
);

abstract class _$TwoLevelWrapper2PropsAccessorsMixin
    implements _$TwoLevelWrapper2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTwoLevelWrapper2Props = PropsMeta(
  fields: _$TwoLevelWrapper2PropsAccessorsMixin.$props,
  keys: _$TwoLevelWrapper2PropsAccessorsMixin.$propKeys,
);

class TwoLevelWrapper2Props extends _$TwoLevelWrapper2Props
    with _$TwoLevelWrapper2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTwoLevelWrapper2Props;
}

_$$TwoLevelWrapper2Props _$TwoLevelWrapper2([Map? backingProps]) =>
    _$$TwoLevelWrapper2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TwoLevelWrapper2Props extends _$TwoLevelWrapper2Props
    with _$TwoLevelWrapper2PropsAccessorsMixin
    implements TwoLevelWrapper2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapper2Props(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $TwoLevelWrapper2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TwoLevelWrapper2Props.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TwoLevelWrapper2Component extends TwoLevelWrapper2Component {
  late _$$TwoLevelWrapper2Props _cachedTypedProps;

  @override
  _$$TwoLevelWrapper2Props get props => _cachedTypedProps;

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
  _$$TwoLevelWrapper2Props typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TwoLevelWrapper2Props(backingMap);

  @override
  _$$TwoLevelWrapper2Props typedPropsFactory(Map? backingMap) =>
      _$$TwoLevelWrapper2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TwoLevelWrapper2';

  /// The default consumed props, taken from _$TwoLevelWrapper2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTwoLevelWrapper2Props
  ];
}
