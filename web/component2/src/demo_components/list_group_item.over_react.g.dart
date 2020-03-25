// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'list_group_item.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ListGroupItemComponentFactory = registerComponent2(
  () => _$ListGroupItemComponent(),
  builderFactory: ListGroupItem,
  componentClass: ListGroupItemComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ListGroupItem',
);

_$$ListGroupItemProps _$ListGroupItem([Map backingProps]) =>
    backingProps == null
        ? _$$ListGroupItemProps$JsMap(JsBackedMap())
        : _$$ListGroupItemProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ListGroupItemProps extends UiProps
    with
        ListGroupItemProps,
        $ListGroupItemProps // If this generated mixin is undefined, it's likely because ListGroupItemProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ListGroupItemProps.
{
  _$$ListGroupItemProps._();

  factory _$$ListGroupItemProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ListGroupItemProps$JsMap(backingMap);
    } else {
      return _$$ListGroupItemProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ListGroupItemComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ListGroupItemProps$PlainMap extends _$$ListGroupItemProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupItemProps$PlainMap(Map backingMap)
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
class _$$ListGroupItemProps$JsMap extends _$$ListGroupItemProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupItemProps$JsMap(JsBackedMap backingMap)
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
class _$ListGroupItemComponent extends ListGroupItemComponent {
  _$$ListGroupItemProps$JsMap _cachedTypedProps;

  @override
  _$$ListGroupItemProps$JsMap get props => _cachedTypedProps;

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
  _$$ListGroupItemProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ListGroupItemProps$JsMap(backingMap);

  @override
  _$$ListGroupItemProps typedPropsFactory(Map backingMap) =>
      _$$ListGroupItemProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ListGroupItemProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(ListGroupItemProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ListGroupItemProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ListGroupItemProps.
        ListGroupItemProps: $ListGroupItemProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ListGroupItemProps on ListGroupItemProps {
  static const PropsMeta meta = _$metaForListGroupItemProps;
  @override
  ListGroupItemElementType get elementType =>
      props[_$key__elementType__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set elementType(ListGroupItemElementType value) =>
      props[_$key__elementType__ListGroupItemProps] = value;
  @override
  dynamic get header =>
      props[_$key__header__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set header(dynamic value) => props[_$key__header__ListGroupItemProps] = value;
  @override
  ListGroupItemHeaderElementSize get headerSize =>
      props[_$key__headerSize__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set headerSize(ListGroupItemHeaderElementSize value) =>
      props[_$key__headerSize__ListGroupItemProps] = value;
  @override
  Map get headerProps =>
      props[_$key__headerProps__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set headerProps(Map value) =>
      props[_$key__headerProps__ListGroupItemProps] = value;
  @override
  ListGroupItemSkin get skin =>
      props[_$key__skin__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set skin(ListGroupItemSkin value) =>
      props[_$key__skin__ListGroupItemProps] = value;
  @override
  bool get isActive =>
      props[_$key__isActive__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isActive(bool value) =>
      props[_$key__isActive__ListGroupItemProps] = value;
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled =>
      props[_$key__isDisabled__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  set isDisabled(bool value) =>
      props[_$key__isDisabled__ListGroupItemProps] = value;
  @override
  @Accessor(keyNamespace: '')
  String get href =>
      props[_$key__href__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: '')
  set href(String value) => props[_$key__href__ListGroupItemProps] = value;
  @override
  @Accessor(keyNamespace: '')
  String get target =>
      props[_$key__target__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: '')
  set target(String value) => props[_$key__target__ListGroupItemProps] = value;
  @override
  ButtonType get type =>
      props[_$key__type__ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set type(ButtonType value) => props[_$key__type__ListGroupItemProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__elementType__ListGroupItemProps =
      PropDescriptor(_$key__elementType__ListGroupItemProps);
  static const PropDescriptor _$prop__header__ListGroupItemProps =
      PropDescriptor(_$key__header__ListGroupItemProps);
  static const PropDescriptor _$prop__headerSize__ListGroupItemProps =
      PropDescriptor(_$key__headerSize__ListGroupItemProps);
  static const PropDescriptor _$prop__headerProps__ListGroupItemProps =
      PropDescriptor(_$key__headerProps__ListGroupItemProps);
  static const PropDescriptor _$prop__skin__ListGroupItemProps =
      PropDescriptor(_$key__skin__ListGroupItemProps);
  static const PropDescriptor _$prop__isActive__ListGroupItemProps =
      PropDescriptor(_$key__isActive__ListGroupItemProps);
  static const PropDescriptor _$prop__isDisabled__ListGroupItemProps =
      PropDescriptor(_$key__isDisabled__ListGroupItemProps);
  static const PropDescriptor _$prop__href__ListGroupItemProps =
      PropDescriptor(_$key__href__ListGroupItemProps);
  static const PropDescriptor _$prop__target__ListGroupItemProps =
      PropDescriptor(_$key__target__ListGroupItemProps);
  static const PropDescriptor _$prop__type__ListGroupItemProps =
      PropDescriptor(_$key__type__ListGroupItemProps);
  static const String _$key__elementType__ListGroupItemProps =
      'ListGroupItemProps.elementType';
  static const String _$key__header__ListGroupItemProps =
      'ListGroupItemProps.header';
  static const String _$key__headerSize__ListGroupItemProps =
      'ListGroupItemProps.headerSize';
  static const String _$key__headerProps__ListGroupItemProps =
      'ListGroupItemProps.headerProps';
  static const String _$key__skin__ListGroupItemProps =
      'ListGroupItemProps.skin';
  static const String _$key__isActive__ListGroupItemProps =
      'ListGroupItemProps.isActive';
  static const String _$key__isDisabled__ListGroupItemProps = 'disabled';
  static const String _$key__href__ListGroupItemProps = 'href';
  static const String _$key__target__ListGroupItemProps = 'target';
  static const String _$key__type__ListGroupItemProps =
      'ListGroupItemProps.type';

  static const List<PropDescriptor> $props = [
    _$prop__elementType__ListGroupItemProps,
    _$prop__header__ListGroupItemProps,
    _$prop__headerSize__ListGroupItemProps,
    _$prop__headerProps__ListGroupItemProps,
    _$prop__skin__ListGroupItemProps,
    _$prop__isActive__ListGroupItemProps,
    _$prop__isDisabled__ListGroupItemProps,
    _$prop__href__ListGroupItemProps,
    _$prop__target__ListGroupItemProps,
    _$prop__type__ListGroupItemProps
  ];
  static const List<String> $propKeys = [
    _$key__elementType__ListGroupItemProps,
    _$key__header__ListGroupItemProps,
    _$key__headerSize__ListGroupItemProps,
    _$key__headerProps__ListGroupItemProps,
    _$key__skin__ListGroupItemProps,
    _$key__isActive__ListGroupItemProps,
    _$key__isDisabled__ListGroupItemProps,
    _$key__href__ListGroupItemProps,
    _$key__target__ListGroupItemProps,
    _$key__type__ListGroupItemProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForListGroupItemProps = PropsMeta(
  fields: $ListGroupItemProps.$props,
  keys: $ListGroupItemProps.$propKeys,
);
