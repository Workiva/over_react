// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'dummy_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $DummyComponentFactory = registerComponent2(
  () => _$DummyComponent(),
  builderFactory: _$Dummy,
  componentClass: DummyComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Dummy',
);

abstract class _$DummyPropsAccessorsMixin implements _$DummyProps {
  @override
  Map get props;

  /// <!-- Generated from [_$DummyProps.onComponentDidMount] -->
  @override
  Function? get onComponentDidMount =>
      (props[_$key__onComponentDidMount___$DummyProps] ?? null) as Function?;

  /// <!-- Generated from [_$DummyProps.onComponentDidMount] -->
  @override
  set onComponentDidMount(Function? value) =>
      props[_$key__onComponentDidMount___$DummyProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onComponentDidMount___$DummyProps =
      PropDescriptor(_$key__onComponentDidMount___$DummyProps);
  static const String _$key__onComponentDidMount___$DummyProps =
      'DummyProps.onComponentDidMount';

  static const List<PropDescriptor> $props = [
    _$prop__onComponentDidMount___$DummyProps
  ];
  static const List<String> $propKeys = [
    _$key__onComponentDidMount___$DummyProps
  ];
}

const PropsMeta _$metaForDummyProps = PropsMeta(
  fields: _$DummyPropsAccessorsMixin.$props,
  keys: _$DummyPropsAccessorsMixin.$propKeys,
);

_$$DummyProps _$Dummy([Map? backingProps]) => backingProps == null
    ? _$$DummyProps$JsMap(JsBackedMap())
    : _$$DummyProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$DummyProps extends _$DummyProps
    with _$DummyPropsAccessorsMixin
    implements DummyProps {
  _$$DummyProps._();

  factory _$$DummyProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DummyProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$DummyProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $DummyComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'DummyProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$DummyProps$PlainMap extends _$$DummyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DummyProps$PlainMap(Map? backingMap)
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
class _$$DummyProps$JsMap extends _$$DummyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DummyProps$JsMap(JsBackedMap? backingMap)
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
class _$DummyComponent extends DummyComponent {
  late _$$DummyProps$JsMap _cachedTypedProps;

  @override
  _$$DummyProps$JsMap get props => _cachedTypedProps;

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
  _$$DummyProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$DummyProps$JsMap(backingMap);

  @override
  _$$DummyProps typedPropsFactory(Map? backingMap) => _$$DummyProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$DummyProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForDummyProps];
}
