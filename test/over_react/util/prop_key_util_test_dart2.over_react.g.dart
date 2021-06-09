// @dart=2.7
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'prop_key_util_test_dart2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestComponentFactory = registerComponent2(
  () => _$TestComponent(),
  builderFactory: _$Test,
  componentClass: TestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Test',
);

abstract class _$TestPropsAccessorsMixin implements _$TestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TestProps.foo] -->
  @override
  String get foo => (props[_$key__foo___$TestProps] ?? null) as String;

  /// <!-- Generated from [_$TestProps.foo] -->
  @override
  set foo(String value) => props[_$key__foo___$TestProps] = value;

  /// <!-- Generated from [_$TestProps.bar] -->
  @override
  String get bar => (props[_$key__bar___$TestProps] ?? null) as String;

  /// <!-- Generated from [_$TestProps.bar] -->
  @override
  set bar(String value) => props[_$key__bar___$TestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo___$TestProps =
      PropDescriptor(_$key__foo___$TestProps);
  static const PropDescriptor _$prop__bar___$TestProps =
      PropDescriptor(_$key__bar___$TestProps);
  static const String _$key__foo___$TestProps = 'TestProps.foo';
  static const String _$key__bar___$TestProps = 'TestProps.bar';

  static const List<PropDescriptor> $props = [
    _$prop__foo___$TestProps,
    _$prop__bar___$TestProps
  ];
  static const List<String> $propKeys = [
    _$key__foo___$TestProps,
    _$key__bar___$TestProps
  ];
}

const PropsMeta _$metaForTestProps = PropsMeta(
  fields: _$TestPropsAccessorsMixin.$props,
  keys: _$TestPropsAccessorsMixin.$propKeys,
);

class TestProps extends _$TestProps with _$TestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestProps;
}

_$$TestProps _$Test([Map backingProps]) => backingProps == null
    ? _$$TestProps$JsMap(JsBackedMap())
    : _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestProps extends _$TestProps
    with _$TestPropsAccessorsMixin
    implements TestProps {
  _$$TestProps._();

  factory _$$TestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TestProps$PlainMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$PlainMap(Map backingMap)
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
class _$$TestProps$JsMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$JsMap(JsBackedMap backingMap)
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
class _$TestComponent extends TestComponent {
  _$$TestProps$JsMap _cachedTypedProps;

  @override
  _$$TestProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$TestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestProps$JsMap(backingMap);

  @override
  _$$TestProps typedPropsFactory(Map backingMap) => _$$TestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestProps];
}
