// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_group_item.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupItemComponentFactory = registerComponent(
    () => new _$ListGroupItemComponent(),
    builderFactory: ListGroupItem,
    componentClass: ListGroupItemComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ListGroupItem');

abstract class _$ListGroupItemPropsAccessorsMixin
    implements _$ListGroupItemProps {
  @override
  Map get props;

  /// Go to [_$ListGroupItemProps.elementType] to see the source code for this prop
  @override
  ListGroupItemElementType get elementType =>
      props['ListGroupItemProps.elementType'];

  /// Go to [_$ListGroupItemProps.elementType] to see the source code for this prop
  @override
  set elementType(ListGroupItemElementType value) =>
      props['ListGroupItemProps.elementType'] = value;

  /// Go to [_$ListGroupItemProps.header] to see the source code for this prop
  @override
  dynamic get header => props['ListGroupItemProps.header'];

  /// Go to [_$ListGroupItemProps.header] to see the source code for this prop
  @override
  set header(dynamic value) => props['ListGroupItemProps.header'] = value;

  /// Go to [_$ListGroupItemProps.headerSize] to see the source code for this prop
  @override
  ListGroupItemHeaderElementSize get headerSize =>
      props['ListGroupItemProps.headerSize'];

  /// Go to [_$ListGroupItemProps.headerSize] to see the source code for this prop
  @override
  set headerSize(ListGroupItemHeaderElementSize value) =>
      props['ListGroupItemProps.headerSize'] = value;

  /// Go to [_$ListGroupItemProps.headerProps] to see the source code for this prop
  @override
  Map get headerProps => props['ListGroupItemProps.headerProps'];

  /// Go to [_$ListGroupItemProps.headerProps] to see the source code for this prop
  @override
  set headerProps(Map value) => props['ListGroupItemProps.headerProps'] = value;

  /// Go to [_$ListGroupItemProps.skin] to see the source code for this prop
  @override
  ListGroupItemSkin get skin => props['ListGroupItemProps.skin'];

  /// Go to [_$ListGroupItemProps.skin] to see the source code for this prop
  @override
  set skin(ListGroupItemSkin value) => props['ListGroupItemProps.skin'] = value;

  /// Go to [_$ListGroupItemProps.isActive] to see the source code for this prop
  @override
  bool get isActive => props['ListGroupItemProps.isActive'];

  /// Go to [_$ListGroupItemProps.isActive] to see the source code for this prop
  @override
  set isActive(bool value) => props['ListGroupItemProps.isActive'] = value;

  /// Go to [_$ListGroupItemProps.isDisabled] to see the source code for this prop
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled => props['disabled'];

  /// Go to [_$ListGroupItemProps.isDisabled] to see the source code for this prop
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  set isDisabled(bool value) => props['disabled'] = value;

  /// Go to [_$ListGroupItemProps.href] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  String get href => props['href'];

  /// Go to [_$ListGroupItemProps.href] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set href(String value) => props['href'] = value;

  /// Go to [_$ListGroupItemProps.target] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  String get target => props['target'];

  /// Go to [_$ListGroupItemProps.target] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set target(String value) => props['target'] = value;

  /// Go to [_$ListGroupItemProps.type] to see the source code for this prop
  @override
  ButtonType get type => props['ListGroupItemProps.type'];

  /// Go to [_$ListGroupItemProps.type] to see the source code for this prop
  @override
  set type(ButtonType value) => props['ListGroupItemProps.type'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ListGroupItemProps.elementType'),
    const PropDescriptor('ListGroupItemProps.header'),
    const PropDescriptor('ListGroupItemProps.headerSize'),
    const PropDescriptor('ListGroupItemProps.headerProps'),
    const PropDescriptor('ListGroupItemProps.skin'),
    const PropDescriptor('ListGroupItemProps.isActive'),
    const PropDescriptor('disabled'),
    const PropDescriptor('href'),
    const PropDescriptor('target'),
    const PropDescriptor('ListGroupItemProps.type')
  ];
  static const List<String> $propKeys = const [
    'ListGroupItemProps.elementType',
    'ListGroupItemProps.header',
    'ListGroupItemProps.headerSize',
    'ListGroupItemProps.headerProps',
    'ListGroupItemProps.skin',
    'ListGroupItemProps.isActive',
    'disabled',
    'href',
    'target',
    'ListGroupItemProps.type'
  ];
}

const PropsMeta _$metaForListGroupItemProps = const PropsMeta(
  fields: _$ListGroupItemPropsAccessorsMixin.$props,
  keys: _$ListGroupItemPropsAccessorsMixin.$propKeys,
);

class ListGroupItemProps extends _$ListGroupItemProps
    with _$ListGroupItemPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForListGroupItemProps;
}

_$$ListGroupItemProps _$ListGroupItem([Map backingProps]) =>
    new _$$ListGroupItemProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ListGroupItemProps extends _$ListGroupItemProps
    with _$ListGroupItemPropsAccessorsMixin
    implements ListGroupItemProps {
  _$$ListGroupItemProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ListGroupItemComponentFactory;

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
      new _$$ListGroupItemProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ListGroupItemProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForListGroupItemProps
  ];
}
