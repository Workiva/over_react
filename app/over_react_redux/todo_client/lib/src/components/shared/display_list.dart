import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/empty_view.dart';

// ignore: uri_has_not_been_generated
part 'display_list.over_react.g.dart';

@Factory()
UiFactory<DisplayListProps> DisplayList =
    // ignore: undefined_identifier
    _$DisplayList;

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField component.
class _$DisplayListProps extends UiProps {
  @requiredProp
  String listItemTypeDescription;
}

@Component2()
class DisplayListComponent extends UiComponent2<DisplayListProps> {
  @override
  render() {
    if (props.children.isEmpty) {
      return (EmptyView()
        ..type = EmptyViewType.VBLOCK
        ..header = 'No ${props.listItemTypeDescription} to show'
        ..glyph = InfoIcon({'color': 'disabled'})
      )(
        'You should totally create one!',
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
      ...propsToForward
    },
      props.children,
    );
  }
}

// ignore: mixin_of_non_class, undefined_class
class DisplayListProps extends _$DisplayListProps with _$DisplayListPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForDisplayListProps;
}
