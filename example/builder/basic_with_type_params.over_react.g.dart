// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_with_type_params.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent(() => new _$BasicComponent(),
    builderFactory: Basic,
    componentClass: BasicComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Basic');

abstract class _$BasicPropsAccessorsMixin<T, U extends UiProps>
    implements _$BasicProps<T, U> {
  @override
  Map get props;

  /// Go to [_$BasicProps.someGenericListProp] to see the source code for this prop
  @override
  List<T> get someGenericListProp =>
      props[_$key__someGenericListProp___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$BasicProps.someGenericListProp] to see the source code for this prop
  @override
  set someGenericListProp(List<T> value) =>
      props[_$key__someGenericListProp___$BasicProps] = value;

  /// Go to [_$BasicProps.somePropsClass] to see the source code for this prop
  @override
  U get somePropsClass =>
      props[_$key__somePropsClass___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$BasicProps.somePropsClass] to see the source code for this prop
  @override
  set somePropsClass(U value) =>
      props[_$key__somePropsClass___$BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__someGenericListProp___$BasicProps =
      const PropDescriptor(_$key__someGenericListProp___$BasicProps);
  static const PropDescriptor _$prop__somePropsClass___$BasicProps =
      const PropDescriptor(_$key__somePropsClass___$BasicProps);
  static const String _$key__someGenericListProp___$BasicProps =
      'BasicProps.someGenericListProp';
  static const String _$key__somePropsClass___$BasicProps =
      'BasicProps.somePropsClass';

  static const List<PropDescriptor> $props = const [
    _$prop__someGenericListProp___$BasicProps,
    _$prop__somePropsClass___$BasicProps
  ];
  static const List<String> $propKeys = const [
    _$key__someGenericListProp___$BasicProps,
    _$key__somePropsClass___$BasicProps
  ];
}

const PropsMeta _$metaForBasicProps = const PropsMeta(
  fields: _$BasicPropsAccessorsMixin.$props,
  keys: _$BasicPropsAccessorsMixin.$propKeys,
);

class BasicProps<T, U extends UiProps> extends _$BasicProps<T, U>
    with _$BasicPropsAccessorsMixin<T, U> {
  static const PropsMeta meta = _$metaForBasicProps;
}

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? new _$$BasicProps$JsMap(new JsBackedMap())
    : new _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicProps<T, U extends UiProps> extends _$BasicProps<T, U>
    with _$BasicPropsAccessorsMixin<T, U>
    implements BasicProps<T, U> {
  _$$BasicProps._();
  factory _$$BasicProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$BasicProps$PlainMap(backingMap);
    } else {
      return new _$$BasicProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';
}

class _$$BasicProps$PlainMap<T, U extends UiProps> extends _$$BasicProps<T, U> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

class _$$BasicProps$JsMap<T, U extends UiProps> extends _$$BasicProps<T, U> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$BasicProps$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  @override
  _$$BasicProps typedPropsFactory(Map backingMap) =>
      new _$$BasicProps(backingMap);
  @override
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$BasicProps$JsMap(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
  _$$BasicProps$JsMap _cachedTypedProps;
  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
