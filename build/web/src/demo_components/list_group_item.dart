part of over_react.web.demo_components;

/// Nest one or more `ListGroupItem` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ListGroupItemProps> ListGroupItem = ([Map backingProps]) => new _$ListGroupItemPropsImpl(backingProps);

@Props()
class ListGroupItemProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__elementType = const PropDescriptor(_$key__elementType), _$prop__header = const PropDescriptor(_$key__header), _$prop__headerSize = const PropDescriptor(_$key__headerSize), _$prop__headerProps = const PropDescriptor(_$key__headerProps), _$prop__skin = const PropDescriptor(_$key__skin), _$prop__isActive = const PropDescriptor(_$key__isActive), _$prop__isDisabled = const PropDescriptor(_$key__isDisabled), _$prop__href = const PropDescriptor(_$key__href), _$prop__target = const PropDescriptor(_$key__target), _$prop__type = const PropDescriptor(_$key__type), _$prop__role = const PropDescriptor(_$key__role); static const List<PropDescriptor> $props = const [_$prop__elementType, _$prop__header, _$prop__headerSize, _$prop__headerProps, _$prop__skin, _$prop__isActive, _$prop__isDisabled, _$prop__href, _$prop__target, _$prop__type, _$prop__role]; static const String _$key__elementType = 'ListGroupItemProps.elementType', _$key__header = 'ListGroupItemProps.header', _$key__headerSize = 'ListGroupItemProps.headerSize', _$key__headerProps = 'ListGroupItemProps.headerProps', _$key__skin = 'ListGroupItemProps.skin', _$key__isActive = 'ListGroupItemProps.isActive', _$key__isDisabled = 'disabled', _$key__href = 'href', _$key__target = 'target', _$key__type = 'ListGroupItemProps.type', _$key__role = 'role'; static const List<String> $propKeys = const [_$key__elementType, _$key__header, _$key__headerSize, _$key__headerProps, _$key__skin, _$key__isActive, _$key__isDisabled, _$key__href, _$key__target, _$key__type, _$key__role]; 
  /// The HTML element type for the [ListGroupItem], specifying its DOM
  /// representation when rendered.
  ///
  /// Will only be used if [href] and [onClick] are both `null`.
  ///
  /// Default: [ListGroupItemElementType.SPAN]
  ListGroupItemElementType get elementType => props[_$key__elementType];  set elementType(ListGroupItemElementType value) => props[_$key__elementType] = value;

  /// Optional header text to display within the [ListGroupItem] above
  /// the value of [children].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#custom-content>.
  dynamic get header => props[_$key__header];  set header(dynamic value) => props[_$key__header] = value;

  /// The size of the [header] text you desire.
  ///
  /// Default: [ListGroupItemHeaderElementSize.H5]
  ListGroupItemHeaderElementSize get headerSize => props[_$key__headerSize];  set headerSize(ListGroupItemHeaderElementSize value) => props[_$key__headerSize] = value;

  /// Additional props to be added to the [header] element _(if specified)_.
  Map get headerProps => props[_$key__headerProps];  set headerProps(Map value) => props[_$key__headerProps] = value;

  /// The skin / "context" for the [ListGroupItem].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#contextual-classes>.
  ///
  /// Default: [ListGroupItemSkin.DEFAULT]
  ListGroupItemSkin get skin => props[_$key__skin];  set skin(ListGroupItemSkin value) => props[_$key__skin] = value;

  /// Whether the [ListGroupItem] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#anchors-and-buttons>
  ///
  /// Default: false
  bool get isActive => props[_$key__isActive];  set isActive(bool value) => props[_$key__isActive] = value;

  /// Whether the [ListGroupItem] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#disabled-items>
  ///
  /// Default: false
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled => props[_$key__isDisabled];  set isDisabled(bool value) => props[_$key__isDisabled] = value;

  /// The HTML `href` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  @Accessor(keyNamespace: '')
  String get href => props[_$key__href];  set href(String value) => props[_$key__href] = value;

  /// The HTML `target` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  @Accessor(keyNamespace: '')
  String get target => props[_$key__target];  set target(String value) => props[_$key__target] = value;

  /// The HTML `type` attribute value for the [ListGroupItem] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [onClick] is also set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ButtonType get type => props[_$key__type];  set type(ButtonType value) => props[_$key__type] = value;

  /// The HTML `role` attribute value for the [ListGroupItem] when _not_
  /// rendered via [Dom.button].
  ///
  /// _Proxies [DomProps.role]_
  ///
  /// Default: 'button'
  @Accessor(keyNamespace: '')
  String get role => props[_$key__role];  set role(String value) => props[_$key__role] = value;
}

@Component()
class ListGroupItemComponent extends UiComponent<ListGroupItemProps> with _$ListGroupItemComponentImplMixin {
  @override
  Map getDefaultProps() => (newProps()
    ..elementType = ListGroupItemElementType.SPAN
    ..skin = ListGroupItemSkin.DEFAULT
    ..isActive = false
    ..isDisabled = false
    ..type = ButtonType.BUTTON
    ..headerSize = ListGroupItemHeaderElementSize.H5
  );

