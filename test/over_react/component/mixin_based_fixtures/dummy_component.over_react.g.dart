// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'dummy_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $DummyComponentFactory = registerComponent2(
  () => _$DummyComponent(),
  builderFactory: Dummy,
  componentClass: DummyComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Dummy',
);

_$$DummyProps _$Dummy([Map backingProps]) => backingProps == null
    ? _$$DummyProps$JsMap(JsBackedMap())
    : _$$DummyProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$DummyProps extends UiProps
    with
        DummyProps,
        $DummyProps // If this generated mixin is undefined, it's likely because DummyProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of DummyProps.
{
  _$$DummyProps._();

  factory _$$DummyProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DummyProps$JsMap(backingMap);
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
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$DummyProps$PlainMap extends _$$DummyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DummyProps$PlainMap(Map backingMap)
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$DummyProps$JsMap extends _$$DummyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DummyProps$JsMap(JsBackedMap backingMap)
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$DummyComponent extends DummyComponent {
  _$$DummyProps$JsMap _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$DummyProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$DummyProps$JsMap(backingMap);

  @override
  _$$DummyProps typedPropsFactory(Map backingMap) => _$$DummyProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from DummyProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(DummyProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because DummyProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of DummyProps.
        DummyProps: $DummyProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $DummyProps on DummyProps {
  static const PropsMeta meta = _$metaForDummyProps;
  @override
  Function get onComponentDidMount =>
      props[_$key__onComponentDidMount__DummyProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set onComponentDidMount(Function value) =>
      props[_$key__onComponentDidMount__DummyProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onComponentDidMount__DummyProps =
      PropDescriptor(_$key__onComponentDidMount__DummyProps);
  static const String _$key__onComponentDidMount__DummyProps =
      'DummyProps.onComponentDidMount';

  static const List<PropDescriptor> $props = [
    _$prop__onComponentDidMount__DummyProps
  ];
  static const List<String> $propKeys = [
    _$key__onComponentDidMount__DummyProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForDummyProps = PropsMeta(
  fields: $DummyProps.$props,
  keys: $DummyProps.$propKeys,
);
