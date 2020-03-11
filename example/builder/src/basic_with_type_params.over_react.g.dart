// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_with_type_params.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? _$$BasicProps$JsMap(JsBackedMap())
    : _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$BasicProps<T, U extends UiProps> extends BasicProps<T, U>
    with $BasicPropsMixin {
  _$$BasicProps._();

  factory _$$BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicProps$PlainMap<T, U extends UiProps> extends _$$BasicProps<T, U> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$PlainMap(Map backingMap)
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
class _$$BasicProps$JsMap<T, U extends UiProps> extends _$$BasicProps<T, U> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicProps$JsMap(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) => _$$BasicProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from BasicProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}

mixin $BasicPropsMixin<T, U extends UiProps> on BasicPropsMixin<T, U> {
  static const PropsMeta meta = _$metaForBasicPropsMixin;
  @override
  List<T> get someGenericListProp =>
      props[_$key__someGenericListProp__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set someGenericListProp(List<T> value) =>
      props[_$key__someGenericListProp__BasicPropsMixin] = value;
  @override
  U get somePropsClass =>
      props[_$key__somePropsClass__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set somePropsClass(U value) =>
      props[_$key__somePropsClass__BasicPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__someGenericListProp__BasicPropsMixin =
      PropDescriptor(_$key__someGenericListProp__BasicPropsMixin);
  static const PropDescriptor _$prop__somePropsClass__BasicPropsMixin =
      PropDescriptor(_$key__somePropsClass__BasicPropsMixin);
  static const String _$key__someGenericListProp__BasicPropsMixin =
      'BasicPropsMixin.someGenericListProp';
  static const String _$key__somePropsClass__BasicPropsMixin =
      'BasicPropsMixin.somePropsClass';

  static const List<PropDescriptor> $props = [
    _$prop__someGenericListProp__BasicPropsMixin,
    _$prop__somePropsClass__BasicPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__someGenericListProp__BasicPropsMixin,
    _$key__somePropsClass__BasicPropsMixin
  ];
}

const PropsMeta _$metaForBasicPropsMixin = PropsMeta(
  fields: $BasicPropsMixin.$props,
  keys: $BasicPropsMixin.$propKeys,
);
