import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
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
  AssistKind get assistKindUnderTest => ToggleComponentStatefulness.makeStateful;

  void testBothSources(void Function(String) callbackWithTests) => statelessSources.forEach(callbackWithTests);

  Future<void> test_noAssistOnFactory() async {
    var source = newSource('test.dart', simpleUiComponentSource);
    var selection = createSelection(source, r'UiFactory<FooProps> #Foo# = _$Foo;');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnProps() async {
    var source = newSource('test.dart', simpleUiComponentSource);
    var selection = createSelection(source, 'mixin #FooProps#');
    await expectNoAssist(selection);
  }

  Future<void> test_producesAssistForBothBoilerplate() async {
    testBothSources((source) async {
      var retrievedSource = newSource('test.dart', source);
      var selection = createSelection(retrievedSource, '#FooComponent#');
      await expectAndGetSingleAssist(selection);
    });
  }

  Future<void> test_addsStatefulness() async {
    testBothSources((source) async {
      var retrievedSource = newSource('test.dart', source);
      var selection = createSelection(retrievedSource, '#Dom.div#');
      final change = await expectAndGetSingleAssist(selection);
      retrievedSource = applySourceChange(change, retrievedSource);
      expect(retrievedSource.contents.data, boilerplateAssociation[source]);
    });
  }
}
