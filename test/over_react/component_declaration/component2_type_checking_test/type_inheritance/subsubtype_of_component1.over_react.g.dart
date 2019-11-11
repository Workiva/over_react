// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'subsubtype_of_component1.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubsubtypeOfComponent1ComponentFactory = registerComponent2(
  () => _$TestSubsubtypeOfComponent1Component(),
  builderFactory: TestSubsubtypeOfComponent1,
  componentClass: TestSubsubtypeOfComponent1Component,
  isWrapper: false,
  parentType: $TestSubtypeOfComponent1ComponentFactory,
  /* from `subtypeOf: TestSubtypeOfComponent1Component` */
  displayName: 'TestSubsubtypeOfComponent1',
);

abstract class _$TestSubsubtypeOfComponent1PropsAccessorsMixin
    implements _$TestSubsubtypeOfComponent1Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubsubtypeOfComponent1Props = PropsMeta(
  fields: _$TestSubsubtypeOfComponent1PropsAccessorsMixin.$props,
  keys: _$TestSubsubtypeOfComponent1PropsAccessorsMixin.$propKeys,
);

class TestSubsubtypeOfComponent1Props extends _$TestSubsubtypeOfComponent1Props
    with _$TestSubsubtypeOfComponent1PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubsubtypeOfComponent1Props;
}

_$$TestSubsubtypeOfComponent1Props _$TestSubsubtypeOfComponent1(
        [Map backingProps]) =>
    backingProps == null
        ? _$$TestSubsubtypeOfComponent1Props$JsMap(JsBackedMap())
        : _$$TestSubsubtypeOfComponent1Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestSubsubtypeOfComponent1Props
    extends _$TestSubsubtypeOfComponent1Props
    with _$TestSubsubtypeOfComponent1PropsAccessorsMixin
    implements TestSubsubtypeOfComponent1Props {
  _$$TestSubsubtypeOfComponent1Props._();

  factory _$$TestSubsubtypeOfComponent1Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestSubsubtypeOfComponent1Props$JsMap(backingMap);
    } else {
      return _$$TestSubsubtypeOfComponent1Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestSubsubtypeOfComponent1ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubsubtypeOfComponent1Props.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TestSubsubtypeOfComponent1Props$PlainMap
    extends _$$TestSubsubtypeOfComponent1Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtypeOfComponent1Props$PlainMap(Map backingMap)
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
class _$$TestSubsubtypeOfComponent1Props$JsMap
    extends _$$TestSubsubtypeOfComponent1Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSubsubtypeOfComponent1Props$JsMap(JsBackedMap backingMap)
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
class _$TestSubsubtypeOfComponent1Component
    extends TestSubsubtypeOfComponent1Component {
  _$$TestSubsubtypeOfComponent1Props$JsMap _cachedTypedProps;

  @override
  _$$TestSubsubtypeOfComponent1Props$JsMap get props => _cachedTypedProps;

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
  _$$TestSubsubtypeOfComponent1Props$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$TestSubsubtypeOfComponent1Props$JsMap(backingMap);

  @override
  _$$TestSubsubtypeOfComponent1Props typedPropsFactory(Map backingMap) =>
      _$$TestSubsubtypeOfComponent1Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestSubsubtypeOfComponent1Props.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubsubtypeOfComponent1Props
  ];
}
