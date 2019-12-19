import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/app_bar_local_storage_menu.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'app_bar.over_react.g.dart';

@Factory()
UiFactory<TodoAppBarProps>  TodoAppBar =
    // ignore: undefined_identifier
    _$TodoAppBar;

@Props()
class _$TodoAppBarProps extends UiProps {}

@Component2()
class TodoAppBarComponent extends UiComponent2<TodoAppBarProps> {
  @override
  render() {
    return Fragment()(
      AppBar(props,
        Toolbar({},
          Box({'flexGrow': 1},
            Typography({
              'variant': 'h6',
              'className': muiClasses['title']
            }, 'OverReact Redux Todo Demo App'),
          ),
          ConnectedAppBarLocalStorageMenu()(),
        ),
      ),
      Toolbar({}),
    );
  }
}

// ignore: mixin_of_non_class, undefined_class
class TodoAppBarProps extends _$TodoAppBarProps with _$TodoAppBarPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTodoAppBarProps;
}
