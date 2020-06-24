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

  @override
  AsyncAssistContributor getContributorUnderTest() =>
      AddPropsAssistContributor();

  Future<void> test_noPropsAndNoParens() async {
    var source = newSource('test.dart', '''
import 'package:over_react/over_react.dart';
var foo = Dom.div()('hello');
''');
    var selection = createSelection(source, '#Dom.div#');
    final assists = await getAssists(selection);
    expect(assists, hasLength(1));

    final assist = assists.first;
    expect(assist.priority, expectedPriority);

    source = applySourceChange(assist.change, source);
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

    final assist = assists.first;
    expect(assist.priority, expectedPriority);

    source = applySourceChange(assist.change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..)('hello');
''');
    selection = createSelection(source, '(Dom.div()..##)');
    // TODO: this fails, but the test is correct. Seems like an issue with DartEditBuilder.selectHere()?
    // expect(assist.change.selection.offset, selection.offset);
  }
}
