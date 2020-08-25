import 'package:collection/collection.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'task_count.over_react.g.dart';

UiFactory<TaskCountBadgeProps> TaskCountBadge =
    connect<AppState, TaskCountBadgeProps>(
  mapStateToPropsWithOwnProps: (state, ownProps) {
    return (TaskCountBadge()
      ..assignedTodoIds = state.todos
          .where((todo) => todo.assignedUserId == ownProps.user.id)
          .map((todo) => todo.id)
          .toList());
  },
  areStatePropsEqual: (nextProps, prevProps) {
    return ListEquality()
        .equals(nextProps.assignedTodoIds, prevProps.assignedTodoIds);
  },
)(uiFunction((props) {
  String _getTooltipContent() {
    final taskCount = props.assignedTodoIds.length;
    if (taskCount == 1) {
      return 'There is $taskCount task assigned to ${props.user.name}';
    }

    return 'There are $taskCount tasks assigned to ${props.user.name}';
  }

  return (Box()
    ..onMouseEnter = (_) {
      props.dispatch(HighlightTodosAction(props.assignedTodoIds));
    }
    ..onMouseLeave = (_) {
      props.dispatch(UnHighlightTodosAction(props.assignedTodoIds));
    })(
    (Tooltip()
      ..title = _getTooltipContent()
      ..arrow = true
      ..enterDelay = 500)(
      (Badge()
        ..badgeContent = Dom.span()(props.assignedTodoIds.length)
        ..color = BadgeColor.SECONDARY
        ..overlap = BadgeOverlap.CIRCLE
        ..anchorOrigin =
            BadgeAnchorOrigin(horizontal: 'right', vertical: 'bottom'))(
        props.children,
      ),
    ),
  );
}, $TaskCountBadgeConfig // ignore: undefined_identifier
        ));

mixin TaskCountBadgePropsMixin on UiProps {
  @requiredProp
  User user;

  @requiredProp
  List<String> assignedTodoIds;
}

class TaskCountBadgeProps = UiProps
    with TaskCountBadgePropsMixin, ConnectPropsMixin, WithThemePropsMixin;
