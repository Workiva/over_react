import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/toggle_stateful.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/assist_test_base.dart';
import 'boilerplate_assist_utils.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddStatefulnessAssist);
    defineReflectiveTests(RemoveStatefulnessAssist);
  });
}

@reflectiveTest
class AddStatefulnessAssist extends AssistTestBase with BoilerplateAssistTestStrings {
  static int expectedPriority = ToggleComponentStatefulness.statefulAssistPriority;

  @override
  AssistKind get assistKindUnderTest => ToggleComponentStatefulness.makeStateful;

  Future<void> test_noAssistOnFactory() async {
    final generatedSource = simpleUiComponentSource();

    var source = newSource(BoilerplateAssistTestStrings.fileName, generatedSource);
    var selection = createSelection(source,
        generatedSource.replaceFirst(r'UiFactory<FooProps> Foo = _$Foo;', r'UiFactory<FooProps> #Foo# = _$Foo;'));
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnProps() async {
    final generatedSource = simpleUiComponentSource();

    var source = newSource(BoilerplateAssistTestStrings.fileName, generatedSource);
    var selection = createSelection(
        source, generatedSource.replaceFirst('mixin FooProps on UiProps {}', 'mixin #FooProps# on UiProps {}'));
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnOldBoilerplate() async {
    String oldBoilerplate({bool withSelection = false}) => '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test = _\$Test;

@Props()
class _\$TestProps extends UiProps {}

@Component()
class ${withSelection ? '#TestComponent#' : 'TestComponent'} extends UiComponent<TestProps> {
  @override
  render() {}
}
''';

    var source = newSource(BoilerplateAssistTestStrings.fileName, oldBoilerplate());
    var selection = createSelection(source, oldBoilerplate(withSelection: true));
    await expectNoAssist(selection);
  }

  Future<void> test_addsStatefulness() async {
    var retrievedSource = newSource(BoilerplateAssistTestStrings.fileName, simpleUiComponentSource());
    var selection = createSelection(retrievedSource, simpleUiComponentSource(shouldIncludeSelection: true));
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource(isStateful: true));
  }

  Future<void> test_addsStatefulnessToFlux() async {
    var retrievedSource = newSource(BoilerplateAssistTestStrings.fileName, fluxUiComponentSource());
    var selection = createSelection(retrievedSource, fluxUiComponentSource(shouldIncludeSelection: true));
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, fluxUiComponentSource(isStateful: true));
  }
}

@reflectiveTest
class RemoveStatefulnessAssist extends AssistTestBase with BoilerplateAssistTestStrings {
  static int expectedPriority = ToggleComponentStatefulness.statefulAssistPriority;

  @override
  AssistKind get assistKindUnderTest => ToggleComponentStatefulness.makeStateless;

  Future<void> test_noAssistOnFactory() async {
    final generatedSource = simpleUiComponentSource(isStateful: true);

    var source = newSource(BoilerplateAssistTestStrings.fileName, generatedSource);
    var selection = createSelection(source,
        generatedSource.replaceFirst(r'UiFactory<FooProps> Foo = _$Foo;', r'UiFactory<FooProps> #Foo# = _$Foo;'));
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnProps() async {
    final generatedSource = simpleUiComponentSource(isStateful: true);

    var source = newSource(BoilerplateAssistTestStrings.fileName, generatedSource);
    var selection = createSelection(
        source, generatedSource.replaceFirst('mixin FooProps on UiProps {}', 'mixin #FooProps# on UiProps {}'));
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnOldBoilerplate() async {
    String oldBoilerplate({bool withSelection = false}) => '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test = _\$Test;

@Props()
class _\$TestProps extends UiProps {}

@State()
class _\$TestState extends UiState {}

@Component()
class ${withSelection ? '#TestComponent#' : 'TestComponent'} extends UiStatefulComponent<TestProps, TestState> {
  @override
  render() {}
}
''';

    var source = newSource(BoilerplateAssistTestStrings.fileName, oldBoilerplate());
    var selection = createSelection(source, oldBoilerplate(withSelection: true));
    await expectNoAssist(selection);
  }

  Future<void> test_removesStatefulness() async {
    var retrievedSource = newSource(BoilerplateAssistTestStrings.fileName, simpleUiComponentSource(isStateful: true));
    var selection =
        createSelection(retrievedSource, simpleUiComponentSource(shouldIncludeSelection: true, isStateful: true));
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource());
  }

  Future<void> test_removesStatefulnessToFlux() async {
    var retrievedSource = newSource(BoilerplateAssistTestStrings.fileName, fluxUiComponentSource(isStateful: true));
    var selection =
        createSelection(retrievedSource, fluxUiComponentSource(shouldIncludeSelection: true, isStateful: true));
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, fluxUiComponentSource());
  }
}
