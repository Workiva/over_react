// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $OneLevelWrapper2ComponentFactory = registerComponent2(
  () => new _$OneLevelWrapper2Component(),
  builderFactory: OneLevelWrapper2,
  componentClass: OneLevelWrapper2Component,
  isWrapper: true,
  parentType: null,
  displayName: 'OneLevelWrapper2',
);

abstract class _$OneLevelWrapper2PropsAccessorsMixin
    implements _$OneLevelWrapper2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForOneLevelWrapper2Props = const PropsMeta(
  fields: _$OneLevelWrapper2PropsAccessorsMixin.$props,
  keys: _$OneLevelWrapper2PropsAccessorsMixin.$propKeys,
);

class OneLevelWrapper2Props extends _$OneLevelWrapper2Props
    with _$OneLevelWrapper2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForOneLevelWrapper2Props;
}

_$$OneLevelWrapper2Props _$OneLevelWrapper2([Map backingProps]) =>
    backingProps == null
        ? new _$$OneLevelWrapper2Props$JsMap(new JsBackedMap())
        : new _$$OneLevelWrapper2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$OneLevelWrapper2Props extends _$OneLevelWrapper2Props
    with _$OneLevelWrapper2PropsAccessorsMixin
    implements OneLevelWrapper2Props {
  _$$OneLevelWrapper2Props._();

  factory _$$OneLevelWrapper2Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$OneLevelWrapper2Props$JsMap(backingMap);
    } else {
      return new _$$OneLevelWrapper2Props$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $OneLevelWrapper2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'OneLevelWrapper2Props.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$OneLevelWrapper2Props$PlainMap extends _$$OneLevelWrapper2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapper2Props$PlainMap(Map backingMap)
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
class _$$OneLevelWrapper2Props$JsMap extends _$$OneLevelWrapper2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OneLevelWrapper2Props$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
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
class _$OneLevelWrapper2Component extends OneLevelWrapper2Component {
  _$$OneLevelWrapper2Props$JsMap _cachedTypedProps;

  @override
  _$$OneLevelWrapper2Props$JsMap get props => _cachedTypedProps;

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
  _$$OneLevelWrapper2Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$OneLevelWrapper2Props$JsMap(backingMap);

  @override
  _$$OneLevelWrapper2Props typedPropsFactory(Map backingMap) =>
      new _$$OneLevelWrapper2Props(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$OneLevelWrapper2Props.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForOneLevelWrapper2Props
  ];
}
