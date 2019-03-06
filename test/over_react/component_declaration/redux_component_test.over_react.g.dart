// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.component_declaration.redux_component_test;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestDefaultComponentFactory = registerComponent(
    () => new _$TestDefaultComponent(),
    builderFactory: TestDefault,
    componentClass: TestDefaultComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestDefault');

abstract class _$TestDefaultPropsAccessorsMixin implements _$TestDefaultProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestDefaultProps = const PropsMeta(
  fields: _$TestDefaultPropsAccessorsMixin.$props,
  keys: _$TestDefaultPropsAccessorsMixin.$propKeys,
);

class TestDefaultProps extends _$TestDefaultProps
    with _$TestDefaultPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestDefaultProps;
}

_$$TestDefaultProps _$TestDefault([Map backingProps]) => backingProps == null
    ? new _$$TestDefaultProps$JsMap(new JsBackedMap())
    : new _$$TestDefaultProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestDefaultProps extends _$TestDefaultProps
    with _$TestDefaultPropsAccessorsMixin
    implements TestDefaultProps {
  _$$TestDefaultProps._();
  factory _$$TestDefaultProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestDefaultProps$PlainMap(backingMap);
    } else {
      return new _$$TestDefaultProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestDefaultComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestDefaultProps.';
}

class _$$TestDefaultProps$PlainMap extends _$$TestDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestDefaultProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestDefaultProps$JsMap extends _$$TestDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestDefaultProps$JsMap(JsBackedMap backingMap)
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
class _$TestDefaultComponent extends TestDefaultComponent {
  @override
  _$$TestDefaultProps typedPropsFactory(Map backingMap) =>
      new _$$TestDefaultProps(backingMap);
  @override
  _$$TestDefaultProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestDefaultProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestDefaultProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestDefaultProps
  ];
  _$$TestDefaultProps$JsMap _cachedTypedProps;
  @override
  _$$TestDefaultProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestConnectComponentFactory = registerComponent(
    () => new _$TestConnectComponent(),
    builderFactory: TestConnect,
    componentClass: TestConnectComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestConnect');

abstract class _$TestConnectPropsAccessorsMixin implements _$TestConnectProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestConnectProps = const PropsMeta(
  fields: _$TestConnectPropsAccessorsMixin.$props,
  keys: _$TestConnectPropsAccessorsMixin.$propKeys,
);

class TestConnectProps extends _$TestConnectProps
    with _$TestConnectPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestConnectProps;
}

_$$TestConnectProps _$TestConnect([Map backingProps]) => backingProps == null
    ? new _$$TestConnectProps$JsMap(new JsBackedMap())
    : new _$$TestConnectProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestConnectProps extends _$TestConnectProps
    with _$TestConnectPropsAccessorsMixin
    implements TestConnectProps {
  _$$TestConnectProps._();
  factory _$$TestConnectProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestConnectProps$PlainMap(backingMap);
    } else {
      return new _$$TestConnectProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestConnectComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestConnectProps.';
}

class _$$TestConnectProps$PlainMap extends _$$TestConnectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestConnectProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestConnectProps$JsMap extends _$$TestConnectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestConnectProps$JsMap(JsBackedMap backingMap)
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
class _$TestConnectComponent extends TestConnectComponent {
  @override
  _$$TestConnectProps typedPropsFactory(Map backingMap) =>
      new _$$TestConnectProps(backingMap);
  @override
  _$$TestConnectProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestConnectProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestConnectProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestConnectProps
  ];
  _$$TestConnectProps$JsMap _cachedTypedProps;
  @override
  _$$TestConnectProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestPureComponentFactory = registerComponent(
    () => new _$TestPureComponent(),
    builderFactory: TestPure,
    componentClass: TestPureComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestPure');

abstract class _$TestPurePropsAccessorsMixin implements _$TestPureProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestPureProps = const PropsMeta(
  fields: _$TestPurePropsAccessorsMixin.$props,
  keys: _$TestPurePropsAccessorsMixin.$propKeys,
);

class TestPureProps extends _$TestPureProps with _$TestPurePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestPureProps;
}

_$$TestPureProps _$TestPure([Map backingProps]) => backingProps == null
    ? new _$$TestPureProps$JsMap(new JsBackedMap())
    : new _$$TestPureProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestPureProps extends _$TestPureProps
    with _$TestPurePropsAccessorsMixin
    implements TestPureProps {
  _$$TestPureProps._();
  factory _$$TestPureProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestPureProps$PlainMap(backingMap);
    } else {
      return new _$$TestPureProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TestPureComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestPureProps.';
}

class _$$TestPureProps$PlainMap extends _$$TestPureProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestPureProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestPureProps$JsMap extends _$$TestPureProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestPureProps$JsMap(JsBackedMap backingMap)
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
class _$TestPureComponent extends TestPureComponent {
  @override
  _$$TestPureProps typedPropsFactory(Map backingMap) =>
      new _$$TestPureProps(backingMap);
  @override
  _$$TestPureProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestPureProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestPureProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestPureProps
  ];
  _$$TestPureProps$JsMap _cachedTypedProps;
  @override
  _$$TestPureProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
