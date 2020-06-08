// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'context_type_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ContextTypeComponentFactory = registerComponent2(
  () => _$ContextTypeComponent(),
  builderFactory: _$ContextType,
  componentClass: ContextTypeComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ContextType',
);

abstract class _$ContextTypePropsAccessorsMixin implements _$ContextTypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForContextTypeProps = PropsMeta(
  fields: _$ContextTypePropsAccessorsMixin.$props,
  keys: _$ContextTypePropsAccessorsMixin.$propKeys,
);

class ContextTypeProps extends _$ContextTypeProps
    with _$ContextTypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForContextTypeProps;
}

_$$ContextTypeProps _$ContextType([Map backingProps]) => backingProps == null
    ? _$$ContextTypeProps$JsMap(JsBackedMap())
    : _$$ContextTypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ContextTypeProps extends _$ContextTypeProps
    with _$ContextTypePropsAccessorsMixin
    implements ContextTypeProps {
  _$$ContextTypeProps._();

  factory _$$ContextTypeProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextTypeProps$JsMap(backingMap);
    } else {
      return _$$ContextTypeProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextTypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ContextTypeProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ContextTypeProps$PlainMap extends _$$ContextTypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeProps$PlainMap(Map backingMap)
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
class _$$ContextTypeProps$JsMap extends _$$ContextTypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeProps$JsMap(JsBackedMap backingMap)
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
class _$ContextTypeComponent extends ContextTypeComponent {
  _$$ContextTypeProps$JsMap _cachedTypedProps;

  @override
  _$$ContextTypeProps$JsMap get props => _cachedTypedProps;

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
  _$$ContextTypeProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ContextTypeProps$JsMap(backingMap);

  @override
  _$$ContextTypeProps typedPropsFactory(Map backingMap) =>
      _$$ContextTypeProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ContextTypeProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForContextTypeProps
  ];
}
