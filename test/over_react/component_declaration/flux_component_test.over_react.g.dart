// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.component_declaration.flux_component_test;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestBasicComponentFactory = registerComponent(
    () => new _$TestBasicComponent(),
    builderFactory: TestBasic,
    componentClass: TestBasicComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestBasic');

abstract class _$TestBasicPropsAccessorsMixin implements _$TestBasicProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestBasicProps = const PropsMeta(
  fields: _$TestBasicPropsAccessorsMixin.$props,
  keys: _$TestBasicPropsAccessorsMixin.$propKeys,
);

class TestBasicProps extends _$TestBasicProps
    with _$TestBasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestBasicProps;
}

_$$TestBasicProps _$TestBasic([Map backingProps]) => backingProps == null
    ? new _$$TestBasicProps$JsMap(new JsBackedMap())
    : new _$$TestBasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestBasicProps extends _$TestBasicProps
    with _$TestBasicPropsAccessorsMixin
    implements TestBasicProps {
  _$$TestBasicProps._();
  factory _$$TestBasicProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestBasicProps$PlainMap(backingMap);
    } else {
      return new _$$TestBasicProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TestBasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestBasicProps.';
}

class _$$TestBasicProps$PlainMap extends _$$TestBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestBasicProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestBasicProps$JsMap extends _$$TestBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestBasicProps$JsMap(JsBackedMap backingMap)
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
class _$TestBasicComponent extends TestBasicComponent {
  @override
  _$$TestBasicProps typedPropsFactory(Map backingMap) =>
      new _$$TestBasicProps(backingMap);
  @override
  _$$TestBasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestBasicProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestBasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestBasicProps
  ];
  _$$TestBasicProps$JsMap _cachedTypedProps;
  @override
  _$$TestBasicProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestHandlerLifecycleComponentFactory = registerComponent(
    () => new _$TestHandlerLifecycleComponent(),
    builderFactory: TestHandlerLifecycle,
    componentClass: TestHandlerLifecycleComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestHandlerLifecycle');

abstract class _$TestHandlerLifecyclePropsAccessorsMixin
    implements _$TestHandlerLifecycleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestHandlerLifecycleProps = const PropsMeta(
  fields: _$TestHandlerLifecyclePropsAccessorsMixin.$props,
  keys: _$TestHandlerLifecyclePropsAccessorsMixin.$propKeys,
);

class TestHandlerLifecycleProps extends _$TestHandlerLifecycleProps
    with _$TestHandlerLifecyclePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestHandlerLifecycleProps;
}

_$$TestHandlerLifecycleProps _$TestHandlerLifecycle([Map backingProps]) =>
    backingProps == null
        ? new _$$TestHandlerLifecycleProps$JsMap(new JsBackedMap())
        : new _$$TestHandlerLifecycleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestHandlerLifecycleProps extends _$TestHandlerLifecycleProps
    with _$TestHandlerLifecyclePropsAccessorsMixin
    implements TestHandlerLifecycleProps {
  _$$TestHandlerLifecycleProps._();
  factory _$$TestHandlerLifecycleProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestHandlerLifecycleProps$PlainMap(backingMap);
    } else {
      return new _$$TestHandlerLifecycleProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestHandlerLifecycleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestHandlerLifecycleProps.';
}

