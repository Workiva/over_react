import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/toggle_stateful.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/assist_test_base.dart';
import 'boilerplate_assist_utils.dart';

void main() {
  // These tests can't run until this diagnostic is re-enabled in the plugin.
  // defineReflectiveSuite(() {
  //   defineReflectiveTests(AddStatefulnessAssist);
  //   defineReflectiveTests(RemoveStatefulnessAssist);
  // });
}

@reflectiveTest
class AddStatefulnessAssist extends AssistTestBase with BoilerplateAssistTestStrings {
  static int expectedPriority = ToggleComponentStatefulness.statefulAssistPriority;

  @override
  AssistKind get assistKindUnderTest => ToggleComponentStatefulness.makeStateful;

  Future<void> test_noAssist() async {
    final source = newSource('var foo = true;');
    final selection = createSelection(source, '#var foo = true;#');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnFactory() async {
    final generatedSource = simpleUiComponentSource();

    var source = newSource(generatedSource, path: fileName);
    var selection = createSelection(source, r'UiFactory<FooProps> #Foo# = _$Foo;');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnProps() async {
    final generatedSource = simpleUiComponentSource();

    var source = newSource(generatedSource, path: fileName);
    var selection = createSelection(source, 'mixin #FooProps# on UiProps {}');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnOldBoilerplate() async {
    const oldBoilerplate = '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test = _\$Test;

@Props()
class _\$TestProps extends UiProps {}

@Component()
class TestComponent extends UiComponent<TestProps> {
  @override
  render() {}
}
''';

    var source = newSource(oldBoilerplate, path: fileName);
    var selection = createSelection(source, 'class #TestComponent# extends');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnUnknownBase() async {
    const unknownBase = '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

UiFactory<TestProps> Test = _\$Test; // ignore: undefined_identifier

mixin TestProps on UiProps {}

class TestComponent extends AbstractBazComponent<TestProps> {
  @override
  render() {}
}
''';

    var source = newSource(unknownBase, path: fileName);
    var selection = createSelection(source, 'class #TestComponent# extends');
    await expectNoAssist(selection);
  }

  Future<void> test_addsStatefulness() async {
    var retrievedSource = newSource(simpleUiComponentSource(), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource(isStateful: true));
  }

  Future<void> test_addsStatefulnessWithoutDefaultProps() async {
    var retrievedSource = newSource(simpleUiComponentSource(includeDefaultProps: false), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource(isStateful: true, includeDefaultProps: false));
  }

  Future<void> test_addsStatefulnessToFlux() async {
    var retrievedSource = newSource(fluxUiComponentSource(), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, fluxUiComponentSource(isStateful: true));
  }

  Future<void> test_addsStatefulnessToFluxWithoutDefaultProps() async {
    var retrievedSource = newSource(fluxUiComponentSource(includeDefaultProps: false), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, fluxUiComponentSource(isStateful: true, includeDefaultProps: false));
  }
}

@reflectiveTest
class RemoveStatefulnessAssist extends AssistTestBase with BoilerplateAssistTestStrings {
  static int expectedPriority = ToggleComponentStatefulness.statefulAssistPriority;

  @override
  AssistKind get assistKindUnderTest => ToggleComponentStatefulness.makeStateless;

  Future<void> test_noAssist() async {
    final source = newSource('var foo = true;');
    final selection = createSelection(source, '#var foo = true;#');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnFactory() async {
    final generatedSource = simpleUiComponentSource(isStateful: true);

    var source = newSource(generatedSource, path: fileName);
    var selection = createSelection(source, r'UiFactory<FooProps> #Foo# = _$Foo;');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnProps() async {
    final generatedSource = simpleUiComponentSource(isStateful: true);

    var source = newSource(generatedSource, path: fileName);
    var selection = createSelection(source, 'mixin #FooProps# on UiProps {}');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistOnOldBoilerplate() async {
    const oldBoilerplate = '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test = _\$Test;

@Props()
class _\$TestProps extends UiProps {}

@State()
class _\$TestState extends UiState {}

@Component()
class TestComponent extends UiStatefulComponent<TestProps, TestState> {
  @override
  render() {}
}
''';

    var source = newSource(oldBoilerplate, path: fileName);
    var selection = createSelection(source, 'class #TestComponent# extends');
    await expectNoAssist(selection);
  }

  Future<void> test_removesStatefulness() async {
    var retrievedSource = newSource(simpleUiComponentSource(isStateful: true), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource());
  }

  Future<void> test_removesStatefulnessWithNoInitalState() async {
    const statefulComponentWithNoInitialState = r'''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

mixin FooState on UiState {}

class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
  @override
  get defaultProps => (newProps());


  @override
  render() {}
}
''';

    var retrievedSource = newSource(statefulComponentWithNoInitialState, path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, simpleUiComponentSource());
  }

  Future<void> test_removesStatefulnessToFlux() async {
    var retrievedSource = newSource(fluxUiComponentSource(isStateful: true), path: fileName);
    var selection = createSelection(retrievedSource, componentNameSelector);
    final change = await expectAndGetSingleAssist(selection);
    retrievedSource = applySourceChange(change, retrievedSource);
    expect(retrievedSource.contents.data, fluxUiComponentSource());
  }
}
