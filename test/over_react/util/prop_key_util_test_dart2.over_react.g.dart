// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prop_key_util_test_dart2.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestComponentFactory = registerComponent(() => new _$TestComponent(),
    builderFactory: Test,
    componentClass: TestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Test');

abstract class _$TestPropsAccessorsMixin implements _$TestProps {
  @override
  Map get props;

  /// Go to [_$TestProps.foo] to see the source code for this prop
  @override
  String get foo =>
      props[_$key__foo___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TestProps.foo] to see the source code for this prop
  @override
  set foo(String value) => props[_$key__foo___$TestProps] = value;

  /// Go to [_$TestProps.bar] to see the source code for this prop
  @override
  String get bar =>
      props[_$key__bar___$TestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TestProps.bar] to see the source code for this prop
  @override
  set bar(String value) => props[_$key__bar___$TestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo___$TestProps =
      const PropDescriptor(_$key__foo___$TestProps);
  static const PropDescriptor _$prop__bar___$TestProps =
      const PropDescriptor(_$key__bar___$TestProps);
  static const String _$key__foo___$TestProps = 'TestProps.foo';
  static const String _$key__bar___$TestProps = 'TestProps.bar';

  static const List<PropDescriptor> $props = const [
    _$prop__foo___$TestProps,
    _$prop__bar___$TestProps
  ];
  static const List<String> $propKeys = const [
    _$key__foo___$TestProps,
    _$key__bar___$TestProps
  ];
}

const PropsMeta _$metaForTestProps = const PropsMeta(
  fields: _$TestPropsAccessorsMixin.$props,
  keys: _$TestPropsAccessorsMixin.$propKeys,
);

class TestProps extends _$TestProps with _$TestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestProps;
}

_$$TestProps _$Test([Map backingProps]) => backingProps == null
    ? new _$$TestProps$JsMap(new JsBackedMap())
    : new _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestProps extends _$TestProps
    with _$TestPropsAccessorsMixin
    implements TestProps {
  _$$TestProps._();
  factory _$$TestProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestProps$PlainMap(backingMap);
    } else {
      return new _$$TestProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestProps.';
}

class _$$TestProps$PlainMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

class _$$TestProps$JsMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestProps$JsMap(JsBackedMap backingMap)
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
class _$TestComponent extends TestComponent {
  @override
  _$$TestProps typedPropsFactory(Map backingMap) =>
      new _$$TestProps(backingMap);
  @override
  _$$TestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestProps];
  _$$TestProps$JsMap _cachedTypedProps;
  @override
  _$$TestProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
