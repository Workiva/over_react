import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/app_bar_local_storage_menu.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'app_bar.over_react.g.dart';


UiFactory<TodoAppBarProps>  TodoAppBar =
    // ignore: undefined_identifier
    _$TodoAppBar;


mixin TodoAppBarProps on UiProps {}


class TodoAppBarComponent extends UiComponent2<TodoAppBarProps> {
  @override
  render() {
    return Fragment()(
      AppBar(props,
        Toolbar({},
          Box({'flexGrow': 1},
            Typography({
              'variant': 'h6',
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

