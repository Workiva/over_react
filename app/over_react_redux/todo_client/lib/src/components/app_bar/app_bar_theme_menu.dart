import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/store.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/shared/menu_overlay.dart';

part 'app_bar_theme_menu.over_react.g.dart'; // ignore: uri_has_not_been_generated

class AppTheme {
  static const String defaultMui = 'defaultMui';
  static const String typography = 'typography';
  static const String neonColors = 'neonColors';
}

UiFactory<AppBarThemeMenuProps> AppBarThemeMenu =
    connect<AppState, AppBarThemeMenuProps>(
  mapStateToProps: (state) {
    return (AppBarThemeMenu()..currentTheme = state.theme);
  },
)(_$AppBarThemeMenu); // ignore: undefined_identifier

mixin AppBarThemeMenuPropsMixin on UiProps {
  String currentTheme;
}

class AppBarThemeMenuProps = UiProps
    with MenuOverlayProps, AppBarThemeMenuPropsMixin, ConnectPropsMixin;

class AppBarLocalStorageMenuComponent
    extends UiComponent2<AppBarThemeMenuProps> {
  final _overlayRef = createRef<MenuOverlayComponent>();

  @override
  get consumedProps => propsMeta.allExceptForMixins({MenuOverlayProps});

  @override
  render() {
    return (MenuOverlay()
      ..modifyProps(addUnconsumedProps)
      ..trigger = (Button()..color = ButtonColor.SECONDARY)('Change Theme')
      ..useDerivedMaxWidth = true
      ..ref = _overlayRef)(
      (MenuItem()
        ..onClick = (_) => _useTheme(AppTheme.defaultMui))('Default MUI Theme'),
      (MenuItem()..onClick = (_) => _useTheme(AppTheme.typography))(
          'Typography (Theme Nesting)'),
      (MenuItem()..onClick = (_) => _useTheme(AppTheme.neonColors))(
          'Neon Colors (Theme Extension)'),
    );
  }

  void _useTheme(String theme) {
    props.dispatch(UseThemeAction(theme));
    _overlayRef.current.close();
  }
}
