import 'package:over_react/over_react.dart';

export 'package:todo_client/src/components/shared/hoverable_item_component_mixin.dart';

// ignore: uri_has_not_been_generated
part 'hoverable_item_mixin.over_react.g.dart';

@StateMixin()
abstract class HoverableItemStateMixin implements UiState {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForHoverableItemStateMixin;

  @override
  Map get state;

  bool isChildFocused;

  bool isHovered;
}
