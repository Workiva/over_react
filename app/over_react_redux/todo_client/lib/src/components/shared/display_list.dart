import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/shared/empty_view.dart';

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
        ..header = 'No ${props.listItemTypeDescription} to show'
        ..glyph = InfoIcon({'color': 'disabled'})
        ..addTestId('todo_client.DisplayList.EmptyView')
      )(
        'You should totally create one!',
      );
    }

    return (Box()
        ..key = 'scrollableList'
        ..grow = true
        ..paddingTop = 2
        ..style = {...props.style ?? {}, 'overflowY': 'auto'}
        ..ref = scrollingBoxRef

    )(
      props.children,
    );
  }
}
