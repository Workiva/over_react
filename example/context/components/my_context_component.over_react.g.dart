// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_context_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $MyContextComponentComponentFactory = registerComponent2(
  () => new _$MyContextComponentComponent(),
  builderFactory: MyContextComponent,
  componentClass: MyContextComponentComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'MyContextComponent',
);

abstract class _$MyContextComponentPropsAccessorsMixin
    implements _$MyContextComponentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForMyContextComponentProps = const PropsMeta(
  fields: _$MyContextComponentPropsAccessorsMixin.$props,
  keys: _$MyContextComponentPropsAccessorsMixin.$propKeys,
);

class MyContextComponentProps extends _$MyContextComponentProps
    with _$MyContextComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForMyContextComponentProps;
}

_$$MyContextComponentProps _$MyContextComponent([Map backingProps]) =>
    backingProps == null
        ? new _$$MyContextComponentProps$JsMap(new JsBackedMap())
        : new _$$MyContextComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$MyContextComponentProps extends _$MyContextComponentProps
    with _$MyContextComponentPropsAccessorsMixin
    implements MyContextComponentProps {
  _$$MyContextComponentProps._();

  factory _$$MyContextComponentProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$MyContextComponentProps$JsMap(backingMap);
    } else {
      return new _$$MyContextComponentProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $MyContextComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'MyContextComponentProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$MyContextComponentProps$PlainMap extends _$$MyContextComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyContextComponentProps$PlainMap(Map backingMap)
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
class _$$MyContextComponentProps$JsMap extends _$$MyContextComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyContextComponentProps$JsMap(JsBackedMap backingMap)
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
class _$MyContextComponentComponent extends MyContextComponentComponent {
  _$$MyContextComponentProps$JsMap _cachedTypedProps;

  @override
  _$$MyContextComponentProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$MyContextComponentProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$MyContextComponentProps$JsMap(backingMap);

  @override
  _$$MyContextComponentProps typedPropsFactory(Map backingMap) =>
      new _$$MyContextComponentProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$MyContextComponentProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForMyContextComponentProps
  ];
}
