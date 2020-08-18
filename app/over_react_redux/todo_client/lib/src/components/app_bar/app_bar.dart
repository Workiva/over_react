import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/app_bar_local_storage_menu.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'app_bar.over_react.g.dart';

mixin TodoAppBarProps on UiProps {}

UiFactory<TodoAppBarProps> TodoAppBar = uiFunction((props) {
 return Fragment()(
      AppBar(props,
        Toolbar({'classes': {
          'root': {
            'backgroundColor': 'green',
            'border': '1px solid red',
          }
        }
        },
          (Box()
              ..flexGrow = 1
          )(
            Typography({
              'variant': 'h6',
            }, 'OverReact Redux Todo Demo App'),
            Typography({
              'variant': 'h6',
            }, 'Another Title'),
          ),
          AppBarLocalStorageMenu()(),
        ),
      ),
      Toolbar({}),
    );
  },
  $TodoAppBarConfig, // ignore: undefined_identifier
);

