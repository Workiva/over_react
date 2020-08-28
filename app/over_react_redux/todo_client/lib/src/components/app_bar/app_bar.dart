import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/app_bar_local_storage_menu.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/app_bar/app_bar_theme_menu.dart';

import '../../theme.dart';

part 'app_bar.over_react.g.dart';

final useStyles = makeThemedStyles((theme) => MuiStyleMap()
      ..addRule('app-bar', {
        'backgroundColor': theme.palette.grey['900'],
      }), options: MuiStyleOptions()..defaultTheme = simpleTheme);

mixin TodoAppBarProps on UiProps {}

UiFactory<TodoAppBarProps> TodoAppBar = uiFunction((props) {
  final classes = useStyles();

  return Fragment()(
    (AppBar()
      ..className=classes['app-bar']
      ..addProps(getPropsToForward(props))
    )(
      Toolbar()(
        (Box()
          ..flexGrow = 1
        )(
          (Typography()
            ..variant = TypographyVariant.H6
          )('OverReact Redux Todo Demo App'),
        ),
        AppBarLocalStorageMenu()(),
        AppBarThemeMenu()()
      ),
    ),
    Toolbar()(),
  );
},
  $TodoAppBarConfig, // ignore: undefined_identifier
);

