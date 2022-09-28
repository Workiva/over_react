// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'flawed_component_on_mount.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedOnMountComponentFactory = registerComponent2(
  () => _$FlawedOnMountComponent(),
  builderFactory: _$FlawedOnMount,
  componentClass: FlawedOnMountComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$FlawedOnMountPropsAccessorsMixin
    implements _$FlawedOnMountProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForFlawedOnMountProps = PropsMeta(
  fields: _$FlawedOnMountPropsAccessorsMixin.$props,
  keys: _$FlawedOnMountPropsAccessorsMixin.$propKeys,
);

_$$FlawedOnMountProps _$FlawedOnMount([Map backingProps]) =>
    backingProps == null
        ? _$$FlawedOnMountProps$JsMap(JsBackedMap())
        : _$$FlawedOnMountProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$FlawedOnMountProps extends _$FlawedOnMountProps
    with _$FlawedOnMountPropsAccessorsMixin
    implements FlawedOnMountProps {
  _$$FlawedOnMountProps._();

  factory _$$FlawedOnMountProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FlawedOnMountProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$FlawedOnMountProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FlawedOnMountComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedOnMountProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$FlawedOnMountProps$PlainMap extends _$$FlawedOnMountProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedOnMountProps$PlainMap(Map backingMap)
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
class _$$FlawedOnMountProps$JsMap extends _$$FlawedOnMountProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedOnMountProps$JsMap(JsBackedMap backingMap)
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
class _$FlawedOnMountComponent extends FlawedOnMountComponent {
  _$$FlawedOnMountProps$JsMap _cachedTypedProps;

  @override
  _$$FlawedOnMountProps$JsMap get props => _cachedTypedProps;

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
  _$$FlawedOnMountProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FlawedOnMountProps$JsMap(backingMap);

  @override
  _$$FlawedOnMountProps typedPropsFactory(Map backingMap) =>
      _$$FlawedOnMountProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'FlawedOnMount';

  /// The default consumed props, taken from _$FlawedOnMountProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedOnMountProps
  ];
}
