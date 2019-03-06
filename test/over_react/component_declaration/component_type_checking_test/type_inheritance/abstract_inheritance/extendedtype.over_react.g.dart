// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_component.type_inheritance.extendedtype;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestExtendtypeComponentFactory =
    registerComponent(() => new _$TestExtendtypeComponent(),
        builderFactory: TestExtendtype,
        componentClass: TestExtendtypeComponent,
        isWrapper: false,
        parentType: $TestAbstractComponentFactory,
        /* from `subtypeOf: TestAbstractComponent` */
        displayName: 'TestExtendtype');

abstract class _$TestExtendtypePropsAccessorsMixin
    implements _$TestExtendtypeProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestExtendtypeProps = const PropsMeta(
  fields: _$TestExtendtypePropsAccessorsMixin.$props,
  keys: _$TestExtendtypePropsAccessorsMixin.$propKeys,
);

class TestExtendtypeProps extends _$TestExtendtypeProps
    with _$TestExtendtypePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestExtendtypeProps;
}

_$$TestExtendtypeProps _$TestExtendtype([Map backingProps]) =>
    backingProps == null
        ? new _$$TestExtendtypeProps$JsMap(new JsBackedMap())
        : new _$$TestExtendtypeProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestExtendtypeProps extends _$TestExtendtypeProps
    with _$TestExtendtypePropsAccessorsMixin
    implements TestExtendtypeProps {
  _$$TestExtendtypeProps._();
  factory _$$TestExtendtypeProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestExtendtypeProps$PlainMap(backingMap);
    } else {
      return new _$$TestExtendtypeProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestExtendtypeComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestExtendtypeProps.';
}

class _$$TestExtendtypeProps$PlainMap extends _$$TestExtendtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestExtendtypeProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestExtendtypeProps$JsMap extends _$$TestExtendtypeProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestExtendtypeProps$JsMap(JsBackedMap backingMap)
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
class _$TestExtendtypeComponent extends TestExtendtypeComponent {
  @override
  _$$TestExtendtypeProps typedPropsFactory(Map backingMap) =>
      new _$$TestExtendtypeProps(backingMap);
  @override
  _$$TestExtendtypeProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestExtendtypeProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestExtendtypeProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestExtendtypeProps
  ];
  _$$TestExtendtypeProps$JsMap _cachedTypedProps;
  @override
  _$$TestExtendtypeProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
