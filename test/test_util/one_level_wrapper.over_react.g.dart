// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'one_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $OneLevelWrapperComponentFactory = registerComponent2(
  () => _$OneLevelWrapperComponent(),
  builderFactory: OneLevelWrapper,
  componentClass: OneLevelWrapperComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'OneLevelWrapper',
);

abstract class _$OneLevelWrapperPropsAccessorsMixin
    implements _$OneLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForOneLevelWrapperProps = PropsMeta(
  fields: _$OneLevelWrapperPropsAccessorsMixin.$props,
  keys: _$OneLevelWrapperPropsAccessorsMixin.$propKeys,
);

class OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForOneLevelWrapperProps;
}

_$$OneLevelWrapperProps _$OneLevelWrapper([Map backingProps]) =>
    backingProps == null
        ? _$$OneLevelWrapperProps$JsMap(JsBackedMap())
        : _$$OneLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$OneLevelWrapperProps extends _$OneLevelWrapperProps
    with _$OneLevelWrapperPropsAccessorsMixin
    implements OneLevelWrapperProps {
  _$$OneLevelWrapperProps._();

  factory _$$OneLevelWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$OneLevelWrapperProps$JsMap(backingMap);
    } else {
      return _$$OneLevelWrapperProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $OneLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'OneLevelWrapperProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$OneLevelWrapperProps$PlainMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapperProps$PlainMap(Map backingMap)
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
class _$$OneLevelWrapperProps$JsMap extends _$$OneLevelWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapperProps$JsMap(JsBackedMap backingMap)
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
class _$OneLevelWrapperComponent extends OneLevelWrapperComponent {
  _$$OneLevelWrapperProps$JsMap _cachedTypedProps;

  @override
  _$$OneLevelWrapperProps$JsMap get props => _cachedTypedProps;

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
  _$$OneLevelWrapperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$OneLevelWrapperProps$JsMap(backingMap);

  @override
  _$$OneLevelWrapperProps typedPropsFactory(Map backingMap) =>
      _$$OneLevelWrapperProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$OneLevelWrapperProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForOneLevelWrapperProps
  ];
}
