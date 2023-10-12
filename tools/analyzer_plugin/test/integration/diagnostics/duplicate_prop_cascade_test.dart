import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/duplicate_prop_cascade.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DuplicatePropCascadeDiagnosticTest);
  });
}

@reflectiveTest
class DuplicatePropCascadeDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => DuplicatePropCascadeDiagnostic.code;

  @override
  get fixKindUnderTest => DuplicatePropCascadeDiagnostic.fixKind;

  static const customComponentDefinition = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin CustomProps on UiProps {
  int size;
  bool hidden;
}

final Custom = uiFunction<CustomProps>(
  (props) {
    return null;
  },
  _$CustomConfig, // ignore: undefined_identifier
);
''';

  Future<void> test_noFalsePositives() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final customComponentUsage = (Custom()
  // CustomProps.size / DomProps.size should not be flagged as duplicate 
  // because of a different `enclosingElement` name.
  ..size = 2
  ..dom.size = 2
  // CustomProps.hidden / DomProps.hidden / AriaProps.hidden should not be flagged as duplicate 
  // because of a different prefix and/or differing `enclosingElement` names. 
  ..dom.hidden = false
  ..aria.hidden = false
  ..hidden = false
)();

final domComponentUsage = (Dom.div()
  // DomProps.hidden / AriaProps.hidden should not be flagged as duplicate 
  // because of a different prefix. 
  ..dom.hidden = false
  ..aria.hidden = false
)();
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_dupeDomPropFix() async {
    var source = newSource(/*language=dart*/ r'''
import 'package:over_react/over_react.dart';

final domComponentUsage = (Dom.div()
  ..id = 'def'
  ..dom.id = 'bar'
  ..dom.id = 'baz'
)();
''');
    final allErrors = await getAllErrors(source);
    expect(allErrors, isNotEmpty);

    final selection = createSelection(source, "#..id# = 'def'");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

final domComponentUsage = (Dom.div()
  ..dom.id = 'baz'
)();
''');
  }

  Future<void> test_dupeCustomPropFix() async {
    var source = newSource(/*language=dart*/ '''
$customComponentDefinition

final componentUsage = (Custom()
  ..hidden = false
  ..hidden = true
  ..dom.hidden = false
)();
''');
    final allErrors = await getAllErrors(source);
    expect(allErrors, isNotEmpty);

    final selection = createSelection(source, "#..hidden# = false");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, /*language=dart*/ '''
$customComponentDefinition

final componentUsage = (Custom()
  ..hidden = true
  ..dom.hidden = false
)();
''');
  }

  // ********************************************************
  //  DomProps
  // ********************************************************

  Future<void> test_dupeDomPropWithOnePrefixedKey() async {
    var source = newSource(/*language=dart*/ '''
$customComponentDefinition

final customComponentUsage = (Custom()
  ..id = 'abc'
  ..dom.id = 'foo'
)();

final domComponentUsage = (Dom.div()
  ..id = 'def'
  ..dom.id = 'bar'
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'abc'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'foo'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'def'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'bar'"), hasFix: true),
        ]));
  }

  Future<void> test_dupeDomPropWithMultiplePrefixedKeys() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..id = 'abc'
  ..dom.id = 'foo'
  ..dom.id = 'bar'
)();

final customComponentUsage = (Custom()
  ..id = 'def'
  ..dom.id = 'baz'
  ..dom.id = 'biz'
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'abc'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'foo'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'bar'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'def'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'baz'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'biz'"), hasFix: true),
        ]));
  }

  Future<void> test_dupeDomPropWithAllPrefixedKeys() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..dom.id = 'abc'
  ..dom.id = 'foo'
  ..dom.id = 'bar'
)();

final customComponentUsage = (Custom()
  ..dom.id = 'def'
  ..dom.id = 'baz'
  ..dom.id = 'biz'
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'abc'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'foo'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'bar'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'def'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'baz'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..dom.id# = 'biz'"), hasFix: true),
        ]));
  }

  Future<void> test_dupeDomPropWithNoPrefixedKeys() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..id = 'abc'
  ..id = 'foo'
  ..id = 'bar'
)();

final customComponentUsage = (Custom()
  ..id = 'def'
  ..id = 'baz'
  ..id = 'biz'
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'abc'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'foo'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'bar'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'def'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'baz'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..id# = 'biz'"), hasFix: true),
        ]));
  }

  // We currently don't support flagging dupes when a key is added using `..addProps(domProps()..key)`, but
  // we run a test here to verify that no lint is shown, and that the plugin doesn't crash.
  Future<void> test_noDupeAndNoPluginCrashWhenUsingAddPropsDomPropsAndPrefixedKey() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..id = 'def'
  ..addProps(domProps()..id = 'abc')
)();

final domComponentUsagePrefixed = (Dom.div()
  ..dom.id = 'def'
  ..addProps(domProps()..id = 'abc')
)();

final customComponentUsage = (Custom()
  ..id = 'abc'
  ..addProps(domProps()..id = 'def')
)();

final customComponentUsagePrefixed = (Custom()
  ..dom.id = 'abc'
  ..addProps(domProps()..id = 'def')
)();
''');
    expect(await getAllErrors(source), isEmpty);
  }

  // ********************************************************
  //  AriaProps
  // ********************************************************

  Future<void> test_dupeAriaPropWithAllPrefixedKeys() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..aria.label = 'oh'
  ..aria.label = 'hai'
)();

final customComponentUsage = (Custom()
  ..aria.hidden = true
  ..aria.hidden = false
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..aria.label# = 'oh'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..aria.label# = 'hai'"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..aria.hidden# = true"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..aria.hidden# = false"), hasFix: true),
        ]));
  }

  // We currently don't support flagging dupes when a key is added using `..addProps(ariaProps()..key)`, but
  // we run a test here to verify that no lint is shown, and that the plugin doesn't crash.
  Future<void> test_noDupeAndNoPluginCrashWhenUsingAddPropsAriaProps() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final domComponentUsage = (Dom.div()
  ..aria.hidden = false
  // Work around dart:collection's MapView not existing in MockSdk, and thus AriaPropsMapView not being a Map.
  ..addProps((ariaProps()..hidden = true) as Map)
)();

final customComponentUsage = (Custom()
  ..aria.hidden = true
  // Work around dart:collection's MapView not existing in MockSdk, and thus AriaPropsMapView not being a Map.
  ..addProps((ariaProps()..hidden = false) as Map)
)();
''');
    expect(await getAllErrors(source), isEmpty);
  }

  // ********************************************************
  //  CustomProps
  // ********************************************************

  Future<void> test_dupeCustomProp() async {
    final source = newSource(/*language=dart*/ '''
$customComponentDefinition

final usage = (Custom()
  ..dom.size = 0
  ..size = 1
  ..size = 2
  ..size = 3
  ..hidden = true
  ..hidden = false
)();
''');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..size# = 1"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..size# = 2"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..size# = 3"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..hidden# = true"), hasFix: true),
          isAnErrorUnderTest(locatedAt: createSelection(source, "#..hidden# = false"), hasFix: true),
        ]));
  }
}
