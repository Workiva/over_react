// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'list_group_item.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupItemComponentFactory = registerComponent(
  () => _$ListGroupItemComponent(),
  builderFactory: _$ListGroupItem,
  componentClass: ListGroupItemComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ListGroupItem',
);

abstract class _$ListGroupItemPropsAccessorsMixin
    implements _$ListGroupItemProps {
  @override
  Map get props;

  /// The HTML element type for the [ListGroupItem], specifying its DOM
  /// representation when rendered.
  ///
  /// Will only be used if [href] and [onClick] are both `null`.
  ///
  /// Default: [ListGroupItemElementType.SPAN]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.elementType] -->
  @override
  ListGroupItemElementType get elementType =>
      props[_$key__elementType___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML element type for the [ListGroupItem], specifying its DOM
  /// representation when rendered.
  ///
  /// Will only be used if [href] and [onClick] are both `null`.
  ///
  /// Default: [ListGroupItemElementType.SPAN]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.elementType] -->
  @override
  set elementType(ListGroupItemElementType value) =>
      props[_$key__elementType___$ListGroupItemProps] = value;

  /// Optional header text to display within the [ListGroupItem] above
  /// the value of [children].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#custom-content>.
  ///
  /// <!-- Generated from [_$ListGroupItemProps.header] -->
  @override
  dynamic get header =>
      props[_$key__header___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Optional header text to display within the [ListGroupItem] above
  /// the value of [children].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#custom-content>.
  ///
  /// <!-- Generated from [_$ListGroupItemProps.header] -->
  @override
  set header(dynamic value) =>
      props[_$key__header___$ListGroupItemProps] = value;

  /// The size of the [header] text you desire.
  ///
  /// Default: [ListGroupItemHeaderElementSize.H5]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.headerSize] -->
  @override
  ListGroupItemHeaderElementSize get headerSize =>
      props[_$key__headerSize___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The size of the [header] text you desire.
  ///
  /// Default: [ListGroupItemHeaderElementSize.H5]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.headerSize] -->
  @override
  set headerSize(ListGroupItemHeaderElementSize value) =>
      props[_$key__headerSize___$ListGroupItemProps] = value;

  /// Additional props to be added to the [header] element _(if specified)_.
  ///
  /// <!-- Generated from [_$ListGroupItemProps.headerProps] -->
  @override
  Map get headerProps =>
      props[_$key__headerProps___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Additional props to be added to the [header] element _(if specified)_.
  ///
  /// <!-- Generated from [_$ListGroupItemProps.headerProps] -->
  @override
  set headerProps(Map value) =>
      props[_$key__headerProps___$ListGroupItemProps] = value;

  /// The skin / "context" for the [ListGroupItem].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#contextual-classes>.
  ///
  /// Default: [ListGroupItemSkin.DEFAULT]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.skin] -->
  @override
  ListGroupItemSkin get skin =>
      props[_$key__skin___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The skin / "context" for the [ListGroupItem].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#contextual-classes>.
  ///
  /// Default: [ListGroupItemSkin.DEFAULT]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.skin] -->
  @override
  set skin(ListGroupItemSkin value) =>
      props[_$key__skin___$ListGroupItemProps] = value;

  /// Whether the [ListGroupItem] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#anchors-and-buttons>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ListGroupItemProps.isActive] -->
  @override
  bool get isActive =>
      props[_$key__isActive___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ListGroupItem] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#anchors-and-buttons>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ListGroupItemProps.isActive] -->
  @override
  set isActive(bool value) =>
      props[_$key__isActive___$ListGroupItemProps] = value;

  /// Whether the [ListGroupItem] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#disabled-items>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ListGroupItemProps.isDisabled] -->
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled =>
      props[_$key__isDisabled___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ListGroupItem] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#disabled-items>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ListGroupItemProps.isDisabled] -->
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  set isDisabled(bool value) =>
      props[_$key__isDisabled___$ListGroupItemProps] = value;

  /// The HTML `href` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  ///
  /// <!-- Generated from [_$ListGroupItemProps.href] -->
  @override
  @Accessor(keyNamespace: '')
  String get href =>
      props[_$key__href___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `href` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  ///
  /// <!-- Generated from [_$ListGroupItemProps.href] -->
  @override
  @Accessor(keyNamespace: '')
  set href(String value) => props[_$key__href___$ListGroupItemProps] = value;

  /// The HTML `target` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  ///
  /// <!-- Generated from [_$ListGroupItemProps.target] -->
  @override
  @Accessor(keyNamespace: '')
  String get target =>
      props[_$key__target___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `target` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  ///
  /// <!-- Generated from [_$ListGroupItemProps.target] -->
  @override
  @Accessor(keyNamespace: '')
  set target(String value) =>
      props[_$key__target___$ListGroupItemProps] = value;

  /// The HTML `type` attribute value for the [ListGroupItem] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [onClick] is also set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.type] -->
  @override
  ButtonType get type =>
      props[_$key__type___$ListGroupItemProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `type` attribute value for the [ListGroupItem] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [onClick] is also set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ///
  /// <!-- Generated from [_$ListGroupItemProps.type] -->
  @override
  set type(ButtonType value) =>
      props[_$key__type___$ListGroupItemProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__elementType___$ListGroupItemProps =
      PropDescriptor(_$key__elementType___$ListGroupItemProps);
  static const PropDescriptor _$prop__header___$ListGroupItemProps =
      PropDescriptor(_$key__header___$ListGroupItemProps);
  static const PropDescriptor _$prop__headerSize___$ListGroupItemProps =
      PropDescriptor(_$key__headerSize___$ListGroupItemProps);
  static const PropDescriptor _$prop__headerProps___$ListGroupItemProps =
      PropDescriptor(_$key__headerProps___$ListGroupItemProps);
  static const PropDescriptor _$prop__skin___$ListGroupItemProps =
      PropDescriptor(_$key__skin___$ListGroupItemProps);
  static const PropDescriptor _$prop__isActive___$ListGroupItemProps =
      PropDescriptor(_$key__isActive___$ListGroupItemProps);
  static const PropDescriptor _$prop__isDisabled___$ListGroupItemProps =
      PropDescriptor(_$key__isDisabled___$ListGroupItemProps);
  static const PropDescriptor _$prop__href___$ListGroupItemProps =
      PropDescriptor(_$key__href___$ListGroupItemProps);
  static const PropDescriptor _$prop__target___$ListGroupItemProps =
      PropDescriptor(_$key__target___$ListGroupItemProps);
  static const PropDescriptor _$prop__type___$ListGroupItemProps =
      PropDescriptor(_$key__type___$ListGroupItemProps);
  static const String _$key__elementType___$ListGroupItemProps =
      'ListGroupItemProps.elementType';
  static const String _$key__header___$ListGroupItemProps =
      'ListGroupItemProps.header';
  static const String _$key__headerSize___$ListGroupItemProps =
      'ListGroupItemProps.headerSize';
  static const String _$key__headerProps___$ListGroupItemProps =
      'ListGroupItemProps.headerProps';
  static const String _$key__skin___$ListGroupItemProps =
      'ListGroupItemProps.skin';
  static const String _$key__isActive___$ListGroupItemProps =
      'ListGroupItemProps.isActive';
  static const String _$key__isDisabled___$ListGroupItemProps = 'disabled';
  static const String _$key__href___$ListGroupItemProps = 'href';
  static const String _$key__target___$ListGroupItemProps = 'target';
  static const String _$key__type___$ListGroupItemProps =
      'ListGroupItemProps.type';

  static const List<PropDescriptor> $props = [
    _$prop__elementType___$ListGroupItemProps,
    _$prop__header___$ListGroupItemProps,
    _$prop__headerSize___$ListGroupItemProps,
    _$prop__headerProps___$ListGroupItemProps,
    _$prop__skin___$ListGroupItemProps,
    _$prop__isActive___$ListGroupItemProps,
    _$prop__isDisabled___$ListGroupItemProps,
    _$prop__href___$ListGroupItemProps,
    _$prop__target___$ListGroupItemProps,
    _$prop__type___$ListGroupItemProps
  ];
  static const List<String> $propKeys = [
    _$key__elementType___$ListGroupItemProps,
    _$key__header___$ListGroupItemProps,
    _$key__headerSize___$ListGroupItemProps,
    _$key__headerProps___$ListGroupItemProps,
    _$key__skin___$ListGroupItemProps,
    _$key__isActive___$ListGroupItemProps,
    _$key__isDisabled___$ListGroupItemProps,
    _$key__href___$ListGroupItemProps,
    _$key__target___$ListGroupItemProps,
    _$key__type___$ListGroupItemProps
  ];
}

const PropsMeta _$metaForListGroupItemProps = PropsMeta(
  fields: _$ListGroupItemPropsAccessorsMixin.$props,
  keys: _$ListGroupItemPropsAccessorsMixin.$propKeys,
);

class ListGroupItemProps extends _$ListGroupItemProps
    with _$ListGroupItemPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForListGroupItemProps;
}

_$$ListGroupItemProps _$ListGroupItem([Map backingProps]) =>
    _$$ListGroupItemProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ListGroupItemProps extends _$ListGroupItemProps
    with _$ListGroupItemPropsAccessorsMixin
    implements ListGroupItemProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ListGroupItemProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ListGroupItemComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ListGroupItemProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ListGroupItemComponent extends ListGroupItemComponent {
  @override
  _$$ListGroupItemProps typedPropsFactory(Map backingMap) =>
      _$$ListGroupItemProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ListGroupItemProps.
  /// Used in -`ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForListGroupItemProps
  ];
}
