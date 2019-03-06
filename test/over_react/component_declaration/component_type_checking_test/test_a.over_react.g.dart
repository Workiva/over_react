// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_component.test_a;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestAComponentFactory = registerComponent(() => new _$TestAComponent(),
    builderFactory: TestA,
    componentClass: TestAComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestA');

abstract class _$TestAPropsAccessorsMixin implements _$TestAProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestAProps = const PropsMeta(
  fields: _$TestAPropsAccessorsMixin.$props,
  keys: _$TestAPropsAccessorsMixin.$propKeys,
);

class TestAProps extends _$TestAProps with _$TestAPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestAProps;
}

_$$TestAProps _$TestA([Map backingProps]) => backingProps == null
    ? new _$$TestAProps$JsMap(new JsBackedMap())
    : new _$$TestAProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestAProps extends _$TestAProps
    with _$TestAPropsAccessorsMixin
    implements TestAProps {
  _$$TestAProps._();
  factory _$$TestAProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestAProps$PlainMap(backingMap);
    } else {
      return new _$$TestAProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TestAComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestAProps.';
}

class _$$TestAProps$PlainMap extends _$$TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestAProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestAProps$JsMap extends _$$TestAProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestAProps$JsMap(JsBackedMap backingMap)
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
class _$TestAComponent extends TestAComponent {
  @override
  _$$TestAProps typedPropsFactory(Map backingMap) =>
      new _$$TestAProps(backingMap);
  @override
  _$$TestAProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestAProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestAProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTestAProps];
  _$$TestAProps$JsMap _cachedTypedProps;
  @override
  _$$TestAProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
