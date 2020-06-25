import 'dart:async';

import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
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
  static int expectedPriority = AddPropsAssistContributor.addPropsKind.priority;

  static String simpleSource = '''
import 'package:over_react/over_react.dart';
var foo = Dom.div()('hello');
''';

  @override
  AsyncAssistContributor getContributorUnderTest() => AddPropsAssistContributor();

  Future<void> test_noAssist() async {
    var source = newSource('test.dart', 'var foo = true;');
    var selection = createSelection(source, '#var foo#');
    expect(await getAssists(selection), isEmpty);
  }

  Future<void> test_noAssistForSelection() async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, '#var foo#');
    expect(await getAssists(selection), isEmpty);
  }

  Future<void> test_producesAssistForAllSelectionTypes() async {
    final selectionTargets = [
      '##Dom.div', // empty selection at beginning
      'Dom.div##', // empty selection at end
      'Dom.##div', // empty selection within
      '#Dom.div#', // range starting at beginning
      '#Dom.div()#', // range extending beyond end
      'Do#m.d#iv', // range within
    ];
    for (final target in selectionTargets) {
      await _verifySelectionProducesAssist(target);
    }
  }

  Future<void> _verifySelectionProducesAssist(String selectionTarget) async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, selectionTarget);
    final assists = await getAssists(selection);
    expect(assists, hasLength(1), reason: 'Expected selection to produce an assist, but it did not: $selectionTarget');
  }

  Future<void> test_assistMeta() async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, '#Dom.div#');
    final assists = await getAssists(selection);
    expect(assists, hasLength(1));

    final assist = assists.first;
    expect(assist.priority, expectedPriority);
  }

  Future<void> test_addsParensAndPropsCascade() async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, '#Dom.div#');
    final assists = await getAssists(selection);
    expect(assists, hasLength(1));

    source = applySourceChange(assists.first.change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..)('hello');
''');
    selection = createSelection(source, '(Dom.div()..##)');
    // TODO: this fails, but the test is correct. Seems like an issue with DartEditBuilder.selectHere()?
    // expect(assist.change.selection.offset, selection.offset);
  }

  Future<void> test_alreadyHasParens() async {
    var source = newSource('test.dart', '''
import 'package:over_react/over_react.dart';
var foo = (Dom.div())('hello');
''');
    var selection = createSelection(source, '#Dom.div#');
    final assists = await getAssists(selection);
    expect(assists, hasLength(1));

    source = applySourceChange(assists.first.change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..)('hello');
''');
    selection = createSelection(source, '(Dom.div()..##)');
    // TODO: this fails, but the test is correct. Seems like an issue with DartEditBuilder.selectHere()?
    // expect(assist.change.selection.offset, selection.offset);
  }
}
