// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:over_react/over_react.dart';

import '../demo_components.dart';
part 'list_group_item.over_react.g.dart';

/// Nest one or more `ListGroupItem` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>

UiFactory<ListGroupItemProps> ListGroupItem = _$ListGroupItem;

mixin ListGroupItemProps on UiProps {
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
  /// _Proxies [DomPropsMixin.href]_
  @Accessor(keyNamespace: '')
  String href;

  /// The HTML `target` attribute value for the [ListGroupItem].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomPropsMixin.target]_
  @Accessor(keyNamespace: '')
  String target;

  /// The HTML `type` attribute value for the [ListGroupItem] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [onClick] is also set.
  ///
  /// _Proxies [DomPropsMixin.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ButtonType type;
}

class ListGroupItemComponent extends UiComponent2<ListGroupItemProps> {
  @override
  get defaultProps => (newProps()
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
      ..modifyProps(addUnconsumedDomProps)
      ..className = _getItemClasses().toClassName()
      ..href = props.href
      ..target = props.target
      ..type = _isActionItem && !_isAnchorLink ? props.type.typeName : null
      ..disabled = _useDisabledAttr ? props.isDisabled : null
      ..addProps(ariaProps()
        ..disabled = !_useDisabledAttr ? props.isDisabled : null
      )
    )(children);
  }

  ReactElement renderItemHeader() {
    if (props.header == null) return null;

    var headerClasses = ClassNameBuilder.fromProps(props.headerProps)
      ..add('list-group-item-heading');

    return (props.headerSize.componentBuilderFactory()
      ..addProps(props.headerProps)
      ..className = headerClasses.toClassName()
      ..key = 'item-header'
    )(props.header);
  }

  BuilderOnlyUiFactory<DomProps> _getItemDomNodeFactory() {
    BuilderOnlyUiFactory<DomProps> factory;

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
      ListGroupItemSkin._('DEFAULT', null);

  /// [className] value: 'list-group-item-danger'
  static const ListGroupItemSkin DANGER =
      ListGroupItemSkin._('DANGER', 'list-group-item-danger');

  /// [className] value: 'list-group-item-success'
  static const ListGroupItemSkin SUCCESS =
      ListGroupItemSkin._('SUCCESS', 'list-group-item-success');

  /// [className] value: 'list-group-item-warning'
  static const ListGroupItemSkin WARNING =
      ListGroupItemSkin._('WARNING', 'list-group-item-warning');

  /// [className] value: 'list-group-item-info'
  static const ListGroupItemSkin INFO =
      ListGroupItemSkin._('INFO', 'list-group-item-info');
}

/// Options for the `Element` that will be used when rendering a [ListGroupItem] component.
class ListGroupItemElementType {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupItemElementType._internal(this.componentBuilderFactory);

  /// A [Dom.li] (HTML `<li>` element)
  ///
  /// Will only be used if [ListGroupItemProps.href] and
  /// `ListGroupItemProps.onClick` are both `null`.
  ///
  /// Only use this when the parent [ListGroup] has
  /// [ListGroupProps.elementType] set to [ListGroupElementType.UL].
  static final ListGroupItemElementType LI =
      ListGroupItemElementType._internal(Dom.li);

  /// A [Dom.span] (HTML `<span>` element)
  ///
  /// Will only be used if [ListGroupItemProps.href] and
  /// `ListGroupItemProps.onClick` are both `null`.
  static final ListGroupItemElementType SPAN =
      ListGroupItemElementType._internal(Dom.span);
}

/// Options for the `Element` that will be used when rendering a [ListGroupItemProps.header].
class ListGroupItemHeaderElementSize {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupItemHeaderElementSize._internal(this.componentBuilderFactory);

  /// A [Dom.h1] (HTML `<h1>` element)
  static final ListGroupItemHeaderElementSize H1 =
      ListGroupItemHeaderElementSize._internal(Dom.h1);

  /// A [Dom.h2] (HTML `<h2>` element)
  static final ListGroupItemHeaderElementSize H2 =
      ListGroupItemHeaderElementSize._internal(Dom.h2);

  /// A [Dom.h3] (HTML `<h3>` element)
  static final ListGroupItemHeaderElementSize H3 =
      ListGroupItemHeaderElementSize._internal(Dom.h3);

  /// A [Dom.h4] (HTML `<h4>` element)
  static final ListGroupItemHeaderElementSize H4 =
      ListGroupItemHeaderElementSize._internal(Dom.h4);

  /// A [Dom.h5] (HTML `<h5>` element)
  static final ListGroupItemHeaderElementSize H5 =
      ListGroupItemHeaderElementSize._internal(Dom.h5);

  /// A [Dom.h6] (HTML `<h6>` element)
  static final ListGroupItemHeaderElementSize H6 =
      ListGroupItemHeaderElementSize._internal(Dom.h6);
}

