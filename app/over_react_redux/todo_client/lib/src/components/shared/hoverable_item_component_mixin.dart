import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/hoverable_item_mixin.dart';

mixin HoverableItemMixin<T extends UiProps, S extends HoverableItemStateMixin> on UiStatefulComponent2<T, S> {
  @mustCallSuper
  @override
  get initialState => (newState()
    ..isHovered = false
    ..isChildFocused = false
  );

  @protected
  bool get isHovered => state.isHovered || state.isChildFocused;

  @protected
  void handleChildBlur(SyntheticFocusEvent event) {
    var newlyFocusedTarget = event.relatedTarget;
    // newlyFocusedTarget could be null or a window, so check if it's an Element first.
    if (newlyFocusedTarget is Element && findDomNode(this).contains(newlyFocusedTarget)) {
      // Don't do anything if we're moving from one item to another
      return;
    }

    setState(newState()..isChildFocused = false);
  }

  @protected
  void handleChildFocus(SyntheticFocusEvent event) {
    setState(newState()..isChildFocused = true);
  }

  @protected
  void handleItemMouseEnter(SyntheticMouseEvent event) {
    setState(newState()..isHovered = true);
  }

  @protected
  void handleItemMouseOver(SyntheticMouseEvent event) {
    if (!state.isHovered) {
      setState(newState()..isHovered = true);
    }
  }

  @protected
  void handleItemMouseLeave(SyntheticMouseEvent event) {
    setState(newState()..isHovered = false);
  }
}
