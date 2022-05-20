// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/callback_ref.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(CallbackRefDiagnosticFnComponentTest);
  });
}

abstract class CallbackRefDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => CallbackRefDiagnostic.code;

  @override
  get fixKindUnderTest => CallbackRefDiagnostic.fixKind;

  static const refVarDeclarations = '''
    ChildComponent _someCustomRefName;
    ChildComponent _anotherCustomRefName;''';

  static const refVarDeclarationsFixedSome = '''
    final _someCustomRefName = useRef<dynamic>();
    ChildComponent _anotherCustomRefName;''';

  static const refVarDeclarationsFixedTheRest = '''
    final _someCustomRefName = useRef<dynamic>();
    final _anotherCustomRefName = useRef<dynamic>();''';

  static const refUsage = '''
    void foo() {
      _someCustomRefName.someMethodName();
      _someCustomRefName?.anotherMethodName();
      final bar = _someCustomRefName.someGetter;

      _anotherCustomRefName.someMethodName();
      _anotherCustomRefName?.anotherMethodName();
      final baz = _anotherCustomRefName.someGetter;
    }''';

  static const refUsageFixedSome = '''
    void foo() {
      _someCustomRefName.current.someMethodName();
      _someCustomRefName.current?.anotherMethodName();
      final bar = _someCustomRefName.current.someGetter;

      _anotherCustomRefName.someMethodName();
      _anotherCustomRefName?.anotherMethodName();
      final baz = _anotherCustomRefName.someGetter;
    }''';

  static const refUsageFixedTheRest = '''
    void foo() {
      _someCustomRefName.current.someMethodName();
      _someCustomRefName.current?.anotherMethodName();
      final bar = _someCustomRefName.current.someGetter;

      _anotherCustomRefName.current.someMethodName();
      _anotherCustomRefName.current?.anotherMethodName();
      final baz = _anotherCustomRefName.current.someGetter;
    }''';

  static const renderReturn = '''
    return Fragment()(
      (Child()
        ..ref = (ref) {
          _someCustomRefName = ref;
        })(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _anotherCustomRefName = ref)
      )('hi'),
      (Child())('there'),
    );
  ''';

  static const renderReturnFixedSome = '''
    return Fragment()(
      (Child()
        ..ref = _someCustomRefName)(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _anotherCustomRefName = ref)
      )('hi'),
      (Child())('there'),
    );
  ''';

  static const renderReturnFixedTheRest = '''
    return Fragment()(
      (Child()
        ..ref = _someCustomRefName)(props.children),
      (Child()
        ..id = 'bar'
        ..ref = _anotherCustomRefName
      )('hi'),
      (Child())('there'),
    );
  ''';

  static const selectionToFixSome = '''#(ref) {
          _someCustomRefName = ref;
        }#''';

  static const selectionToFixAnother = '''#((ref) => _anotherCustomRefName = ref)#''';
}

@reflectiveTest
class CallbackRefDiagnosticFnComponentTest extends CallbackRefDiagnosticTest {
  static const usageSourceWithinFnComponent = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ${CallbackRefDiagnosticTest.refVarDeclarations}

    ${CallbackRefDiagnosticTest.refUsage}

    ${CallbackRefDiagnosticTest.renderReturn}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedSome = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ${CallbackRefDiagnosticTest.refVarDeclarationsFixedSome}

    ${CallbackRefDiagnosticTest.refUsageFixedSome}

    ${CallbackRefDiagnosticTest.renderReturnFixedSome}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedTheRest = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ${CallbackRefDiagnosticTest.refVarDeclarationsFixedTheRest}

    ${CallbackRefDiagnosticTest.refUsageFixedTheRest}

    ${CallbackRefDiagnosticTest.renderReturnFixedTheRest}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  Future<void> test_someCustomRefError() async {
    final source = newSource('test.dart', usageSourceWithinFnComponent);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixSome));
  }

  Future<void> test_someCustomRefErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinFnComponent);
    final errorFix = await expectSingleErrorFix(createSelection(source, CallbackRefDiagnosticTest.selectionToFixSome));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedSome);
  }

  Future<void> test_anotherCustomRefError() async {
    final source = newSource('test.dart', usageSourceWithinFnComponentFixedSome);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixAnother));
  }

  Future<void> test_anotherCustomRefErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinFnComponentFixedSome);
    final errorFix =
        await expectSingleErrorFix(createSelection(source, CallbackRefDiagnosticTest.selectionToFixAnother));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedTheRest);
  }
}

@reflectiveTest
class CallbackRefDiagnosticClassComponentTest extends CallbackRefDiagnosticTest {
  static const usageSourceWithinClassComponent = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  ${CallbackRefDiagnosticTest.refVarDeclarations}

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturn}
  }

  ${CallbackRefDiagnosticTest.refUsage}
}
''';

  static const usageSourceWithinClassComponentFixedSome = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  ${CallbackRefDiagnosticTest.refVarDeclarationsFixedSome}

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturnFixedSome}
  }

  ${CallbackRefDiagnosticTest.refUsageFixedSome}
}
''';

  static const usageSourceWithinClassComponentFixedTheRest = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  ${CallbackRefDiagnosticTest.refVarDeclarationsFixedTheRest}

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturnFixedTheRest}
  }

  ${CallbackRefDiagnosticTest.refUsageFixedTheRest}
}
''';

  Future<void> test_someCustomRefError() async {
    final source = newSource('test.dart', usageSourceWithinClassComponent);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixSome));
  }

  Future<void> test_someCustomRefErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinClassComponent);
    final errorFix = await expectSingleErrorFix(createSelection(source, CallbackRefDiagnosticTest.selectionToFixSome));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinClassComponentFixedSome);
  }

  Future<void> test_anotherCustomRefError() async {
    final source = newSource('test.dart', usageSourceWithinClassComponentFixedSome);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixAnother));
  }

  Future<void> test_anotherCustomRefErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinClassComponentFixedSome);
    final errorFix =
        await expectSingleErrorFix(createSelection(source, CallbackRefDiagnosticTest.selectionToFixAnother));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinClassComponentFixedTheRest);
  }
}