  @override
  render() {
    var children = props.children;

    if (props.header != null) {
      children = [
        renderItemHeader(),
        (Dom.p()
          ..className = 'list-group-item-text'
          ..key = 'item-text'
        )(props.children)
      ];
    }

    BuilderOnlyUiFactory<DomProps> factory = _getItemDomNodeFactory();

    return (factory()
      ..addProps(copyUnconsumedDomProps())
      ..className = _getItemClasses().toClassName()
      ..href = props.href
      ..target = props.target
      ..type = _isActionItem ? props.type.typeName : null
      ..role = props.role
    )(children);
  }

  ReactElement renderItemHeader() {
    if (props.header == null) return null;

    var headerClasses = new ClassNameBuilder.fromProps(props.headerProps)
      ..add('list-group-item-heading');

    return (props.headerSize.componentBuilderFactory()
      ..addProps(props.headerProps)
      ..className = headerClasses.toClassName()
      ..key = 'item-header'
    )(props.header);
  }

  BuilderOnlyUiFactory<DomProps> _getItemDomNodeFactory() {
    var factory;

    if (props.href != null) {
      factory = Dom.a;
    } else if (props.onClick != null) {
      factory = Dom.button;
    } else {
      factory = props.elementType.componentBuilderFactory;
    }

    return factory;
  }

  ClassNameBuilder _getItemClasses() {
    return forwardingClassNameBuilder()
      ..add('list-group-item')
      ..add('list-group-item-action', _isActionItem)
      ..add('active', props.isActive)
      ..add('disabled', props.isDisabled)
      ..add(props.skin.className);
  }

  bool get _isActionItem => (props.href ?? props.onClick) != null;
}

/// Contextual skin options for a [ListGroupItem] component.
class ListGroupItemSkin extends ClassNameConstant {
  const ListGroupItemSkin._(String name, String className) : super(name, className);

  /// [className] value: null
  static const ListGroupItemSkin DEFAULT =
      const ListGroupItemSkin._('DEFAULT', null);

  /// [className] value: 'list-group-item-danger'
  static const ListGroupItemSkin DANGER =
      const ListGroupItemSkin._('DANGER', 'list-group-item-danger');

  /// [className] value: 'list-group-item-success'
  static const ListGroupItemSkin SUCCESS =
      const ListGroupItemSkin._('SUCCESS', 'list-group-item-success');

  /// [className] value: 'list-group-item-warning'
  static const ListGroupItemSkin WARNING =
      const ListGroupItemSkin._('WARNING', 'list-group-item-warning');

  /// [className] value: 'list-group-item-info'
  static const ListGroupItemSkin INFO =
      const ListGroupItemSkin._('INFO', 'list-group-item-info');
}

/// Options for the [Element] that will be used when rendering a [ListGroupItem] component.
class ListGroupItemElementType {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupItemElementType._internal(this.componentBuilderFactory);

  /// A [Dom.li] (HTML `<li>` element)
  ///
  /// Will only be used if [ListGroupItemProps.href] and
  /// [ListGroupItemProps.onClick] are both `null`.
  ///
  /// Only use this when the parent [ListGroup] has
  /// [ListGroupProps.elementType] set to [ListGroupElementType.UL].
  static final ListGroupItemElementType LI =
      new ListGroupItemElementType._internal(Dom.li);

  /// A [Dom.span] (HTML `<span>` element)
  ///
  /// Will only be used if [ListGroupItemProps.href] and
  /// [ListGroupItemProps.onClick] are both `null`.
  static final ListGroupItemElementType SPAN =
      new ListGroupItemElementType._internal(Dom.span);
}

/// Options for the [Element] that will be used when rendering a [ListGroupItemProps.header].
class ListGroupItemHeaderElementSize {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupItemHeaderElementSize._internal(this.componentBuilderFactory);

  /// A [Dom.h1] (HTML `<h1>` element)
  static final ListGroupItemHeaderElementSize H1 =
      new ListGroupItemHeaderElementSize._internal(Dom.h1);

  /// A [Dom.h2] (HTML `<h2>` element)
  static final ListGroupItemHeaderElementSize H2 =
      new ListGroupItemHeaderElementSize._internal(Dom.h2);

  /// A [Dom.h3] (HTML `<h3>` element)
  static final ListGroupItemHeaderElementSize H3 =
      new ListGroupItemHeaderElementSize._internal(Dom.h3);

  /// A [Dom.h4] (HTML `<h4>` element)
  static final ListGroupItemHeaderElementSize H4 =
      new ListGroupItemHeaderElementSize._internal(Dom.h4);

  /// A [Dom.h5] (HTML `<h5>` element)
  static final ListGroupItemHeaderElementSize H5 =
      new ListGroupItemHeaderElementSize._internal(Dom.h5);

  /// A [Dom.h6] (HTML `<h6>` element)
  static final ListGroupItemHeaderElementSize H6 =
      new ListGroupItemHeaderElementSize._internal(Dom.h6);
}



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ListGroupItemComponentFactory = registerComponent(() => new ListGroupItemComponent(),
    builderFactory: ListGroupItem,
    componentClass: ListGroupItemComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ListGroupItem'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$ListGroupItemPropsImpl extends ListGroupItemProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$ListGroupItemPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $ListGroupItemComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ListGroupItemProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ListGroupItemComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ListGroupItemProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [ListGroupItemProps.$consumedProps];
  @override
  ListGroupItemProps typedPropsFactory(Map backingMap) => new _$ListGroupItemPropsImpl(backingMap);

}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

