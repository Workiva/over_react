// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SimpleComponentFactory = registerComponent2(
  () => new _$SimpleComponent(),
  builderFactory: Simple,
  componentClass: SimpleComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Simple',
);

abstract class _$SimplePropsAccessorsMixin implements _$SimpleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForSimpleProps = const PropsMeta(
  fields: _$SimplePropsAccessorsMixin.$props,
  keys: _$SimplePropsAccessorsMixin.$propKeys,
);

class SimpleProps extends _$SimpleProps with _$SimplePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSimpleProps;
}

_$$SimpleProps _$Simple([Map backingProps]) => backingProps == null
    ? new _$$SimpleProps$JsMap(new JsBackedMap())
    : new _$$SimpleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$SimpleProps extends _$SimpleProps
    with _$SimplePropsAccessorsMixin
    implements SimpleProps {
  _$$SimpleProps._();

  factory _$$SimpleProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$SimpleProps$JsMap(backingMap);
    } else {
      return new _$$SimpleProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SimpleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SimpleProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$SimpleProps$PlainMap extends _$$SimpleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SimpleProps$PlainMap(Map backingMap)
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
class _$$SimpleProps$JsMap extends _$$SimpleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SimpleProps$JsMap(JsBackedMap backingMap)
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
class _$SimpleComponent extends SimpleComponent {
  _$$SimpleProps$JsMap _cachedTypedProps;

  @override
  _$$SimpleProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$SimpleProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$SimpleProps$JsMap(backingMap);

  @override
  _$$SimpleProps typedPropsFactory(Map backingMap) =>
      new _$$SimpleProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SimpleProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForSimpleProps
  ];
}
