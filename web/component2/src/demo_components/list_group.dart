import 'package:over_react/over_react.dart';

import '../demo_components.dart';
part 'list_group.over_react.g.dart';

/// Bootstrap's `ListGroup` component is flexible and powerful for
/// displaying lists of [ListGroupItem] components.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ListGroupProps> ListGroup = _$ListGroup;

@Props()
class _$ListGroupProps extends UiProps {
  /// The HTML element type for the [ListGroup], specifying its
  /// DOM representation when rendered.
  ///
  /// Default: [ListGroupElementType.DIV]
  ListGroupElementType elementType;
}

@Component2()
class ListGroupComponent extends UiComponent2<ListGroupProps> {
  @override
   get defaultProps => (newProps()
    ..elementType = ListGroupElementType.DIV
  );

  @override
  render() {
    var classes = forwardingClassNameBuilder()
      ..add('list-group');

    return (props.elementType.componentBuilderFactory()
      ..modifyProps(addUnconsumedDomProps)
      ..className = classes.toClassName()
    )(props.children);
  }
}

/// Options for the `Element` that will be used when
/// rendering a [ListGroup] component.
class ListGroupElementType {
  final BuilderOnlyUiFactory<DomProps> componentBuilderFactory;
  ListGroupElementType._internal(this.componentBuilderFactory);

  /// A [Dom.ul] (HTML `<ul>` element)
  static final ListGroupElementType UL  = ListGroupElementType._internal(Dom.ul);

  /// A [Dom.div] (HTML `<div>` element)
  static final ListGroupElementType DIV = ListGroupElementType._internal(Dom.div);
}

