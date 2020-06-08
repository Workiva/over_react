// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'num_example_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $NumExampleComponentFactory = registerComponent2(
  () => _$NumExampleComponent(),
  builderFactory: _$NumExample,
  componentClass: NumExampleComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'NumExample',
);

abstract class _$NumExamplePropsAccessorsMixin implements _$NumExampleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForNumExampleProps = PropsMeta(
  fields: _$NumExamplePropsAccessorsMixin.$props,
  keys: _$NumExamplePropsAccessorsMixin.$propKeys,
);

_$$NumExampleProps _$NumExample([Map backingProps]) => backingProps == null
    ? _$$NumExampleProps$JsMap(JsBackedMap())
    : _$$NumExampleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$NumExampleProps extends _$NumExampleProps
    with _$NumExamplePropsAccessorsMixin
    implements NumExampleProps {
  _$$NumExampleProps._();

  factory _$$NumExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$NumExampleProps$JsMap(backingMap);
    } else {
      return _$$NumExampleProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $NumExampleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'NumExampleProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$NumExampleProps$PlainMap extends _$$NumExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NumExampleProps$PlainMap(Map backingMap)
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
class _$$NumExampleProps$JsMap extends _$$NumExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NumExampleProps$JsMap(JsBackedMap backingMap)
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
class _$NumExampleComponent extends NumExampleComponent {
  _$$NumExampleProps$JsMap _cachedTypedProps;

  @override
  _$$NumExampleProps$JsMap get props => _cachedTypedProps;

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
  _$$NumExampleProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$NumExampleProps$JsMap(backingMap);

  @override
  _$$NumExampleProps typedPropsFactory(Map backingMap) =>
      _$$NumExampleProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$NumExampleProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForNumExampleProps
  ];
}