class _$$TestHandlerLifecycleProps$PlainMap
    extends _$$TestHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestHandlerLifecycleProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestHandlerLifecycleProps$JsMap extends _$$TestHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestHandlerLifecycleProps$JsMap(JsBackedMap backingMap)
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
class _$TestHandlerLifecycleComponent extends TestHandlerLifecycleComponent {
  @override
  _$$TestHandlerLifecycleProps typedPropsFactory(Map backingMap) =>
      new _$$TestHandlerLifecycleProps(backingMap);
  @override
  _$$TestHandlerLifecycleProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestHandlerLifecycleProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestHandlerLifecycleProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestHandlerLifecycleProps
  ];
  _$$TestHandlerLifecycleProps$JsMap _cachedTypedProps;
  @override
  _$$TestHandlerLifecycleProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestHandlerPrecedenceComponentFactory = registerComponent(
    () => new _$TestHandlerPrecedenceComponent(),
    builderFactory: TestHandlerPrecedence,
    componentClass: TestHandlerPrecedenceComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestHandlerPrecedence');

abstract class _$TestHandlerPrecedencePropsAccessorsMixin
    implements _$TestHandlerPrecedenceProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestHandlerPrecedenceProps = const PropsMeta(
  fields: _$TestHandlerPrecedencePropsAccessorsMixin.$props,
  keys: _$TestHandlerPrecedencePropsAccessorsMixin.$propKeys,
);

class TestHandlerPrecedenceProps extends _$TestHandlerPrecedenceProps
    with _$TestHandlerPrecedencePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestHandlerPrecedenceProps;
}

_$$TestHandlerPrecedenceProps _$TestHandlerPrecedence([Map backingProps]) =>
    backingProps == null
        ? new _$$TestHandlerPrecedenceProps$JsMap(new JsBackedMap())
        : new _$$TestHandlerPrecedenceProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestHandlerPrecedenceProps extends _$TestHandlerPrecedenceProps
    with _$TestHandlerPrecedencePropsAccessorsMixin
    implements TestHandlerPrecedenceProps {
  _$$TestHandlerPrecedenceProps._();
  factory _$$TestHandlerPrecedenceProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestHandlerPrecedenceProps$PlainMap(backingMap);
    } else {
      return new _$$TestHandlerPrecedenceProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestHandlerPrecedenceComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestHandlerPrecedenceProps.';
}

