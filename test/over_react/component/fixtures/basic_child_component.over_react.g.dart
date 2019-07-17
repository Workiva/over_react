// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_child_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicChildComponentFactory = registerComponent2(
  () => new _$BasicChildComponent(),
  builderFactory: BasicChild,
  componentClass: BasicChildComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'BasicChild',
);

abstract class _$BasicChildPropsAccessorsMixin implements _$BasicChildProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForBasicChildProps = const PropsMeta(
  fields: _$BasicChildPropsAccessorsMixin.$props,
  keys: _$BasicChildPropsAccessorsMixin.$propKeys,
);

class BasicChildProps extends _$BasicChildProps
    with _$BasicChildPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicChildProps;
}

_$$BasicChildProps _$BasicChild([Map backingProps]) => backingProps == null
    ? new _$$BasicChildProps$JsMap(new JsBackedMap())
    : new _$$BasicChildProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$BasicChildProps extends _$BasicChildProps
    with _$BasicChildPropsAccessorsMixin
    implements BasicChildProps {
  _$$BasicChildProps._();

  factory _$$BasicChildProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$BasicChildProps$JsMap(backingMap);
    } else {
      return new _$$BasicChildProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  var _factoryOverride;
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicChildComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicChildProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicChildProps$PlainMap extends _$$BasicChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicChildProps$PlainMap(Map backingMap)
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
class _$$BasicChildProps$JsMap extends _$$BasicChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicChildProps$JsMap(JsBackedMap backingMap)
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
class _$BasicChildComponent extends BasicChildComponent {
  _$$BasicChildProps$JsMap _cachedTypedProps;

  @override
  _$$BasicChildProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$BasicChildProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$BasicChildProps$JsMap(backingMap);

  @override
  _$$BasicChildProps typedPropsFactory(Map backingMap) =>
      new _$$BasicChildProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicChildProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasicChildProps
  ];
}
