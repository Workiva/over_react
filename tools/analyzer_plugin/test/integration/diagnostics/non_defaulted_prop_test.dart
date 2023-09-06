// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/non_defaulted_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NonDefaultedPropDiagnosticTest);
  });
}

@reflectiveTest
class NonDefaultedPropDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => NonDefaultedPropDiagnostic.code;

  @override
  get fixKindUnderTest => NonDefaultedPropDiagnostic.fixKind;

  Future<void> test_noErrorDefaultUsed() async {
    final source = newSource(null, /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String content;
  bool hidden;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final content = props.content ?? 10;
    
    return (Dom.div()
      ..hidden = props.hidden
    )(content);
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorSameNameButNotDefault() async {
    final source = newSource(null, /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String content;
  bool hidden;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final content = 'abc';
    
    return (Dom.div()
      ..hidden = props.hidden
    )(props.content);
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_errorFix() async {
    String contents(String propUsage) => '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String content;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final content = props.content ?? 'abc';
    
    return Dom.div()($propUsage);
  },
  _\$FooConfig, // ignore: undefined_identifier
);
''';
    var source = newSource(null, contents('props.content'));
    final selection = createSelection(source, "(#props.content#)");

    // Verify error.
    await expectSingleErrorAt(selection);

    // Verify fix.
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, contents('content'));
  }

  Future<void> test_errorFixWithDifferentName() async {
    String contents(String propUsage) => '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String content;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final defaultContent = props.content ?? 'abc';
    
    return Dom.div()($propUsage);
  },
  _\$FooConfig, // ignore: undefined_identifier
);
''';
    var source = newSource(null, contents('props.content'));
    final selection = createSelection(source, "(#props.content#)");

    // Verify error.
    await expectSingleErrorAt(selection);

    // Verify fix.
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, contents('defaultContent'));
  }

  Future<void> test_multipleErrorsAndFixes() async {
    var source = newSource(null, /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String fooId;
  bool hidden;
  String moreContent;
  String name;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final fooId = props.fooId ?? 'abc';
    final name = props.name ?? 'Jane';
    
    // Some other logic
    void helperFunction() => print('hello');
    const a = 25;
    // Some other logic
    
    final defaultHidden = props.hidden ?? false;
    
    final content = (Dom.div()..hidden = defaultHidden)(props.name);
    
    return (Dom.div()
      ..id = props.fooId
      ..hidden = props.hidden
    )(content, props.moreContent);
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');

    final allErrors = await getAllErrors(source);
    expect(allErrors, hasLength(3));

    final errorSelections = [
      createSelection(source, '..hidden = #props.hidden#'),
      createSelection(source, '..id = #props.fooId#'),
      createSelection(source, '(#props.name#)'),
    ];
    for (final selection in errorSelections) {
      expect(allErrors, contains(isAnErrorUnderTest(locatedAt: selection, hasFix: true)));
      final errorFix = await expectSingleErrorFix(selection);
      expect(errorFix.fixes.single.change.selection, isNull);
      source = applyErrorFixes(errorFix, source);
    }

    expect(source.contents.data, /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

mixin FooProps on UiProps {
  String fooId;
  bool hidden;
  String moreContent;
  String name;
}

final Foo = uiFunction<FooProps>(
  (props) {
    final fooId = props.fooId ?? 'abc';
    final name = props.name ?? 'Jane';
    
    // Some other logic
    void helperFunction() => print('hello');
    const a = 25;
    // Some other logic
    
    final defaultHidden = props.hidden ?? false;
    
    final content = (Dom.div()..hidden = defaultHidden)(name);
    
    return (Dom.div()
      ..id = fooId
      ..hidden = defaultHidden
    )(content, props.moreContent);
  },
  _$FooConfig, // ignore: undefined_identifier
);
''');
  }
}
