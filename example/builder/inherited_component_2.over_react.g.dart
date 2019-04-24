// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inherited_component_2.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $InheritedComponentFactory = registerComponent(
    () => new _$InheritedComponent(),
    builderFactory: Inherited,
    componentClass: InheritedComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Inherited');

abstract class _$InheritedPropsAccessorsMixin implements _$InheritedProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForInheritedProps = const PropsMeta(
  fields: _$InheritedPropsAccessorsMixin.$props,
  keys: _$InheritedPropsAccessorsMixin.$propKeys,
);

class InheritedProps extends _$InheritedProps
    with _$InheritedPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForInheritedProps;
}

_$$InheritedProps _$Inherited([Map backingProps]) => backingProps == null
    ? new _$$InheritedProps$JsMap(new JsBackedMap())
    : new _$$InheritedProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$InheritedProps extends _$InheritedProps
    with _$InheritedPropsAccessorsMixin
    implements InheritedProps {
  _$$InheritedProps._();

  factory _$$InheritedProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$InheritedProps$JsMap(backingMap);
    } else {
      return new _$$InheritedProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $InheritedComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'InheritedProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$InheritedProps$PlainMap extends _$$InheritedProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$InheritedProps$PlainMap(Map backingMap)
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
class _$$InheritedProps$JsMap extends _$$InheritedProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$InheritedProps$JsMap(JsBackedMap backingMap)
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
class _$InheritedComponent extends InheritedComponent {
  _$$InheritedProps$JsMap _cachedTypedProps;

  @override
  _$$InheritedProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$InheritedProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$InheritedProps$JsMap(backingMap);

  @override
  _$$InheritedProps typedPropsFactory(Map backingMap) =>
      new _$$InheritedProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$InheritedProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForInheritedProps
  ];
}
