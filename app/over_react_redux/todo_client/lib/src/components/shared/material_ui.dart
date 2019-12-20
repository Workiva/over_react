// ignore_for_file: avoid_classes_with_only_static_members
@JS()
library material_ui;

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:todo_client/src/utils.dart';

/// JS interop wrapper class for [Material UI components](https://material-ui.com/).
///
/// Made available in the app via the following script tag within our app's `index.html`:
///
/// ```
/// <script src="https://unpkg.com/@material-ui/core/umd/material-ui.development.js"></script>
/// ```
@JS()
class MaterialUI {
  external static JsMap get colors;

  external static ReactClass get AppBar;
  external static ReactClass get Avatar;
  external static ReactClass get Badge;
  external static ReactClass get Box;
  external static ReactClass get Button;
  external static ReactClass get Checkbox;
  external static ReactClass get Container;
  external static ReactClass get CssBaseline;
  external static ReactClass get Divider;
  external static ReactClass get ExpansionPanel;
  external static ReactClass get ExpansionPanelActions;
  external static ReactClass get ExpansionPanelDetails;
  external static ReactClass get ExpansionPanelSummary;
  external static ReactClass get Grid;
  external static ReactClass get IconButton;
  external static ReactClass get InputBase;
  external static ReactClass get List;
  external static ReactClass get ListItem;
  external static ReactClass get Menu;
  external static ReactClass get MenuItem;
  external static ReactClass get Popover;
  external static ReactClass get SvgIcon;
  external static ReactClass get TextField;
  external static ReactClass get Toolbar;
  external static ReactClass get Tooltip;
  external static ReactClass get Typography;
}

final muiColors = jsBackedMapDeepFromJs(MaterialUI.colors);

// -----------------------------------------------------------------------
// Below, you'll find the top level JS component factories
// that we can use just like any other react-dart component in our app!
// -----------------------------------------------------------------------

/// See: <https://material-ui.com/components/app-bar/>
final AppBar = ReactJsComponentFactoryProxy(MaterialUI.AppBar);

/// See: <https://material-ui.com/components/avatars/>
final Avatar = ReactJsComponentFactoryProxy(MaterialUI.Avatar);

/// See: <https://material-ui.com/components/badges/>
final Badge = ReactJsComponentFactoryProxy(MaterialUI.Badge);

/// See: <https://material-ui.com/components/box/>
final Box = ReactJsComponentFactoryProxy(MaterialUI.Box);

/// See: <https://material-ui.com/components/buttons/>
final Button = ReactJsComponentFactoryProxy(MaterialUI.Button);

/// See: <https://material-ui.com/components/checkboxes/>
final Checkbox = ReactJsComponentFactoryProxy(MaterialUI.Checkbox);

/// See: <https://material-ui.com/components/container/>
final Container = ReactJsComponentFactoryProxy(MaterialUI.Container);

/// See: <https://material-ui.com/components/css-baseline/#css-baseline>
final CssBaseline = ReactJsComponentFactoryProxy(MaterialUI.CssBaseline);

/// See: <https://material-ui.com/components/dividers/>
final Divider = ReactJsComponentFactoryProxy(MaterialUI.Divider);

/// See: <https://material-ui.com/components/expansion-panels/>
final ExpansionPanel = ReactJsComponentFactoryProxy(MaterialUI.ExpansionPanel);

/// See: <https://material-ui.com/components/expansion-panels/>
final ExpansionPanelActions = ReactJsComponentFactoryProxy(MaterialUI.ExpansionPanelActions);

/// See: <https://material-ui.com/components/expansion-panels/>
final ExpansionPanelDetails = ReactJsComponentFactoryProxy(MaterialUI.ExpansionPanelDetails);

/// See: <https://material-ui.com/components/expansion-panels/>
final ExpansionPanelSummary = ReactJsComponentFactoryProxy(MaterialUI.ExpansionPanelSummary);

/// See: <https://material-ui.com/components/grid/>
final Grid = ReactJsComponentFactoryProxy(MaterialUI.Grid);

/// See: <https://material-ui.com/components/buttons/#icon-buttons>
final IconButton = ReactJsComponentFactoryProxy(MaterialUI.IconButton);

/// See: <https://material-ui.com/components/text-fields/#customized-inputs>
final InputBase = ReactJsComponentFactoryProxy(MaterialUI.InputBase);

/// See: <https://material-ui.com/components/lists/>
final ListUi = ReactJsComponentFactoryProxy(MaterialUI.List);

/// See: <https://material-ui.com/components/lists/>
final ListItem = ReactJsComponentFactoryProxy(MaterialUI.ListItem);

/// See: <https://material-ui.com/components/menus/>
final Menu = ReactJsComponentFactoryProxy(MaterialUI.Menu);

/// See: <https://material-ui.com/components/menus/>
final MenuItem = ReactJsComponentFactoryProxy(MaterialUI.MenuItem);

/// See: <https://material-ui.com/components/popover/>
final Popover = ReactJsComponentFactoryProxy(MaterialUI.Popover);

/// See: <https://material-ui.com/components/icons/#svgicon>
final SvgIcon = ReactJsComponentFactoryProxy(MaterialUI.SvgIcon);

/// See: <https://material-ui.com/components/text-fields/>
final TextField = ReactJsComponentFactoryProxy(MaterialUI.TextField);

/// See: <https://material-ui.com/components/tooltips/>
final Toolbar = ReactJsComponentFactoryProxy(MaterialUI.Toolbar);

/// See: <https://material-ui.com/components/tooltips/>
final Tooltip = ReactJsComponentFactoryProxy(MaterialUI.Tooltip);

/// See: <https://material-ui.com/components/typography/>
final Typography = ReactJsComponentFactoryProxy(MaterialUI.Typography);

ReactElement TrashIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Delete', ...props}, (Dom.path()
    ..d = 'M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z'
  )());
}

ReactElement ExpandLessIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Collapse', ...props}, (Dom.path()
    ..d = 'M12 8l-6 6 1.41 1.41L12 10.83l4.59 4.58L18 14z6z'
  )());
}

ReactElement ExpandMoreIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Expand', ...props}, (Dom.path()
    ..d = 'M16.59 8.59L12 13.17 7.41 8.59 6 10l6 6 6-6z'
  )());
}

ReactElement GroupIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Users', ...props}, (Dom.path()
    ..d = 'M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z'
  )());
}

ReactElement InfoIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Information', ...props}, (Dom.path()
    ..d = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z'
  )());
}

ReactElement VisibilityIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Visible', ...props}, (Dom.path()
    ..d = 'M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z'
  )());
}

ReactElement VisibilityOffIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Invisible', ...props}, (Dom.path()
    ..d = 'M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z'
  )());
}

/// a.k.a "Create"
ReactElement EditPencilIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Edit', ...props}, (Dom.path()
    ..d = 'M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 00-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z'
  )());
}

ReactElement MenuIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Menu', ...props}, (Dom.path()
    ..d = 'M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z'
  )());
}

ReactElement StorageIcon([Map props = const {}]) {
  return SvgIcon({'aria-label': 'Menu', ...props}, (Dom.path()
    ..d = 'M2 20h20v-4H2v4zm2-3h2v2H4v-2zM2 4v4h20V4H2zm4 3H4V5h2v2zm-4 7h20v-4H2v4zm2-3h2v2H4v-2z'
  )());
}

const shrinkToFitProps = {
  'flexGrow': 0,
  'flexShrink': 0,
  'flexBasis': 'auto',
};

const growProps = {
  'flexGrow': 1,
  'flexShrink': 1,
  'flexBasis': '0%',
};
