// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'subsubtype2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubsubtype2ComponentFactory = registerComponent2(
  () => _$TestSubsubtype2Component(),
  builderFactory: _$TestSubsubtype2,
  componentClass: TestSubsubtype2Component,
  isWrapper: false,
  parentType: $TestSubtype2ComponentFactory,
  /* from `subtypeOf: TestSubtype2Component` */
  displayName: 'TestSubsubtype2',
);

abstract class _$TestSubsubtype2PropsAccessorsMixin
    implements _$TestSubsubtype2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubsubtype2Props = PropsMeta(
  fields: _$TestSubsubtype2PropsAccessorsMixin.$props,
  keys: _$TestSubsubtype2PropsAccessorsMixin.$propKeys,
);

class TestSubsubtype2Props extends _$TestSubsubtype2Props
    with _$TestSubsubtype2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubsubtype2Props;
}

_$$TestSubsubtype2Props _$TestSubsubtype2([Map backingProps]) =>
    backingProps == null
        ? _$$TestSubsubtype2Props$JsMap(JsBackedMap())
        : _$$TestSubsubtype2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestSubsubtype2Props extends _$TestSubsubtype2Props
    with _$TestSubsubtype2PropsAccessorsMixin
    implements TestSubsubtype2Props {
  _$$TestSubsubtype2Props._();

  factory _$$TestSubsubtype2Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestSubsubtype2Props$JsMap(backingMap);
    } else {
      return _$$TestSubsubtype2Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestSubsubtype2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubsubtype2Props.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TestSubsubtype2Props$PlainMap extends _$$TestSubsubtype2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtype2Props$PlainMap(Map backingMap)
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
class _$$TestSubsubtype2Props$JsMap extends _$$TestSubsubtype2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtype2Props$JsMap(JsBackedMap backingMap)
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
class _$TestSubsubtype2Component extends TestSubsubtype2Component {
  _$$TestSubsubtype2Props$JsMap _cachedTypedProps;

  @override
  _$$TestSubsubtype2Props$JsMap get props => _cachedTypedProps;

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
  _$$TestSubsubtype2Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestSubsubtype2Props$JsMap(backingMap);

  @override
  _$$TestSubsubtype2Props typedPropsFactory(Map backingMap) =>
      _$$TestSubsubtype2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubsubtype2Props.
  /// Used in -`ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubsubtype2Props
  ];
}
