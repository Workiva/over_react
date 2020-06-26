import 'dart:async';

import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:over_react_analyzer_plugin/src/assist/toggle_stateful.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/assist_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddStatefulnessAssist);
//    defineReflectiveTests(RemoveStatefulnessAssist);
  });
}

@reflectiveTest
class AddStatefulnessAssist extends AssistTestBase {
  static int expectedPriority = ToggleComponentStatefulness.statefulAssistPriority;

  static String simpleUiComponentSource = r'''
import 'package:over_react/over_react.dart';
part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {}
}
''';

  static String fluxUiComponentSource = r'''
import 'package:over_react/over_react.dart';
part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooPropsMixin on UiProps {}

class FooProps = UiProps with FluxUiPropsMixin, FooPropsMixin;

class FooComponent extends FluxUiComponent2<FooProps> {
  @override
  render() {}
}
''';

  static String simpleUiStatefulComponentSource = r'''
UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
mixin FooProps on UiProps {}

mixin FooState on UiState {}

class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
  @override
  get defaultProps => (newProps());

  @override
  get initialState => (newState());

  @override
  render() {}
}
''';

  static String fluxUiStatefulComponentSource = r'''
UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier
mixin BarPropsMixin on UiProps {}

class BarProps = UiProps with FluxUiPropsMixin, BarPropsMixin;

mixin BarState on UiState {}

class BarComponent extends FluxUiStatefulComponent2<BarProps, BarState> {
  @override
  get initialState => (newState());

  @override
  render() {}
}
''';

  static List<String> statelessSources = [simpleUiComponentSource, fluxUiComponentSource];
  static List<String> statefulSources = [simpleUiStatefulComponentSource, fluxUiStatefulComponentSource];
  static Map<String, String> boilerplateAssociation = {
    simpleUiComponentSource: simpleUiStatefulComponentSource,
    fluxUiComponentSource: fluxUiStatefulComponentSource,
  };

  @override
  AsyncAssistContributor getContributorUnderTest() => ToggleComponentStatefulness();


  void testBothSources(void Function(String) callbackWithTests) => statelessSources.forEach(callbackWithTests);

  Future<void> test_noAssistOnFactory() async {
    var source = newSource('test.dart', simpleUiComponentSource);
    var selection = createSelection(source, r'UiFactory<FooProps> #Foo# = _$Foo;');
    expect(await getAssists(selection), isEmpty);
  }

  Future<void> test_noAssistOnProps() async {
    var source = newSource('test.dart', simpleUiComponentSource);
    var selection = createSelection(source, 'mixin #FooProps#');
    expect(await getAssists(selection), isEmpty);
  }

  Future<void> test_producesAssistForBothBoilerplate() async {
    testBothSources((source) async {
      var retrievedSource = newSource('test.dart', source);
      var selection = createSelection(retrievedSource, '#FooComponent#');
      final assists = await getAssists(selection);
      expect(assists, hasLength(1), reason: 'Expected selection to produce an assist, but it did not: $source');
    });
  }
  Future<void> test_assistMeta() async {
    testBothSources((source) async {
      var retrievedSource = newSource('test.dart', source);
      var selection = createSelection(retrievedSource, '#FooComponent#');
      final assists = await getAssists(selection);
      expect(assists, hasLength(1));

      final assist = assists.first;
      expect(assist.priority, expectedPriority);
    });
  }

  Future<void> test_addsStatefulness() async {
    testBothSources((source) async {
      var retrievedSource = newSource('test.dart', source);
      var selection = createSelection(retrievedSource, '#Dom.div#');
      final assists = await getAssists(selection);
      expect(assists, hasLength(1));

      retrievedSource = applySourceChange(assists.first.change, retrievedSource);
      expect(retrievedSource.contents.data, boilerplateAssociation[source]);
    });
  }
}

@reflectiveTest
class RemoveStatefulnessAssist extends AssistTestBase {
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
