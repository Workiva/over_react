// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/create_ref_usage.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(CreateRefUsageDiagnosticTest);
  });
}

@reflectiveTest
class CreateRefUsageDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => CreateRefUsageDiagnostic.code;

  @override
  get fixKindUnderTest => CreateRefUsageDiagnostic.fixKind;

  Future<void> test_noErrorUseRef() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
import 'package:over_react/over_react.dart' hide createRef;

part 'test.over_react.g.dart';

mixin FooProps on UiProps {}

final Foo = uiFunction<FooProps>(
  (props) {
    final ref = useRef();
    
    return (Dom.div()..ref = ref)();
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorNotFromOverReact() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
import 'package:over_react/over_react.dart' hide createRef;

part 'test.over_react.g.dart';

mixin FooProps on UiProps {}

final Foo = uiFunction<FooProps>(
  (props) {
    String createRef() => 'abc';
    
    return Dom.div()(createRef());
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');
    expect(await getAllErrors(source), isEmpty);
  }

  /// Helper function to expect that the `createRef` usage error exists and verify that
  /// the fix will replace it with `useRef`.
  Future<void> _expectErrorAndFix(String input, String expectedOutput) async {
    var source = newSource('test.dart', input);
    final selection = createSelection(source, "#createRef#");

    // Verify error.
    expect((await getAllErrors(source)).single, isAnErrorUnderTest(locatedAt: selection, hasFix: true));

    // Verify fix.
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, expectedOutput);
  }

  Future<void> test_errorFix() async {
    String content(String createRefUsage) => '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {}

final Foo = uiFunction<FooProps>(
  (props) {
    final ref = $createRefUsage();
    
    return (Dom.div()..ref = ref)();
  },
  _\$FooConfig, // ignore: undefined_identifier
);
''';
    await _expectErrorAndFix(content('createRef'), content('useRef'));
  }

  Future<void> test_errorFixWithImportPrefix() async {
    String content(String createRefUsage) => '''
import 'package:over_react/over_react.dart' as or;

part 'test.over_react.g.dart';

mixin FooProps on or.UiProps {}

final Foo = or.uiFunction<FooProps>(
  (props) {
    final ref = or.$createRefUsage();
    
    return (or.Dom.div()..ref = ref)();
  },
  _\$FooConfig, // ignore: undefined_identifier
);
''';
    await _expectErrorAndFix(content('createRef'), content('useRef'));
  }

  Future<void> test_errorFixWithGenerics() async {
    String content(String createRefUsage) => '''
import 'dart:html';

import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {}

final Foo = uiFunction<FooProps>(
  (props) {
    final ref = $createRefUsage<InputElement>();
    
    return (Dom.div()..ref = ref)();
  },
  _\$FooConfig, // ignore: undefined_identifier
);
''';
    await _expectErrorAndFix(content('createRef'), content('useRef'));
  }
}
