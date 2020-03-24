import 'package:over_react/over_react.dart';

export 'package:todo_client/src/components/shared/hoverable_item_component_mixin.dart';

// ignore: uri_has_not_been_generated
part 'hoverable_item_mixin.over_react.g.dart';

mixin HoverableItemStateMixin on UiState {
  bool isChildFocused;

  bool isHovered;
}
