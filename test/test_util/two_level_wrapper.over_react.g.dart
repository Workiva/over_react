// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'two_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TwoLevelWrapperComponentFactory = registerComponent2(
  () => _$TwoLevelWrapperComponent(),
  builderFactory: TwoLevelWrapper,
  componentClass: TwoLevelWrapperComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'TwoLevelWrapper',
);

abstract class _$TwoLevelWrapperPropsAccessorsMixin
    implements _$TwoLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTwoLevelWrapperProps = PropsMeta(
  fields: _$TwoLevelWrapperPropsAccessorsMixin.$props,
  keys: _$TwoLevelWrapperPropsAccessorsMixin.$propKeys,
);

class TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTwoLevelWrapperProps;
}

_$$TwoLevelWrapperProps _$TwoLevelWrapper([Map backingProps]) =>
    backingProps == null
        ? _$$TwoLevelWrapperProps$JsMap(JsBackedMap())
        : _$$TwoLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin
    implements TwoLevelWrapperProps {
  _$$TwoLevelWrapperProps._();

  factory _$$TwoLevelWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TwoLevelWrapperProps$JsMap(backingMap);
    } else {
      return _$$TwoLevelWrapperProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TwoLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TwoLevelWrapperProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TwoLevelWrapperProps$PlainMap extends _$$TwoLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapperProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TwoLevelWrapperProps$JsMap extends _$$TwoLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TwoLevelWrapperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TwoLevelWrapperComponent extends TwoLevelWrapperComponent {
  _$$TwoLevelWrapperProps$JsMap _cachedTypedProps;

  @override
  _$$TwoLevelWrapperProps$JsMap get props => _cachedTypedProps;

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
  _$$TwoLevelWrapperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TwoLevelWrapperProps$JsMap(backingMap);

  @override
  _$$TwoLevelWrapperProps typedPropsFactory(Map backingMap) =>
      _$$TwoLevelWrapperProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TwoLevelWrapperProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTwoLevelWrapperProps
  ];
}
