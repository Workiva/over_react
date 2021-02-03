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

// ignore_for_file: deprecated_member_use_from_same_package
import 'dart:html';

import 'package:over_react/over_react.dart';

import '../demo_components.dart';
part 'list_group.over_react.g.dart';

/// Bootstrap's `ListGroup` component is flexible and powerful for
/// displaying lists of [ListGroupItem] components.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ListGroupProps> ListGroup = _$ListGroup;

@Props()
class _$ListGroupProps extends UiProps {
  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ListGroupElementType elementType;
}

@Component()
class ListGroupComponent extends UiComponent<ListGroupProps> {
  @override
  Map getDefaultProps() => (newProps()
    ..elementType = ListGroupElementType.DIV
  );

  @override
  render() {
    var classes = forwardingClassNameBuilder()
      ..add('list-group');

    return (props.elementType.componentBuilderFactory()
      ..addProps(copyUnconsumedDomProps())
      ..className = classes.toClassName()
    )(props.children);
  }
}

/// Options for the [Element] that will be used when
/// rendering a [ListGroup] component.
class ListGroupElementType {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupElementType._internal(this.componentBuilderFactory);

  /// A [Dom.ul] (HTML `<ul>` element)
  static final ListGroupElementType UL  = ListGroupElementType._internal(Dom.ul);

  /// A [Dom.div] (HTML `<div>` element)
  static final ListGroupElementType DIV = ListGroupElementType._internal(Dom.div);
}

