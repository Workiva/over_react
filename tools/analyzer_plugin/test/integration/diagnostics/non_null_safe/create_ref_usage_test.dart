// This file is a non-null safe copy of diagnostics tests.
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/create_ref_usage.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_bases/diagnostic_test_base.dart';

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

  Future<void> test_noErrorFunction() async {
    final source = newSource(/*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';

ReactElement someFunction(Map props) {
  final ref = createRef();
  
  return (Dom.div()..ref = ref)();
}
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorClassComponent() async {
    final source = newSource(/*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {
    final ref = createRef();
    return (Dom.div()..ref = ref)();
  }
}
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorUseRef() async {
    final source = newSource(/*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart' hide createRef;

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
    final source = newSource(/*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart' hide createRef;

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
    var source = newSource(input);
    expectedOutput = substituteSource(expectedOutput, path: source.uri.path);
    final selection = createSelection(source, "#createRef#");

    // Verify error.
    await expectSingleErrorAt(selection);

    // Verify fix.
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, expectedOutput);
  }

  Future<void> test_errorFix() async {
    String content(String createRefUsage) => '''
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
// @dart=2.11
import 'package:over_react/over_react.dart' as or;

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
