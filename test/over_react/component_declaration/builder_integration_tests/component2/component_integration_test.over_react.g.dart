// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent2(
  () => new _$ComponentTestComponent(),
  builderFactory: ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ComponentTest',
);

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ComponentTestProps.stringProp] -->
  @override
  String get stringProp =>
      props[_$key__stringProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.stringProp] -->
  @override
  set stringProp(String value) =>
      props[_$key__stringProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.dynamicProp] -->
  @override
  dynamic get dynamicProp =>
      props[_$key__dynamicProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.dynamicProp] -->
  @override
  set dynamicProp(dynamic value) =>
      props[_$key__dynamicProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.untypedProp] -->
  @override
  get untypedProp =>
      props[_$key__untypedProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.untypedProp] -->
  @override
  set untypedProp(value) =>
      props[_$key__untypedProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customKeyProp] -->
  @override
  @Accessor(key: 'custom key!')
  get customKeyProp =>
      props[_$key__customKeyProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customKeyProp] -->
  @override
  @Accessor(key: 'custom key!')
  set customKeyProp(value) =>
      props[_$key__customKeyProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  get customNamespaceProp =>
      props[_$key__customNamespaceProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceProp(value) =>
      props[_$key__customNamespaceProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customKeyAndNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  get customKeyAndNamespaceProp =>
      props[_$key__customKeyAndNamespaceProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customKeyAndNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceProp(value) =>
      props[_$key__customKeyAndNamespaceProp___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp___$ComponentTestProps =
      const PropDescriptor(_$key__stringProp___$ComponentTestProps);
  static const PropDescriptor _$prop__dynamicProp___$ComponentTestProps =
      const PropDescriptor(_$key__dynamicProp___$ComponentTestProps);
  static const PropDescriptor _$prop__untypedProp___$ComponentTestProps =
      const PropDescriptor(_$key__untypedProp___$ComponentTestProps);
  static const PropDescriptor _$prop__customKeyProp___$ComponentTestProps =
      const PropDescriptor(_$key__customKeyProp___$ComponentTestProps);
  static const PropDescriptor
      _$prop__customNamespaceProp___$ComponentTestProps =
      const PropDescriptor(_$key__customNamespaceProp___$ComponentTestProps);
  static const PropDescriptor
      _$prop__customKeyAndNamespaceProp___$ComponentTestProps =
      const PropDescriptor(
          _$key__customKeyAndNamespaceProp___$ComponentTestProps);
  static const String _$key__stringProp___$ComponentTestProps =
      'ComponentTestProps.stringProp';
  static const String _$key__dynamicProp___$ComponentTestProps =
      'ComponentTestProps.dynamicProp';
  static const String _$key__untypedProp___$ComponentTestProps =
      'ComponentTestProps.untypedProp';
  static const String _$key__customKeyProp___$ComponentTestProps =
      'ComponentTestProps.custom key!';
  static const String _$key__customNamespaceProp___$ComponentTestProps =
      'custom namespace~~customNamespaceProp';
  static const String _$key__customKeyAndNamespaceProp___$ComponentTestProps =
      'custom namespace~~custom key!';

  static const List<PropDescriptor> $props = const [
    _$prop__stringProp___$ComponentTestProps,
    _$prop__dynamicProp___$ComponentTestProps,
    _$prop__untypedProp___$ComponentTestProps,
    _$prop__customKeyProp___$ComponentTestProps,
    _$prop__customNamespaceProp___$ComponentTestProps,
    _$prop__customKeyAndNamespaceProp___$ComponentTestProps
  ];
  static const List<String> $propKeys = const [
    _$key__stringProp___$ComponentTestProps,
    _$key__dynamicProp___$ComponentTestProps,
    _$key__untypedProp___$ComponentTestProps,
    _$key__customKeyProp___$ComponentTestProps,
    _$key__customNamespaceProp___$ComponentTestProps,
    _$key__customKeyAndNamespaceProp___$ComponentTestProps
  ];
}

const PropsMeta _$metaForComponentTestProps = const PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

class ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForComponentTestProps;
}

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    backingProps == null
        ? new _$$ComponentTestProps$JsMap(new JsBackedMap())
        : new _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  _$$ComponentTestProps._();

  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$ComponentTestProps$JsMap(backingMap);
    } else {
      return new _$$ComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ComponentTestProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ComponentTestProps$PlainMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$PlainMap(Map backingMap)
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
class _$$ComponentTestProps$JsMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$JsMap(JsBackedMap backingMap)
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
class _$ComponentTestComponent extends ComponentTestComponent {
  _$$ComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$ComponentTestProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$ComponentTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$ComponentTestProps$JsMap(backingMap);

  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      new _$$ComponentTestProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $IsErrorBoundaryComponentFactory = registerComponent2(
  () => new _$IsErrorBoundaryComponent(),
  builderFactory: IsErrorBoundary,
  componentClass: IsErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'IsErrorBoundary',
  skipMethods: const [],
);

abstract class _$IsErrorBoundaryPropsAccessorsMixin
    implements _$IsErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForIsErrorBoundaryProps = const PropsMeta(
  fields: _$IsErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$IsErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class IsErrorBoundaryProps extends _$IsErrorBoundaryProps
    with _$IsErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForIsErrorBoundaryProps;
}

_$$IsErrorBoundaryProps _$IsErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? new _$$IsErrorBoundaryProps$JsMap(new JsBackedMap())
        : new _$$IsErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$IsErrorBoundaryProps extends _$IsErrorBoundaryProps
    with _$IsErrorBoundaryPropsAccessorsMixin
    implements IsErrorBoundaryProps {
  _$$IsErrorBoundaryProps._();

  factory _$$IsErrorBoundaryProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$IsErrorBoundaryProps$JsMap(backingMap);
    } else {
      return new _$$IsErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $IsErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'IsErrorBoundaryProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$IsErrorBoundaryProps$PlainMap extends _$$IsErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsErrorBoundaryProps$PlainMap(Map backingMap)
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
class _$$IsErrorBoundaryProps$JsMap extends _$$IsErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsErrorBoundaryProps$JsMap(JsBackedMap backingMap)
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
class _$IsErrorBoundaryComponent extends IsErrorBoundaryComponent {
  _$$IsErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$IsErrorBoundaryProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$IsErrorBoundaryProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$IsErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$IsErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$IsErrorBoundaryProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$IsErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForIsErrorBoundaryProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $IsNotErrorBoundaryComponentFactory = registerComponent2(
  () => new _$IsNotErrorBoundaryComponent(),
  builderFactory: IsNotErrorBoundary,
  componentClass: IsNotErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'IsNotErrorBoundary',
);

abstract class _$IsNotErrorBoundaryPropsAccessorsMixin
    implements _$IsNotErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForIsNotErrorBoundaryProps = const PropsMeta(
  fields: _$IsNotErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$IsNotErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class IsNotErrorBoundaryProps extends _$IsNotErrorBoundaryProps
    with _$IsNotErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForIsNotErrorBoundaryProps;
}

_$$IsNotErrorBoundaryProps _$IsNotErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? new _$$IsNotErrorBoundaryProps$JsMap(new JsBackedMap())
        : new _$$IsNotErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$IsNotErrorBoundaryProps extends _$IsNotErrorBoundaryProps
    with _$IsNotErrorBoundaryPropsAccessorsMixin
    implements IsNotErrorBoundaryProps {
  _$$IsNotErrorBoundaryProps._();

  factory _$$IsNotErrorBoundaryProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$IsNotErrorBoundaryProps$JsMap(backingMap);
    } else {
      return new _$$IsNotErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $IsNotErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'IsNotErrorBoundaryProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$IsNotErrorBoundaryProps$PlainMap extends _$$IsNotErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsNotErrorBoundaryProps$PlainMap(Map backingMap)
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
class _$$IsNotErrorBoundaryProps$JsMap extends _$$IsNotErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$IsNotErrorBoundaryProps$JsMap(JsBackedMap backingMap)
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
class _$IsNotErrorBoundaryComponent extends IsNotErrorBoundaryComponent {
  _$$IsNotErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$IsNotErrorBoundaryProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$IsNotErrorBoundaryProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$IsNotErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$IsNotErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$IsNotErrorBoundaryProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$IsNotErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForIsNotErrorBoundaryProps
  ];
}
