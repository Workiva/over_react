@TestOn('browser')
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

import 'fixtures/utils.dart';

main() {
  setClientConfiguration();
  if (!muiJsIsAvailable()) return;

  group('MaterialUI', () {
    group('AppBar', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.AppBar component', () {
        expect(AppBar.type.displayName, MaterialUI.AppBar.displayName);
        expect(AppBar({}), isA<ReactElement>());
      });
    });

    group('Avatar', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Avatar component', () {
        expect(Avatar.type.displayName, MaterialUI.Avatar.displayName);
        expect(Avatar({}), isA<ReactElement>());
      });
    });

    group('Badge', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Badge component', () {
        expect(Badge.type.displayName, MaterialUI.Badge.displayName);
        expect(Badge({}), isA<ReactElement>());
      });
    });

    group('Box', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Box component', () {
        expect(Box.type.displayName, MaterialUI.Box.displayName);
        expect(Box({}), isA<ReactElement>());
      });
    });

    group('Button', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Button component', () {
        expect(Button.type.displayName, MaterialUI.Button.displayName);
        expect(Button({}), isA<ReactElement>());
      });
    });

    group('Checkbox', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Checkbox component', () {
        expect(Checkbox.type.displayName, MaterialUI.Checkbox.displayName);
        expect(Checkbox({}), isA<ReactElement>());
      });
    });

    group('Container', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Container component', () {
        expect(Container.type.displayName, MaterialUI.Container.displayName);
        expect(Container({}), isA<ReactElement>());
      });
    });

    group('CssBaseline', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.CssBaseline component', () {
        expect(CssBaseline.type.displayName, MaterialUI.CssBaseline.displayName);
        expect(CssBaseline({}), isA<ReactElement>());
      });
    });

    group('Divider', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Divider component', () {
        expect(Divider.type.displayName, MaterialUI.Divider.displayName);
        expect(Divider({}), isA<ReactElement>());
      });
    });

    group('ExpansionPanel', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.ExpansionPanel component', () {
        expect(ExpansionPanel.type.displayName, MaterialUI.ExpansionPanel.displayName);
        expect(ExpansionPanel({}), isA<ReactElement>());
      });
    });

    group('ExpansionPanelActions', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.ExpansionPanelActions component', () {
        expect(ExpansionPanelActions.type.displayName, MaterialUI.ExpansionPanelActions.displayName);
        expect(ExpansionPanelActions({}), isA<ReactElement>());
      });
    });

    group('ExpansionPanelDetails', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.ExpansionPanelDetails component', () {
        expect(ExpansionPanelDetails.type.displayName, MaterialUI.ExpansionPanelDetails.displayName);
        expect(ExpansionPanelDetails({}), isA<ReactElement>());
      });
    });

    group('ExpansionPanelSummary', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.ExpansionPanelSummary component', () {
        expect(ExpansionPanelSummary.type.displayName, MaterialUI.ExpansionPanelSummary.displayName);
        expect(ExpansionPanelSummary({}), isA<ReactElement>());
      });
    });

    group('Grid', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Grid component', () {
        expect(Grid.type.displayName, MaterialUI.Grid.displayName);
        expect(Grid({}), isA<ReactElement>());
      });
    });

    group('IconButton', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.IconButton component', () {
        expect(IconButton.type.displayName, MaterialUI.IconButton.displayName);
        expect(IconButton({}), isA<ReactElement>());
      });
    });

    group('InputBase', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.InputBase component', () {
        expect(InputBase.type.displayName, MaterialUI.InputBase.displayName);
        expect(InputBase({}), isA<ReactElement>());
      });
    });

    group('ListUi', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.List component', () {
        expect(ListUi.type.displayName, MaterialUI.List.displayName);
        expect(ListUi({}), isA<ReactElement>());
      });
    });

    group('ListItem', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.ListItem component', () {
        expect(ListItem.type.displayName, MaterialUI.ListItem.displayName);
        expect(ListItem({}), isA<ReactElement>());
      });
    });

    group('Menu', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Menu component', () {
        expect(Menu.type.displayName, MaterialUI.Menu.displayName);
        expect(Menu({}), isA<ReactElement>());
      });
    });

    group('MenuItem', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.MenuItem component', () {
        expect(MenuItem.type.displayName, MaterialUI.MenuItem.displayName);
        expect(MenuItem({}), isA<ReactElement>());
      });
    });

    group('Popover', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Popover component', () {
        expect(Popover.type.displayName, MaterialUI.Popover.displayName);
        expect(Popover({}), isA<ReactElement>());
      });
    });

    group('SvgIcon', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.SvgIcon component', () {
        expect(SvgIcon.type.displayName, MaterialUI.SvgIcon.displayName);
        expect(SvgIcon({}), isA<ReactElement>());
      });
    });

    group('TextField', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.TextField component', () {
        expect(TextField.type.displayName, MaterialUI.TextField.displayName);
        expect(TextField({}), isA<ReactElement>());
      });
    });

    group('Toolbar', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Toolbar component', () {
        expect(Toolbar.type.displayName, MaterialUI.Toolbar.displayName);
        expect(Toolbar({}), isA<ReactElement>());
      });
    });

    group('Tooltip', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Tooltip component', () {
        expect(Tooltip.type.displayName, MaterialUI.Tooltip.displayName);
        expect(Tooltip({}), isA<ReactElement>());
      });
    });

    group('Typography', () {
      test('is a ReactJsComponentFactoryProxy of the JS MaterialUI.Typography component', () {
        expect(Typography.type.displayName, MaterialUI.Typography.displayName);
        expect(Typography({}), isA<ReactElement>());
      });
    });
  });
}
