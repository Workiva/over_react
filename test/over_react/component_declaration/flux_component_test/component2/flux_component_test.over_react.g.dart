// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'flux_component_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestBasicComponentFactory = registerComponent2(
  () => _$TestBasicComponent(),
  builderFactory: _$TestBasic,
  componentClass: TestBasicComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestBasicPropsAccessorsMixin implements _$TestBasicProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestBasicProps = PropsMeta(
  fields: _$TestBasicPropsAccessorsMixin.$props,
  keys: _$TestBasicPropsAccessorsMixin.$propKeys,
);

class TestBasicProps extends _$TestBasicProps
    with _$TestBasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestBasicProps;
}

_$$TestBasicProps _$TestBasic([Map? backingProps]) => backingProps == null
    ? _$$TestBasicProps$JsMap(JsBackedMap())
    : _$$TestBasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestBasicProps extends _$TestBasicProps
    with _$TestBasicPropsAccessorsMixin
    implements TestBasicProps {
  _$$TestBasicProps._();

  factory _$$TestBasicProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestBasicProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestBasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestBasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestBasicProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestBasicProps(
          accessMap, (map) => _$$TestBasicProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestBasicProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestBasicProps$PlainMap extends _$$TestBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestBasicProps$PlainMap(Map? backingMap)
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
class _$$TestBasicProps$JsMap extends _$$TestBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestBasicProps$JsMap(JsBackedMap? backingMap)
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
class _$TestBasicComponent extends TestBasicComponent {
  late _$$TestBasicProps$JsMap _cachedTypedProps;

  @override
  _$$TestBasicProps$JsMap get props => _cachedTypedProps;

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
  _$$TestBasicProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestBasicProps$JsMap(backingMap);

  @override
  _$$TestBasicProps typedPropsFactory(Map? backingMap) =>
      _$$TestBasicProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestBasic';

  /// The default consumed props, taken from _$TestBasicProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestBasicProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestHandlerLifecycleComponentFactory = registerComponent2(
  () => _$TestHandlerLifecycleComponent(),
  builderFactory: _$TestHandlerLifecycle,
  componentClass: TestHandlerLifecycleComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestHandlerLifecyclePropsAccessorsMixin
    implements _$TestHandlerLifecycleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestHandlerLifecycleProps = PropsMeta(
  fields: _$TestHandlerLifecyclePropsAccessorsMixin.$props,
  keys: _$TestHandlerLifecyclePropsAccessorsMixin.$propKeys,
);

class TestHandlerLifecycleProps extends _$TestHandlerLifecycleProps
    with _$TestHandlerLifecyclePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestHandlerLifecycleProps;
}

_$$TestHandlerLifecycleProps _$TestHandlerLifecycle([Map? backingProps]) =>
    backingProps == null
        ? _$$TestHandlerLifecycleProps$JsMap(JsBackedMap())
        : _$$TestHandlerLifecycleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestHandlerLifecycleProps extends _$TestHandlerLifecycleProps
    with _$TestHandlerLifecyclePropsAccessorsMixin
    implements TestHandlerLifecycleProps {
  _$$TestHandlerLifecycleProps._();

  factory _$$TestHandlerLifecycleProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestHandlerLifecycleProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestHandlerLifecycleProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestHandlerLifecycleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestHandlerLifecycleProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestHandlerLifecycleProps(
          accessMap, (map) => _$$TestHandlerLifecycleProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestHandlerLifecycleProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestHandlerLifecycleProps$PlainMap
    extends _$$TestHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestHandlerLifecycleProps$PlainMap(Map? backingMap)
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
class _$$TestHandlerLifecycleProps$JsMap extends _$$TestHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestHandlerLifecycleProps$JsMap(JsBackedMap? backingMap)
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
class _$TestHandlerLifecycleComponent extends TestHandlerLifecycleComponent {
  late _$$TestHandlerLifecycleProps$JsMap _cachedTypedProps;

  @override
  _$$TestHandlerLifecycleProps$JsMap get props => _cachedTypedProps;

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
  _$$TestHandlerLifecycleProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestHandlerLifecycleProps$JsMap(backingMap);

  @override
  _$$TestHandlerLifecycleProps typedPropsFactory(Map? backingMap) =>
      _$$TestHandlerLifecycleProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestHandlerLifecycle';

  /// The default consumed props, taken from _$TestHandlerLifecycleProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestHandlerLifecycleProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestHandlerPrecedenceComponentFactory = registerComponent2(
  () => _$TestHandlerPrecedenceComponent(),
  builderFactory: _$TestHandlerPrecedence,
  componentClass: TestHandlerPrecedenceComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestHandlerPrecedencePropsAccessorsMixin
    implements _$TestHandlerPrecedenceProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestHandlerPrecedenceProps = PropsMeta(
  fields: _$TestHandlerPrecedencePropsAccessorsMixin.$props,
  keys: _$TestHandlerPrecedencePropsAccessorsMixin.$propKeys,
);

class TestHandlerPrecedenceProps extends _$TestHandlerPrecedenceProps
    with _$TestHandlerPrecedencePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestHandlerPrecedenceProps;
}

_$$TestHandlerPrecedenceProps _$TestHandlerPrecedence([Map? backingProps]) =>
    backingProps == null
        ? _$$TestHandlerPrecedenceProps$JsMap(JsBackedMap())
        : _$$TestHandlerPrecedenceProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestHandlerPrecedenceProps
    extends _$TestHandlerPrecedenceProps
    with _$TestHandlerPrecedencePropsAccessorsMixin
    implements TestHandlerPrecedenceProps {
  _$$TestHandlerPrecedenceProps._();

  factory _$$TestHandlerPrecedenceProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestHandlerPrecedenceProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestHandlerPrecedenceProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestHandlerPrecedenceComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestHandlerPrecedenceProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestHandlerPrecedenceProps(
          accessMap, (map) => _$$TestHandlerPrecedenceProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestHandlerPrecedenceProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestHandlerPrecedenceProps$PlainMap
    extends _$$TestHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestHandlerPrecedenceProps$PlainMap(Map? backingMap)
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
class _$$TestHandlerPrecedenceProps$JsMap
    extends _$$TestHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestHandlerPrecedenceProps$JsMap(JsBackedMap? backingMap)
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
class _$TestHandlerPrecedenceComponent extends TestHandlerPrecedenceComponent {
  late _$$TestHandlerPrecedenceProps$JsMap _cachedTypedProps;

  @override
  _$$TestHandlerPrecedenceProps$JsMap get props => _cachedTypedProps;

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
  _$$TestHandlerPrecedenceProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestHandlerPrecedenceProps$JsMap(backingMap);

  @override
  _$$TestHandlerPrecedenceProps typedPropsFactory(Map? backingMap) =>
      _$$TestHandlerPrecedenceProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestHandlerPrecedence';

  /// The default consumed props, taken from _$TestHandlerPrecedenceProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestHandlerPrecedenceProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestPropValidationComponentFactory = registerComponent2(
  () => _$TestPropValidationComponent(),
  builderFactory: _$TestPropValidation,
  componentClass: TestPropValidationComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestPropValidationPropsAccessorsMixin
    implements _$TestPropValidationProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TestPropValidationProps.required] -->
  @override
  @requiredProp
  String? get required =>
      (props[_$key__required___$TestPropValidationProps] ?? null) as String?;

  /// <!-- Generated from [_$TestPropValidationProps.required] -->
  @override
  @requiredProp
  set required(String? value) =>
      props[_$key__required___$TestPropValidationProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required___$TestPropValidationProps =
      PropDescriptor(_$key__required___$TestPropValidationProps,
          isRequired: true);
  static const String _$key__required___$TestPropValidationProps =
      'TestPropValidationProps.required';

  static const List<PropDescriptor> $props = [
    _$prop__required___$TestPropValidationProps
  ];
  static const List<String> $propKeys = [
    _$key__required___$TestPropValidationProps
  ];
}

const PropsMeta _$metaForTestPropValidationProps = PropsMeta(
  fields: _$TestPropValidationPropsAccessorsMixin.$props,
  keys: _$TestPropValidationPropsAccessorsMixin.$propKeys,
);

class TestPropValidationProps extends _$TestPropValidationProps
    with _$TestPropValidationPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestPropValidationProps;
}

_$$TestPropValidationProps _$TestPropValidation([Map? backingProps]) =>
    backingProps == null
        ? _$$TestPropValidationProps$JsMap(JsBackedMap())
        : _$$TestPropValidationProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestPropValidationProps extends _$TestPropValidationProps
    with _$TestPropValidationPropsAccessorsMixin
    implements TestPropValidationProps {
  _$$TestPropValidationProps._();

  factory _$$TestPropValidationProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestPropValidationProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestPropValidationProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestPropValidationComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestPropValidationProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestPropValidationProps(
          accessMap, (map) => _$$TestPropValidationProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestPropValidationProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestPropValidationProps$PlainMap extends _$$TestPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestPropValidationProps$PlainMap(Map? backingMap)
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
class _$$TestPropValidationProps$JsMap extends _$$TestPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestPropValidationProps$JsMap(JsBackedMap? backingMap)
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
class _$TestPropValidationComponent extends TestPropValidationComponent {
  late _$$TestPropValidationProps$JsMap _cachedTypedProps;

  @override
  _$$TestPropValidationProps$JsMap get props => _cachedTypedProps;

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
  _$$TestPropValidationProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestPropValidationProps$JsMap(backingMap);

  @override
  _$$TestPropValidationProps typedPropsFactory(Map? backingMap) =>
      _$$TestPropValidationProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestPropValidation';

  /// The default consumed props, taken from _$TestPropValidationProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestPropValidationProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestRedrawOnComponentFactory = registerComponent2(
  () => _$TestRedrawOnComponent(),
  builderFactory: _$TestRedrawOn,
  componentClass: TestRedrawOnComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestRedrawOnPropsAccessorsMixin
    implements _$TestRedrawOnProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestRedrawOnProps = PropsMeta(
  fields: _$TestRedrawOnPropsAccessorsMixin.$props,
  keys: _$TestRedrawOnPropsAccessorsMixin.$propKeys,
);

class TestRedrawOnProps extends _$TestRedrawOnProps
    with _$TestRedrawOnPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestRedrawOnProps;
}

_$$TestRedrawOnProps _$TestRedrawOn([Map? backingProps]) => backingProps == null
    ? _$$TestRedrawOnProps$JsMap(JsBackedMap())
    : _$$TestRedrawOnProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestRedrawOnProps extends _$TestRedrawOnProps
    with _$TestRedrawOnPropsAccessorsMixin
    implements TestRedrawOnProps {
  _$$TestRedrawOnProps._();

  factory _$$TestRedrawOnProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestRedrawOnProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestRedrawOnProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestRedrawOnComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestRedrawOnProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestRedrawOnProps(
          accessMap, (map) => _$$TestRedrawOnProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestRedrawOnProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestRedrawOnProps$PlainMap extends _$$TestRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestRedrawOnProps$PlainMap(Map? backingMap)
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
class _$$TestRedrawOnProps$JsMap extends _$$TestRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestRedrawOnProps$JsMap(JsBackedMap? backingMap)
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
class _$TestRedrawOnComponent extends TestRedrawOnComponent {
  late _$$TestRedrawOnProps$JsMap _cachedTypedProps;

  @override
  _$$TestRedrawOnProps$JsMap get props => _cachedTypedProps;

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
  _$$TestRedrawOnProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestRedrawOnProps$JsMap(backingMap);

  @override
  _$$TestRedrawOnProps typedPropsFactory(Map? backingMap) =>
      _$$TestRedrawOnProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestRedrawOn';

  /// The default consumed props, taken from _$TestRedrawOnProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestRedrawOnProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStoreHandlersComponentFactory = registerComponent2(
  () => _$TestStoreHandlersComponent(),
  builderFactory: _$TestStoreHandlers,
  componentClass: TestStoreHandlersComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStoreHandlersPropsAccessorsMixin
    implements _$TestStoreHandlersProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStoreHandlersProps = PropsMeta(
  fields: _$TestStoreHandlersPropsAccessorsMixin.$props,
  keys: _$TestStoreHandlersPropsAccessorsMixin.$propKeys,
);

class TestStoreHandlersProps extends _$TestStoreHandlersProps
    with _$TestStoreHandlersPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStoreHandlersProps;
}

_$$TestStoreHandlersProps _$TestStoreHandlers([Map? backingProps]) =>
    backingProps == null
        ? _$$TestStoreHandlersProps$JsMap(JsBackedMap())
        : _$$TestStoreHandlersProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStoreHandlersProps extends _$TestStoreHandlersProps
    with _$TestStoreHandlersPropsAccessorsMixin
    implements TestStoreHandlersProps {
  _$$TestStoreHandlersProps._();

  factory _$$TestStoreHandlersProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStoreHandlersProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestStoreHandlersProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStoreHandlersComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStoreHandlersProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStoreHandlersProps(
          accessMap, (map) => _$$TestStoreHandlersProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStoreHandlersProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStoreHandlersProps$PlainMap extends _$$TestStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStoreHandlersProps$PlainMap(Map? backingMap)
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
class _$$TestStoreHandlersProps$JsMap extends _$$TestStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStoreHandlersProps$JsMap(JsBackedMap? backingMap)
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
class _$TestStoreHandlersComponent extends TestStoreHandlersComponent {
  late _$$TestStoreHandlersProps$JsMap _cachedTypedProps;

  @override
  _$$TestStoreHandlersProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStoreHandlersProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStoreHandlersProps$JsMap(backingMap);

  @override
  _$$TestStoreHandlersProps typedPropsFactory(Map? backingMap) =>
      _$$TestStoreHandlersProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStoreHandlers';

  /// The default consumed props, taken from _$TestStoreHandlersProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStoreHandlersProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulBasicComponentFactory = registerComponent2(
  () => _$TestStatefulBasicComponent(),
  builderFactory: _$TestStatefulBasic,
  componentClass: TestStatefulBasicComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulBasicPropsAccessorsMixin
    implements _$TestStatefulBasicProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStatefulBasicProps = PropsMeta(
  fields: _$TestStatefulBasicPropsAccessorsMixin.$props,
  keys: _$TestStatefulBasicPropsAccessorsMixin.$propKeys,
);

class TestStatefulBasicProps extends _$TestStatefulBasicProps
    with _$TestStatefulBasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulBasicProps;
}

_$$TestStatefulBasicProps _$TestStatefulBasic([Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulBasicProps$JsMap(JsBackedMap())
        : _$$TestStatefulBasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulBasicProps extends _$TestStatefulBasicProps
    with _$TestStatefulBasicPropsAccessorsMixin
    implements TestStatefulBasicProps {
  _$$TestStatefulBasicProps._();

  factory _$$TestStatefulBasicProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulBasicProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulBasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulBasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulBasicProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulBasicProps(
          accessMap, (map) => _$$TestStatefulBasicProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulBasicProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulBasicProps$PlainMap extends _$$TestStatefulBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulBasicProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulBasicProps$JsMap extends _$$TestStatefulBasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulBasicProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulBasicState = StateMeta(
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
abstract class _$$TestStatefulBasicState extends _$TestStatefulBasicState
    with _$TestStatefulBasicStateAccessorsMixin
    implements TestStatefulBasicState {
  _$$TestStatefulBasicState._();

  factory _$$TestStatefulBasicState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulBasicState$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulBasicState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulBasicState$PlainMap extends _$$TestStatefulBasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulBasicState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulBasicState$JsMap extends _$$TestStatefulBasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulBasicState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulBasicComponent extends TestStatefulBasicComponent {
  late _$$TestStatefulBasicProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulBasicProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulBasicProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulBasicProps$JsMap(backingMap);

  @override
  _$$TestStatefulBasicProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulBasicProps(backingMap);

  late _$$TestStatefulBasicState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulBasicState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulBasicState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulBasicState$JsMap(backingMap);

  @override
  _$$TestStatefulBasicState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulBasicState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulBasic';

  /// The default consumed props, taken from _$TestStatefulBasicProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulBasicProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulHandlerLifecycleComponentFactory = registerComponent2(
  () => _$TestStatefulHandlerLifecycleComponent(),
  builderFactory: _$TestStatefulHandlerLifecycle,
  componentClass: TestStatefulHandlerLifecycleComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulHandlerLifecyclePropsAccessorsMixin
    implements _$TestStatefulHandlerLifecycleProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStatefulHandlerLifecycleProps = PropsMeta(
  fields: _$TestStatefulHandlerLifecyclePropsAccessorsMixin.$props,
  keys: _$TestStatefulHandlerLifecyclePropsAccessorsMixin.$propKeys,
);

class TestStatefulHandlerLifecycleProps
    extends _$TestStatefulHandlerLifecycleProps
    with _$TestStatefulHandlerLifecyclePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulHandlerLifecycleProps;
}

_$$TestStatefulHandlerLifecycleProps _$TestStatefulHandlerLifecycle(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulHandlerLifecycleProps$JsMap(JsBackedMap())
        : _$$TestStatefulHandlerLifecycleProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulHandlerLifecycleProps
    extends _$TestStatefulHandlerLifecycleProps
    with _$TestStatefulHandlerLifecyclePropsAccessorsMixin
    implements TestStatefulHandlerLifecycleProps {
  _$$TestStatefulHandlerLifecycleProps._();

  factory _$$TestStatefulHandlerLifecycleProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulHandlerLifecycleProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulHandlerLifecycleProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulHandlerLifecycleComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulHandlerLifecycleProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulHandlerLifecycleProps(
          accessMap, (map) => _$$TestStatefulHandlerLifecycleProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulHandlerLifecycleProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulHandlerLifecycleProps$PlainMap
    extends _$$TestStatefulHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerLifecycleProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulHandlerLifecycleProps$JsMap
    extends _$$TestStatefulHandlerLifecycleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerLifecycleProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulHandlerLifecycleState = StateMeta(
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
abstract class _$$TestStatefulHandlerLifecycleState
    extends _$TestStatefulHandlerLifecycleState
    with _$TestStatefulHandlerLifecycleStateAccessorsMixin
    implements TestStatefulHandlerLifecycleState {
  _$$TestStatefulHandlerLifecycleState._();

  factory _$$TestStatefulHandlerLifecycleState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulHandlerLifecycleState$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulHandlerLifecycleState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulHandlerLifecycleState$PlainMap
    extends _$$TestStatefulHandlerLifecycleState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerLifecycleState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulHandlerLifecycleState$JsMap
    extends _$$TestStatefulHandlerLifecycleState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerLifecycleState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulHandlerLifecycleComponent
    extends TestStatefulHandlerLifecycleComponent {
  late _$$TestStatefulHandlerLifecycleProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulHandlerLifecycleProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulHandlerLifecycleProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulHandlerLifecycleProps$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerLifecycleProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulHandlerLifecycleProps(backingMap);

  late _$$TestStatefulHandlerLifecycleState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulHandlerLifecycleState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulHandlerLifecycleState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulHandlerLifecycleState$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerLifecycleState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulHandlerLifecycleState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulHandlerLifecycle';

  /// The default consumed props, taken from _$TestStatefulHandlerLifecycleProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulHandlerLifecycleProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulHandlerPrecedenceComponentFactory = registerComponent2(
  () => _$TestStatefulHandlerPrecedenceComponent(),
  builderFactory: _$TestStatefulHandlerPrecedence,
  componentClass: TestStatefulHandlerPrecedenceComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulHandlerPrecedencePropsAccessorsMixin
    implements _$TestStatefulHandlerPrecedenceProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStatefulHandlerPrecedenceProps = PropsMeta(
  fields: _$TestStatefulHandlerPrecedencePropsAccessorsMixin.$props,
  keys: _$TestStatefulHandlerPrecedencePropsAccessorsMixin.$propKeys,
);

class TestStatefulHandlerPrecedenceProps
    extends _$TestStatefulHandlerPrecedenceProps
    with _$TestStatefulHandlerPrecedencePropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulHandlerPrecedenceProps;
}

_$$TestStatefulHandlerPrecedenceProps _$TestStatefulHandlerPrecedence(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulHandlerPrecedenceProps$JsMap(JsBackedMap())
        : _$$TestStatefulHandlerPrecedenceProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulHandlerPrecedenceProps
    extends _$TestStatefulHandlerPrecedenceProps
    with _$TestStatefulHandlerPrecedencePropsAccessorsMixin
    implements TestStatefulHandlerPrecedenceProps {
  _$$TestStatefulHandlerPrecedenceProps._();

  factory _$$TestStatefulHandlerPrecedenceProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulHandlerPrecedenceProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulHandlerPrecedenceProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulHandlerPrecedenceComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulHandlerPrecedenceProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulHandlerPrecedenceProps(
          accessMap, (map) => _$$TestStatefulHandlerPrecedenceProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulHandlerPrecedenceProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulHandlerPrecedenceProps$PlainMap
    extends _$$TestStatefulHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerPrecedenceProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulHandlerPrecedenceProps$JsMap
    extends _$$TestStatefulHandlerPrecedenceProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerPrecedenceProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulHandlerPrecedenceState = StateMeta(
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
abstract class _$$TestStatefulHandlerPrecedenceState
    extends _$TestStatefulHandlerPrecedenceState
    with _$TestStatefulHandlerPrecedenceStateAccessorsMixin
    implements TestStatefulHandlerPrecedenceState {
  _$$TestStatefulHandlerPrecedenceState._();

  factory _$$TestStatefulHandlerPrecedenceState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulHandlerPrecedenceState$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulHandlerPrecedenceState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulHandlerPrecedenceState$PlainMap
    extends _$$TestStatefulHandlerPrecedenceState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerPrecedenceState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulHandlerPrecedenceState$JsMap
    extends _$$TestStatefulHandlerPrecedenceState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulHandlerPrecedenceState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulHandlerPrecedenceComponent
    extends TestStatefulHandlerPrecedenceComponent {
  late _$$TestStatefulHandlerPrecedenceProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulHandlerPrecedenceProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulHandlerPrecedenceProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulHandlerPrecedenceProps$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerPrecedenceProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulHandlerPrecedenceProps(backingMap);

  late _$$TestStatefulHandlerPrecedenceState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulHandlerPrecedenceState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulHandlerPrecedenceState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulHandlerPrecedenceState$JsMap(backingMap);

  @override
  _$$TestStatefulHandlerPrecedenceState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulHandlerPrecedenceState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulHandlerPrecedence';

  /// The default consumed props, taken from _$TestStatefulHandlerPrecedenceProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulHandlerPrecedenceProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulPropValidationComponentFactory = registerComponent2(
  () => _$TestStatefulPropValidationComponent(),
  builderFactory: _$TestStatefulPropValidation,
  componentClass: TestStatefulPropValidationComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulPropValidationPropsAccessorsMixin
    implements _$TestStatefulPropValidationProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TestStatefulPropValidationProps.required] -->
  @override
  @override
  @requiredProp
  String? get required =>
      (props[_$key__required___$TestStatefulPropValidationProps] ?? null)
          as String?;

  /// <!-- Generated from [_$TestStatefulPropValidationProps.required] -->
  @override
  @override
  @requiredProp
  set required(String? value) =>
      props[_$key__required___$TestStatefulPropValidationProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__required___$TestStatefulPropValidationProps = PropDescriptor(
          _$key__required___$TestStatefulPropValidationProps,
          isRequired: true);
  static const String _$key__required___$TestStatefulPropValidationProps =
      'TestStatefulPropValidationProps.required';

  static const List<PropDescriptor> $props = [
    _$prop__required___$TestStatefulPropValidationProps
  ];
  static const List<String> $propKeys = [
    _$key__required___$TestStatefulPropValidationProps
  ];
}

const PropsMeta _$metaForTestStatefulPropValidationProps = PropsMeta(
  fields: _$TestStatefulPropValidationPropsAccessorsMixin.$props,
  keys: _$TestStatefulPropValidationPropsAccessorsMixin.$propKeys,
);

class TestStatefulPropValidationProps extends _$TestStatefulPropValidationProps
    with _$TestStatefulPropValidationPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulPropValidationProps;
}

_$$TestStatefulPropValidationProps _$TestStatefulPropValidation(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulPropValidationProps$JsMap(JsBackedMap())
        : _$$TestStatefulPropValidationProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulPropValidationProps
    extends _$TestStatefulPropValidationProps
    with _$TestStatefulPropValidationPropsAccessorsMixin
    implements TestStatefulPropValidationProps {
  _$$TestStatefulPropValidationProps._();

  factory _$$TestStatefulPropValidationProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulPropValidationProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulPropValidationProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulPropValidationComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulPropValidationProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulPropValidationProps(
          accessMap, (map) => _$$TestStatefulPropValidationProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulPropValidationProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulPropValidationProps$PlainMap
    extends _$$TestStatefulPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulPropValidationProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulPropValidationProps$JsMap
    extends _$$TestStatefulPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulPropValidationProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulPropValidationState = StateMeta(
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
abstract class _$$TestStatefulPropValidationState
    extends _$TestStatefulPropValidationState
    with _$TestStatefulPropValidationStateAccessorsMixin
    implements TestStatefulPropValidationState {
  _$$TestStatefulPropValidationState._();

  factory _$$TestStatefulPropValidationState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulPropValidationState$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulPropValidationState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulPropValidationState$PlainMap
    extends _$$TestStatefulPropValidationState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulPropValidationState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulPropValidationState$JsMap
    extends _$$TestStatefulPropValidationState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulPropValidationState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulPropValidationComponent
    extends TestStatefulPropValidationComponent {
  late _$$TestStatefulPropValidationProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulPropValidationProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulPropValidationProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulPropValidationProps$JsMap(backingMap);

  @override
  _$$TestStatefulPropValidationProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulPropValidationProps(backingMap);

  late _$$TestStatefulPropValidationState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulPropValidationState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulPropValidationState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulPropValidationState$JsMap(backingMap);

  @override
  _$$TestStatefulPropValidationState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulPropValidationState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulPropValidation';

  /// The default consumed props, taken from _$TestStatefulPropValidationProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulPropValidationProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulRedrawOnComponentFactory = registerComponent2(
  () => _$TestStatefulRedrawOnComponent(),
  builderFactory: _$TestStatefulRedrawOn,
  componentClass: TestStatefulRedrawOnComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulRedrawOnPropsAccessorsMixin
    implements _$TestStatefulRedrawOnProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStatefulRedrawOnProps = PropsMeta(
  fields: _$TestStatefulRedrawOnPropsAccessorsMixin.$props,
  keys: _$TestStatefulRedrawOnPropsAccessorsMixin.$propKeys,
);

class TestStatefulRedrawOnProps extends _$TestStatefulRedrawOnProps
    with _$TestStatefulRedrawOnPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulRedrawOnProps;
}

_$$TestStatefulRedrawOnProps _$TestStatefulRedrawOn([Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulRedrawOnProps$JsMap(JsBackedMap())
        : _$$TestStatefulRedrawOnProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulRedrawOnProps extends _$TestStatefulRedrawOnProps
    with _$TestStatefulRedrawOnPropsAccessorsMixin
    implements TestStatefulRedrawOnProps {
  _$$TestStatefulRedrawOnProps._();

  factory _$$TestStatefulRedrawOnProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulRedrawOnProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulRedrawOnProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulRedrawOnComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulRedrawOnProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulRedrawOnProps(
          accessMap, (map) => _$$TestStatefulRedrawOnProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulRedrawOnProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulRedrawOnProps$PlainMap
    extends _$$TestStatefulRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulRedrawOnProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulRedrawOnProps$JsMap extends _$$TestStatefulRedrawOnProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulRedrawOnProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulRedrawOnState = StateMeta(
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
abstract class _$$TestStatefulRedrawOnState extends _$TestStatefulRedrawOnState
    with _$TestStatefulRedrawOnStateAccessorsMixin
    implements TestStatefulRedrawOnState {
  _$$TestStatefulRedrawOnState._();

  factory _$$TestStatefulRedrawOnState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulRedrawOnState$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulRedrawOnState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulRedrawOnState$PlainMap
    extends _$$TestStatefulRedrawOnState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulRedrawOnState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulRedrawOnState$JsMap extends _$$TestStatefulRedrawOnState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulRedrawOnState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulRedrawOnComponent extends TestStatefulRedrawOnComponent {
  late _$$TestStatefulRedrawOnProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulRedrawOnProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulRedrawOnProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulRedrawOnProps$JsMap(backingMap);

  @override
  _$$TestStatefulRedrawOnProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulRedrawOnProps(backingMap);

  late _$$TestStatefulRedrawOnState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulRedrawOnState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulRedrawOnState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulRedrawOnState$JsMap(backingMap);

  @override
  _$$TestStatefulRedrawOnState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulRedrawOnState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulRedrawOn';

  /// The default consumed props, taken from _$TestStatefulRedrawOnProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulRedrawOnProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestStatefulStoreHandlersComponentFactory = registerComponent2(
  () => _$TestStatefulStoreHandlersComponent(),
  builderFactory: _$TestStatefulStoreHandlers,
  componentClass: TestStatefulStoreHandlersComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestStatefulStoreHandlersPropsAccessorsMixin
    implements _$TestStatefulStoreHandlersProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestStatefulStoreHandlersProps = PropsMeta(
  fields: _$TestStatefulStoreHandlersPropsAccessorsMixin.$props,
  keys: _$TestStatefulStoreHandlersPropsAccessorsMixin.$propKeys,
);

class TestStatefulStoreHandlersProps extends _$TestStatefulStoreHandlersProps
    with _$TestStatefulStoreHandlersPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestStatefulStoreHandlersProps;
}

_$$TestStatefulStoreHandlersProps _$TestStatefulStoreHandlers(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$TestStatefulStoreHandlersProps$JsMap(JsBackedMap())
        : _$$TestStatefulStoreHandlersProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TestStatefulStoreHandlersProps
    extends _$TestStatefulStoreHandlersProps
    with _$TestStatefulStoreHandlersPropsAccessorsMixin
    implements TestStatefulStoreHandlersProps {
  _$$TestStatefulStoreHandlersProps._();

  factory _$$TestStatefulStoreHandlersProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulStoreHandlersProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulStoreHandlersProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestStatefulStoreHandlersComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestStatefulStoreHandlersProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestStatefulStoreHandlersProps(
          accessMap, (map) => _$$TestStatefulStoreHandlersProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestStatefulStoreHandlersProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
class _$$TestStatefulStoreHandlersProps$PlainMap
    extends _$$TestStatefulStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulStoreHandlersProps$PlainMap(Map? backingMap)
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
class _$$TestStatefulStoreHandlersProps$JsMap
    extends _$$TestStatefulStoreHandlersProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulStoreHandlersProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
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

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForTestStatefulStoreHandlersState = StateMeta(
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
abstract class _$$TestStatefulStoreHandlersState
    extends _$TestStatefulStoreHandlersState
    with _$TestStatefulStoreHandlersStateAccessorsMixin
    implements TestStatefulStoreHandlersState {
  _$$TestStatefulStoreHandlersState._();

  factory _$$TestStatefulStoreHandlersState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestStatefulStoreHandlersState$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$TestStatefulStoreHandlersState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TestStatefulStoreHandlersState$PlainMap
    extends _$$TestStatefulStoreHandlersState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulStoreHandlersState$PlainMap(Map? backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TestStatefulStoreHandlersState$JsMap
    extends _$$TestStatefulStoreHandlersState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestStatefulStoreHandlersState$JsMap(JsBackedMap? backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestStatefulStoreHandlersComponent
    extends TestStatefulStoreHandlersComponent {
  late _$$TestStatefulStoreHandlersProps$JsMap _cachedTypedProps;

  @override
  _$$TestStatefulStoreHandlersProps$JsMap get props => _cachedTypedProps;

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
  _$$TestStatefulStoreHandlersProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulStoreHandlersProps$JsMap(backingMap);

  @override
  _$$TestStatefulStoreHandlersProps typedPropsFactory(Map? backingMap) =>
      _$$TestStatefulStoreHandlersProps(backingMap);

  late _$$TestStatefulStoreHandlersState$JsMap _cachedTypedState;
  @override
  _$$TestStatefulStoreHandlersState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$TestStatefulStoreHandlersState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestStatefulStoreHandlersState$JsMap(backingMap);

  @override
  _$$TestStatefulStoreHandlersState typedStateFactory(Map? backingMap) =>
      _$$TestStatefulStoreHandlersState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestStatefulStoreHandlers';

  /// The default consumed props, taken from _$TestStatefulStoreHandlersProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestStatefulStoreHandlersProps
  ];
}