class _$$TestHandlerPrecedenceProps$PlainMap
    extends _$$TestHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestHandlerPrecedenceProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestHandlerPrecedenceProps$JsMap
    extends _$$TestHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestHandlerPrecedenceProps$JsMap(JsBackedMap backingMap)
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
class _$TestHandlerPrecedenceComponent extends TestHandlerPrecedenceComponent {
  @override
  _$$TestHandlerPrecedenceProps typedPropsFactory(Map backingMap) =>
      new _$$TestHandlerPrecedenceProps(backingMap);
  @override
  _$$TestHandlerPrecedenceProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestHandlerPrecedenceProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestHandlerPrecedenceProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestHandlerPrecedenceProps
  ];
  _$$TestHandlerPrecedenceProps$JsMap _cachedTypedProps;
  @override
  _$$TestHandlerPrecedenceProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestPropValidationComponentFactory = registerComponent(
    () => new _$TestPropValidationComponent(),
    builderFactory: TestPropValidation,
    componentClass: TestPropValidationComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestPropValidation');

abstract class _$TestPropValidationPropsAccessorsMixin
    implements _$TestPropValidationProps {
  @override
  Map get props;

  /// Go to [_$TestPropValidationProps.required] to see the source code for this prop
  @override
  @requiredProp
  String get required =>
      props[_$key__required___$TestPropValidationProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TestPropValidationProps.required] to see the source code for this prop
  @override
  @requiredProp
  set required(String value) =>
      props[_$key__required___$TestPropValidationProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required___$TestPropValidationProps =
      const PropDescriptor(_$key__required___$TestPropValidationProps,
          isRequired: true);
  static const String _$key__required___$TestPropValidationProps =
      'TestPropValidationProps.required';

  static const List<PropDescriptor> $props = const [
    _$prop__required___$TestPropValidationProps
  ];
  static const List<String> $propKeys = const [
    _$key__required___$TestPropValidationProps
  ];
}

const PropsMeta _$metaForTestPropValidationProps = const PropsMeta(
  fields: _$TestPropValidationPropsAccessorsMixin.$props,
  keys: _$TestPropValidationPropsAccessorsMixin.$propKeys,
);

class TestPropValidationProps extends _$TestPropValidationProps
    with _$TestPropValidationPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestPropValidationProps;
}

_$$TestPropValidationProps _$TestPropValidation([Map backingProps]) =>
    backingProps == null
        ? new _$$TestPropValidationProps$JsMap(new JsBackedMap())
        : new _$$TestPropValidationProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestPropValidationProps extends _$TestPropValidationProps
    with _$TestPropValidationPropsAccessorsMixin
    implements TestPropValidationProps {
  _$$TestPropValidationProps._();
  factory _$$TestPropValidationProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestPropValidationProps$PlainMap(backingMap);
    } else {
      return new _$$TestPropValidationProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestPropValidationComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestPropValidationProps.';
}

class _$$TestPropValidationProps$PlainMap extends _$$TestPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestPropValidationProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestPropValidationProps$JsMap extends _$$TestPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestPropValidationProps$JsMap(JsBackedMap backingMap)
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
class _$TestPropValidationComponent extends TestPropValidationComponent {
  @override
  _$$TestPropValidationProps typedPropsFactory(Map backingMap) =>
      new _$$TestPropValidationProps(backingMap);
  @override
  _$$TestPropValidationProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestPropValidationProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestPropValidationProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestPropValidationProps
  ];
  _$$TestPropValidationProps$JsMap _cachedTypedProps;
  @override
  _$$TestPropValidationProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestRedrawOnComponentFactory = registerComponent(
    () => new _$TestRedrawOnComponent(),
    builderFactory: TestRedrawOn,
    componentClass: TestRedrawOnComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestRedrawOn');

abstract class _$TestRedrawOnPropsAccessorsMixin
    implements _$TestRedrawOnProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestRedrawOnProps = const PropsMeta(
  fields: _$TestRedrawOnPropsAccessorsMixin.$props,
  keys: _$TestRedrawOnPropsAccessorsMixin.$propKeys,
);

class TestRedrawOnProps extends _$TestRedrawOnProps
    with _$TestRedrawOnPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestRedrawOnProps;
}

_$$TestRedrawOnProps _$TestRedrawOn([Map backingProps]) => backingProps == null
    ? new _$$TestRedrawOnProps$JsMap(new JsBackedMap())
    : new _$$TestRedrawOnProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestRedrawOnProps extends _$TestRedrawOnProps
    with _$TestRedrawOnPropsAccessorsMixin
    implements TestRedrawOnProps {
  _$$TestRedrawOnProps._();
  factory _$$TestRedrawOnProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestRedrawOnProps$PlainMap(backingMap);
    } else {
      return new _$$TestRedrawOnProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestRedrawOnComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestRedrawOnProps.';
}

class _$$TestRedrawOnProps$PlainMap extends _$$TestRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestRedrawOnProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestRedrawOnProps$JsMap extends _$$TestRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestRedrawOnProps$JsMap(JsBackedMap backingMap)
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
class _$TestRedrawOnComponent extends TestRedrawOnComponent {
  @override
  _$$TestRedrawOnProps typedPropsFactory(Map backingMap) =>
      new _$$TestRedrawOnProps(backingMap);
  @override
  _$$TestRedrawOnProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestRedrawOnProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestRedrawOnProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestRedrawOnProps
  ];
  _$$TestRedrawOnProps$JsMap _cachedTypedProps;
  @override
  _$$TestRedrawOnProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStoreHandlersComponentFactory = registerComponent(
    () => new _$TestStoreHandlersComponent(),
    builderFactory: TestStoreHandlers,
    componentClass: TestStoreHandlersComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStoreHandlers');

abstract class _$TestStoreHandlersPropsAccessorsMixin
    implements _$TestStoreHandlersProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStoreHandlersProps = const PropsMeta(
  fields: _$TestStoreHandlersPropsAccessorsMixin.$props,
  keys: _$TestStoreHandlersPropsAccessorsMixin.$propKeys,
);

class TestStoreHandlersProps extends _$TestStoreHandlersProps
    with _$TestStoreHandlersPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStoreHandlersProps;
}

_$$TestStoreHandlersProps _$TestStoreHandlers([Map backingProps]) =>
    backingProps == null
        ? new _$$TestStoreHandlersProps$JsMap(new JsBackedMap())
        : new _$$TestStoreHandlersProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStoreHandlersProps extends _$TestStoreHandlersProps
    with _$TestStoreHandlersPropsAccessorsMixin
    implements TestStoreHandlersProps {
  _$$TestStoreHandlersProps._();
  factory _$$TestStoreHandlersProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStoreHandlersProps$PlainMap(backingMap);
    } else {
      return new _$$TestStoreHandlersProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStoreHandlersComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStoreHandlersProps.';
}

class _$$TestStoreHandlersProps$PlainMap extends _$$TestStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStoreHandlersProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStoreHandlersProps$JsMap extends _$$TestStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStoreHandlersProps$JsMap(JsBackedMap backingMap)
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
class _$TestStoreHandlersComponent extends TestStoreHandlersComponent {
  @override
  _$$TestStoreHandlersProps typedPropsFactory(Map backingMap) =>
      new _$$TestStoreHandlersProps(backingMap);
  @override
  _$$TestStoreHandlersProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestStoreHandlersProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStoreHandlersProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStoreHandlersProps
  ];
  _$$TestStoreHandlersProps$JsMap _cachedTypedProps;
  @override
  _$$TestStoreHandlersProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulBasicComponentFactory = registerComponent(
    () => new _$TestStatefulBasicComponent(),
    builderFactory: TestStatefulBasic,
    componentClass: TestStatefulBasicComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulBasic');

abstract class _$TestStatefulBasicPropsAccessorsMixin
    implements _$TestStatefulBasicProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStatefulBasicProps = const PropsMeta(
  fields: _$TestStatefulBasicPropsAccessorsMixin.$props,
  keys: _$TestStatefulBasicPropsAccessorsMixin.$propKeys,
);

class TestStatefulBasicProps extends _$TestStatefulBasicProps
    with _$TestStatefulBasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulBasicProps;
}

_$$TestStatefulBasicProps _$TestStatefulBasic([Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulBasicProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulBasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulBasicProps extends _$TestStatefulBasicProps
    with _$TestStatefulBasicPropsAccessorsMixin
    implements TestStatefulBasicProps {
  _$$TestStatefulBasicProps._();
  factory _$$TestStatefulBasicProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulBasicProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulBasicProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulBasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulBasicProps.';
}

class _$$TestStatefulBasicProps$PlainMap extends _$$TestStatefulBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulBasicProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulBasicProps$JsMap extends _$$TestStatefulBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulBasicProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulBasicStateAccessorsMixin
    implements _$TestStatefulBasicState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulBasicState = const StateMeta(
  fields: _$TestStatefulBasicStateAccessorsMixin.$state,
  keys: _$TestStatefulBasicStateAccessorsMixin.$stateKeys,
);

class TestStatefulBasicState extends _$TestStatefulBasicState
    with _$TestStatefulBasicStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulBasicState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulBasicState extends _$TestStatefulBasicState
    with _$TestStatefulBasicStateAccessorsMixin
    implements TestStatefulBasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulBasicState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulBasicComponent extends TestStatefulBasicComponent {
  @override
  _$$TestStatefulBasicProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulBasicProps(backingMap);
  @override
  _$$TestStatefulBasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TestStatefulBasicProps$JsMap(backingMap);

  @override
  _$$TestStatefulBasicState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulBasicState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulBasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulBasicProps
  ];
  _$$TestStatefulBasicProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulBasicProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulHandlerLifecycleComponentFactory = registerComponent(
    () => new _$TestStatefulHandlerLifecycleComponent(),
    builderFactory: TestStatefulHandlerLifecycle,
    componentClass: TestStatefulHandlerLifecycleComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulHandlerLifecycle');

abstract class _$TestStatefulHandlerLifecyclePropsAccessorsMixin
    implements _$TestStatefulHandlerLifecycleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStatefulHandlerLifecycleProps = const PropsMeta(
  fields: _$TestStatefulHandlerLifecyclePropsAccessorsMixin.$props,
  keys: _$TestStatefulHandlerLifecyclePropsAccessorsMixin.$propKeys,
);

class TestStatefulHandlerLifecycleProps
    extends _$TestStatefulHandlerLifecycleProps
    with _$TestStatefulHandlerLifecyclePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulHandlerLifecycleProps;
}

_$$TestStatefulHandlerLifecycleProps _$TestStatefulHandlerLifecycle(
        [Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulHandlerLifecycleProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulHandlerLifecycleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulHandlerLifecycleProps
    extends _$TestStatefulHandlerLifecycleProps
    with _$TestStatefulHandlerLifecyclePropsAccessorsMixin
    implements TestStatefulHandlerLifecycleProps {
  _$$TestStatefulHandlerLifecycleProps._();
  factory _$$TestStatefulHandlerLifecycleProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulHandlerLifecycleProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulHandlerLifecycleProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulHandlerLifecycleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulHandlerLifecycleProps.';
}

class _$$TestStatefulHandlerLifecycleProps$PlainMap
    extends _$$TestStatefulHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerLifecycleProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulHandlerLifecycleProps$JsMap
    extends _$$TestStatefulHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerLifecycleProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulHandlerLifecycleStateAccessorsMixin
    implements _$TestStatefulHandlerLifecycleState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulHandlerLifecycleState = const StateMeta(
  fields: _$TestStatefulHandlerLifecycleStateAccessorsMixin.$state,
  keys: _$TestStatefulHandlerLifecycleStateAccessorsMixin.$stateKeys,
);

class TestStatefulHandlerLifecycleState
    extends _$TestStatefulHandlerLifecycleState
    with _$TestStatefulHandlerLifecycleStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulHandlerLifecycleState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulHandlerLifecycleState
    extends _$TestStatefulHandlerLifecycleState
    with _$TestStatefulHandlerLifecycleStateAccessorsMixin
    implements TestStatefulHandlerLifecycleState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerLifecycleState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulHandlerLifecycleComponent
    extends TestStatefulHandlerLifecycleComponent {
  @override
  _$$TestStatefulHandlerLifecycleProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulHandlerLifecycleProps(backingMap);
  @override
  _$$TestStatefulHandlerLifecycleProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestStatefulHandlerLifecycleProps$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerLifecycleState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulHandlerLifecycleState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulHandlerLifecycleProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulHandlerLifecycleProps
  ];
  _$$TestStatefulHandlerLifecycleProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulHandlerLifecycleProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulHandlerPrecedenceComponentFactory = registerComponent(
    () => new _$TestStatefulHandlerPrecedenceComponent(),
    builderFactory: TestStatefulHandlerPrecedence,
    componentClass: TestStatefulHandlerPrecedenceComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulHandlerPrecedence');

abstract class _$TestStatefulHandlerPrecedencePropsAccessorsMixin
    implements _$TestStatefulHandlerPrecedenceProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStatefulHandlerPrecedenceProps = const PropsMeta(
  fields: _$TestStatefulHandlerPrecedencePropsAccessorsMixin.$props,
  keys: _$TestStatefulHandlerPrecedencePropsAccessorsMixin.$propKeys,
);

class TestStatefulHandlerPrecedenceProps
    extends _$TestStatefulHandlerPrecedenceProps
    with _$TestStatefulHandlerPrecedencePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulHandlerPrecedenceProps;
}

_$$TestStatefulHandlerPrecedenceProps _$TestStatefulHandlerPrecedence(
        [Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulHandlerPrecedenceProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulHandlerPrecedenceProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulHandlerPrecedenceProps
    extends _$TestStatefulHandlerPrecedenceProps
    with _$TestStatefulHandlerPrecedencePropsAccessorsMixin
    implements TestStatefulHandlerPrecedenceProps {
  _$$TestStatefulHandlerPrecedenceProps._();
  factory _$$TestStatefulHandlerPrecedenceProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulHandlerPrecedenceProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulHandlerPrecedenceProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulHandlerPrecedenceComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulHandlerPrecedenceProps.';
}

class _$$TestStatefulHandlerPrecedenceProps$PlainMap
    extends _$$TestStatefulHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerPrecedenceProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulHandlerPrecedenceProps$JsMap
    extends _$$TestStatefulHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerPrecedenceProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulHandlerPrecedenceStateAccessorsMixin
    implements _$TestStatefulHandlerPrecedenceState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulHandlerPrecedenceState = const StateMeta(
  fields: _$TestStatefulHandlerPrecedenceStateAccessorsMixin.$state,
  keys: _$TestStatefulHandlerPrecedenceStateAccessorsMixin.$stateKeys,
);

class TestStatefulHandlerPrecedenceState
    extends _$TestStatefulHandlerPrecedenceState
    with _$TestStatefulHandlerPrecedenceStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulHandlerPrecedenceState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulHandlerPrecedenceState
    extends _$TestStatefulHandlerPrecedenceState
    with _$TestStatefulHandlerPrecedenceStateAccessorsMixin
    implements TestStatefulHandlerPrecedenceState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulHandlerPrecedenceState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulHandlerPrecedenceComponent
    extends TestStatefulHandlerPrecedenceComponent {
  @override
  _$$TestStatefulHandlerPrecedenceProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulHandlerPrecedenceProps(backingMap);
  @override
  _$$TestStatefulHandlerPrecedenceProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestStatefulHandlerPrecedenceProps$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerPrecedenceState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulHandlerPrecedenceState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulHandlerPrecedenceProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulHandlerPrecedenceProps
  ];
  _$$TestStatefulHandlerPrecedenceProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulHandlerPrecedenceProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulPropValidationComponentFactory = registerComponent(
    () => new _$TestStatefulPropValidationComponent(),
    builderFactory: TestStatefulPropValidation,
    componentClass: TestStatefulPropValidationComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulPropValidation');

abstract class _$TestStatefulPropValidationPropsAccessorsMixin
    implements _$TestStatefulPropValidationProps {
  @override
  Map get props;

  /// Go to [_$TestStatefulPropValidationProps.required] to see the source code for this prop
  @override
  @override
  @requiredProp
  String get required =>
      props[_$key__required___$TestStatefulPropValidationProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TestStatefulPropValidationProps.required] to see the source code for this prop
  @override
  @override
  @requiredProp
  set required(String value) =>
      props[_$key__required___$TestStatefulPropValidationProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__required___$TestStatefulPropValidationProps =
      const PropDescriptor(_$key__required___$TestStatefulPropValidationProps,
          isRequired: true);
  static const String _$key__required___$TestStatefulPropValidationProps =
      'TestStatefulPropValidationProps.required';

  static const List<PropDescriptor> $props = const [
    _$prop__required___$TestStatefulPropValidationProps
  ];
  static const List<String> $propKeys = const [
    _$key__required___$TestStatefulPropValidationProps
  ];
}

const PropsMeta _$metaForTestStatefulPropValidationProps = const PropsMeta(
  fields: _$TestStatefulPropValidationPropsAccessorsMixin.$props,
  keys: _$TestStatefulPropValidationPropsAccessorsMixin.$propKeys,
);

class TestStatefulPropValidationProps extends _$TestStatefulPropValidationProps
    with _$TestStatefulPropValidationPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulPropValidationProps;
}

_$$TestStatefulPropValidationProps _$TestStatefulPropValidation(
        [Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulPropValidationProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulPropValidationProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulPropValidationProps
    extends _$TestStatefulPropValidationProps
    with _$TestStatefulPropValidationPropsAccessorsMixin
    implements TestStatefulPropValidationProps {
  _$$TestStatefulPropValidationProps._();
  factory _$$TestStatefulPropValidationProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulPropValidationProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulPropValidationProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulPropValidationComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulPropValidationProps.';
}

class _$$TestStatefulPropValidationProps$PlainMap
    extends _$$TestStatefulPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulPropValidationProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulPropValidationProps$JsMap
    extends _$$TestStatefulPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulPropValidationProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulPropValidationStateAccessorsMixin
    implements _$TestStatefulPropValidationState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulPropValidationState = const StateMeta(
  fields: _$TestStatefulPropValidationStateAccessorsMixin.$state,
  keys: _$TestStatefulPropValidationStateAccessorsMixin.$stateKeys,
);

class TestStatefulPropValidationState extends _$TestStatefulPropValidationState
    with _$TestStatefulPropValidationStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulPropValidationState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulPropValidationState
    extends _$TestStatefulPropValidationState
    with _$TestStatefulPropValidationStateAccessorsMixin
    implements TestStatefulPropValidationState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulPropValidationState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulPropValidationComponent
    extends TestStatefulPropValidationComponent {
  @override
  _$$TestStatefulPropValidationProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulPropValidationProps(backingMap);
  @override
  _$$TestStatefulPropValidationProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestStatefulPropValidationProps$JsMap(backingMap);

  @override
  _$$TestStatefulPropValidationState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulPropValidationState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulPropValidationProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulPropValidationProps
  ];
  _$$TestStatefulPropValidationProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulPropValidationProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulRedrawOnComponentFactory = registerComponent(
    () => new _$TestStatefulRedrawOnComponent(),
    builderFactory: TestStatefulRedrawOn,
    componentClass: TestStatefulRedrawOnComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulRedrawOn');

abstract class _$TestStatefulRedrawOnPropsAccessorsMixin
    implements _$TestStatefulRedrawOnProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStatefulRedrawOnProps = const PropsMeta(
  fields: _$TestStatefulRedrawOnPropsAccessorsMixin.$props,
  keys: _$TestStatefulRedrawOnPropsAccessorsMixin.$propKeys,
);

class TestStatefulRedrawOnProps extends _$TestStatefulRedrawOnProps
    with _$TestStatefulRedrawOnPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulRedrawOnProps;
}

_$$TestStatefulRedrawOnProps _$TestStatefulRedrawOn([Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulRedrawOnProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulRedrawOnProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulRedrawOnProps extends _$TestStatefulRedrawOnProps
    with _$TestStatefulRedrawOnPropsAccessorsMixin
    implements TestStatefulRedrawOnProps {
  _$$TestStatefulRedrawOnProps._();
  factory _$$TestStatefulRedrawOnProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulRedrawOnProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulRedrawOnProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulRedrawOnComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulRedrawOnProps.';
}

class _$$TestStatefulRedrawOnProps$PlainMap
    extends _$$TestStatefulRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulRedrawOnProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulRedrawOnProps$JsMap extends _$$TestStatefulRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulRedrawOnProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulRedrawOnStateAccessorsMixin
    implements _$TestStatefulRedrawOnState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulRedrawOnState = const StateMeta(
  fields: _$TestStatefulRedrawOnStateAccessorsMixin.$state,
  keys: _$TestStatefulRedrawOnStateAccessorsMixin.$stateKeys,
);

class TestStatefulRedrawOnState extends _$TestStatefulRedrawOnState
    with _$TestStatefulRedrawOnStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulRedrawOnState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulRedrawOnState extends _$TestStatefulRedrawOnState
    with _$TestStatefulRedrawOnStateAccessorsMixin
    implements TestStatefulRedrawOnState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulRedrawOnState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulRedrawOnComponent extends TestStatefulRedrawOnComponent {
  @override
  _$$TestStatefulRedrawOnProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulRedrawOnProps(backingMap);
  @override
  _$$TestStatefulRedrawOnProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestStatefulRedrawOnProps$JsMap(backingMap);

  @override
  _$$TestStatefulRedrawOnState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulRedrawOnState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulRedrawOnProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulRedrawOnProps
  ];
  _$$TestStatefulRedrawOnProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulRedrawOnProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulStoreHandlersComponentFactory = registerComponent(
    () => new _$TestStatefulStoreHandlersComponent(),
    builderFactory: TestStatefulStoreHandlers,
    componentClass: TestStatefulStoreHandlersComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'TestStatefulStoreHandlers');

abstract class _$TestStatefulStoreHandlersPropsAccessorsMixin
    implements _$TestStatefulStoreHandlersProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForTestStatefulStoreHandlersProps = const PropsMeta(
  fields: _$TestStatefulStoreHandlersPropsAccessorsMixin.$props,
  keys: _$TestStatefulStoreHandlersPropsAccessorsMixin.$propKeys,
);

class TestStatefulStoreHandlersProps extends _$TestStatefulStoreHandlersProps
    with _$TestStatefulStoreHandlersPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulStoreHandlersProps;
}

_$$TestStatefulStoreHandlersProps _$TestStatefulStoreHandlers(
        [Map backingProps]) =>
    backingProps == null
        ? new _$$TestStatefulStoreHandlersProps$JsMap(new JsBackedMap())
        : new _$$TestStatefulStoreHandlersProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestStatefulStoreHandlersProps extends _$TestStatefulStoreHandlersProps
    with _$TestStatefulStoreHandlersPropsAccessorsMixin
    implements TestStatefulStoreHandlersProps {
  _$$TestStatefulStoreHandlersProps._();
  factory _$$TestStatefulStoreHandlersProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$TestStatefulStoreHandlersProps$PlainMap(backingMap);
    } else {
      return new _$$TestStatefulStoreHandlersProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $TestStatefulStoreHandlersComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulStoreHandlersProps.';
}

class _$$TestStatefulStoreHandlersProps$PlainMap
    extends _$$TestStatefulStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulStoreHandlersProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

class _$$TestStatefulStoreHandlersProps$JsMap
    extends _$$TestStatefulStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulStoreHandlersProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TestStatefulStoreHandlersStateAccessorsMixin
    implements _$TestStatefulStoreHandlersState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForTestStatefulStoreHandlersState = const StateMeta(
  fields: _$TestStatefulStoreHandlersStateAccessorsMixin.$state,
  keys: _$TestStatefulStoreHandlersStateAccessorsMixin.$stateKeys,
);

class TestStatefulStoreHandlersState extends _$TestStatefulStoreHandlersState
    with _$TestStatefulStoreHandlersStateAccessorsMixin {
  static const StateMeta meta = _$metaForTestStatefulStoreHandlersState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$TestStatefulStoreHandlersState extends _$TestStatefulStoreHandlersState
    with _$TestStatefulStoreHandlersStateAccessorsMixin
    implements TestStatefulStoreHandlersState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$TestStatefulStoreHandlersState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulStoreHandlersComponent
    extends TestStatefulStoreHandlersComponent {
  @override
  _$$TestStatefulStoreHandlersProps typedPropsFactory(Map backingMap) =>
      new _$$TestStatefulStoreHandlersProps(backingMap);
  @override
  _$$TestStatefulStoreHandlersProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TestStatefulStoreHandlersProps$JsMap(backingMap);

  @override
  _$$TestStatefulStoreHandlersState typedStateFactory(Map backingMap) =>
      new _$$TestStatefulStoreHandlersState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestStatefulStoreHandlersProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulStoreHandlersProps
  ];
  _$$TestStatefulStoreHandlersProps$JsMap _cachedTypedProps;
  @override
  _$$TestStatefulStoreHandlersProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
