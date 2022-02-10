@TestOn('browser')
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

import 'fixtures/utils.dart';

main() {
  if (!muiJsIsAvailable()) return;

  group('MaterialUI', () {
    group('AppBar', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.AppBar component',
          () {
        expect(AppBar.type.displayName, MaterialUI.AppBar.displayName);
        expect(AppBar({}), isA<ReactElement>());
      });
    });

    group('Container', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.Container component',
          () {
        expect(Container.type.displayName, MaterialUI.Container.displayName);
        expect(Container({}), isA<ReactElement>());
      });
    });

    group('ListSubheader', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.ListSubheader component',
          () {
        expect(ListSubheader.type.displayName,
            MaterialUI.ListSubheader.displayName);
        expect(ListSubheader({}), isA<ReactElement>());
      });
    });

    group('Menu', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.Menu component',
          () {
        expect(Menu.type.displayName, MaterialUI.Menu.displayName);
        expect(Menu({}), isA<ReactElement>());
      });
    });

    group('SvgIcon', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.SvgIcon component',
          () {
        expect(SvgIcon.type.displayName, MaterialUI.SvgIcon.displayName);
        expect(SvgIcon({}), isA<ReactElement>());
      });
    });

    group('Toolbar', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.Toolbar component',
          () {
        expect(Toolbar.type.displayName, MaterialUI.Toolbar.displayName);
        expect(Toolbar({}), isA<ReactElement>());
      });
    });

    group('Tooltip', () {
      test(
          'is a ReactJsComponentFactoryProxy of the JS MaterialUI.Tooltip component',
          () {
        expect(Tooltip.type.displayName, MaterialUI.Tooltip.displayName);
        expect(Tooltip({}), isA<ReactElement>());
      });
    });
  });
}
