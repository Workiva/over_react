part of over_react.web.demo_components;

/// Nest one or more `ListGroupItem` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ListGroupItemProps> ListGroupItem;

@Props()
class ListGroupItemProps extends UiProps {
  /// The HTML element type for the [ListGroupItem], specifying its DOM
  /// representation when rendered.
  ///
  /// Will only be used if [href] and [onClick] are both `null`.
  ///
  /// Default: [ListGroupItemElementType.SPAN]
  ListGroupItemElementType elementType;

  /// Optional header text to display within the [ListGroupItem] above
  /// the value of [children].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#custom-content>.
  dynamic header;

  /// The size of the [header] text you desire.
  ///
  /// Default: [ListGroupItemHeaderElementSize.H5]
  ListGroupItemHeaderElementSize headerSize;

  /// Additional props to be added to the [header] element _(if specified)_.
  Map headerProps;

  /// The skin / "context" for the [ListGroupItem].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#contextual-classes>.
  ///
  /// Default: [ListGroupItemSkin.DEFAULT]
  ListGroupItemSkin skin;

  /// Whether the [ListGroupItem] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#anchors-and-buttons>
  ///
  /// Default: false
  bool isActive;

  /// Whether the [ListGroupItem] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/list-group/#disabled-items>
  ///
  /// Default: false
  @Accessor(key: 'disabled', keyNamespace: '')
  bool isDisabled;

  /// The HTML `href` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  @Accessor(keyNamespace: '')
  String href;

  /// The HTML `target` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  @Accessor(keyNamespace: '')
  String target;

  /// The HTML `type` attribute value for the [ListGroupItem] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [onClick] is also set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ButtonType type;
}

@Component()
class ListGroupItemComponent extends UiComponent<ListGroupItemProps> {
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
      ..type = _isAnchorLink ? null : props.type.typeName
      ..disabled = _useDisabledAttr ? props.isDisabled : null
      ..addProps(ariaProps()
        ..disabled = !_useDisabledAttr ? props.isDisabled : null
      )
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

  bool get _useDisabledAttr => _getItemDomNodeFactory() == Dom.button;

  bool get _isActionItem => (props.href ?? props.onClick) != null;

  bool get _isAnchorLink => props.href != null;
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
