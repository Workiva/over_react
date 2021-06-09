// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/assist_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddPropsAssistTest);
  });
}

@reflectiveTest
class AddPropsAssistTest extends AssistTestBase {
  @override
  AssistKind get assistKindUnderTest => AddPropsAssistContributor.addPropsKind;

  static String simpleSource = '''
import 'package:over_react/over_react.dart';
var foo = Dom.div()('hello');
''';

  Future<void> test_noAssist() async {
    final source = newSource('test.dart', 'var foo = true;');
    final selection = createSelection(source, '#var foo = true;#');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistForSelection() async {
    final source = newSource('test.dart', simpleSource);
    final selection = createSelection(source, '#var foo#');
    await expectNoAssist(selection);
  }

  Future<void> test_producesAssistForAllSelectionTypes() => expectAllSelectionsProduceSingleAssist(simpleSource, [
        '##Dom.div', // empty selection at beginning
        'Dom.div##', // empty selection at end
        'Dom.##div', // empty selection within
        '#Dom.div#', // range starting at beginning
        '#Dom.div()#', // range extending beyond end
        'Do#m.d#iv', // range within
      ]);

  Future<void> test_addsParensAndPropsCascade() async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, '#Dom.div#');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..)('hello');
''');
    selection = createSelection(source, '(Dom.div()..##)');
    // TODO: this fails, but the test is correct. Seems like an issue with DartEditBuilder.selectHere()?
    // expect(change.selection.offset, selection.offset);
  }

  Future<void> test_alreadyHasParens() async {
    var source = newSource('test.dart', '''
import 'package:over_react/over_react.dart';
var foo = (Dom.div())('hello');
''');
    var selection = createSelection(source, '#Dom.div#');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..)('hello');
''');
    selection = createSelection(source, '(Dom.div()..##)');
    // TODO: this fails, but the test is correct. Seems like an issue with DartEditBuilder.selectHere()?
    // expect(assist.change.selection.offset, selection.offset);
  }
}
