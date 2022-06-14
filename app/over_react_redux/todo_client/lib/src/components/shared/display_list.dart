import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/empty_view.dart';
import 'package:todo_client/src/intl/todo_client_intl.dart';

part 'display_list.over_react.g.dart';

UiFactory<DisplayListProps> DisplayList =
        castUiFactory(_$DisplayList); // ignore: undefined_identifier

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField component.
mixin DisplayListProps on UiProps {
  @requiredProp
  String listItemTypeDescription;
}

class DisplayListComponent extends UiComponent2<DisplayListProps> {
  @visibleForTesting
  final scrollingBoxRef = createRef().jsRef;

  @override
  render() {
    if (props.children.isEmpty) {
      return (EmptyView()
        ..type = EmptyViewType.VBLOCK
        ..header = TodoClientIntl.emptyView(props.listItemTypeDescription)
        ..glyph = InfoIcon({'color': 'disabled'})
        ..addTestId('todo_client.DisplayList.EmptyView')
      )(
        TodoClientIntl.youShouldTotallyCreateOne,
      );
    }

    final propsToForward = {...props}..remove('listItemTypeDescription');
    return Box({
      'key': 'scrollableList',
      'flexGrow': 1,
      'flexShrink': 1,
      'flexBasis': '0%',
      'paddingTop': 2,
      'style': {...props.style ?? {}, 'overflowY': 'auto'},
      ...propsToForward,
      'ref': scrollingBoxRef,
    },
      props.children,
    );
  }
}
