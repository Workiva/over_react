import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/app_bar_local_storage_menu.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'app_bar.over_react.g.dart';

final useStyles = makeStyles({
  'root': {
    'backgroundColor': 'green',
    'border': '1px solid red',
  },
  'typagraphy1': {
    'color': 'red',
  }
});

final useStyles2 = makeStyles({
  'box': {
    'color': 'purple',
  },
  'typagraphy1': {
    'color': 'blue',
  }
});


mixin TodoAppBarProps on UiProps {}

UiFactory<TodoAppBarProps> TodoAppBar = uiFunction((props) {
  final styles = useStyles(props);
  final styles2 = useStyles2(props);

 return Fragment()(
      AppBar(props,
        Toolbar({'classes': {
          'root': {
            'backgroundColor': 'green',
            'border': '1px solid red',
          }
        }
        },
//        Toolbar({},
          (Box()
              ..flexGrow = 1
              ..className = styles2['box']
          )(
            Typography({
              'variant': 'h6',
              'className': styles['typagraphy1']
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

