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
    defineReflectiveTests(CallbackRefDiagnosticClassComponentTest);
    defineReflectiveTests(CallbackRefDiagnosticFnComponentTestNoFix);
    defineReflectiveTests(CallbackRefDiagnosticClassComponentTestNoFix);
  });
}

abstract class CallbackRefDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => CallbackRefDiagnostic.code;

  @override
  get fixKindUnderTest => null;

  static const refUsage = '''
    void _tearOffRefAssignment(ChildComponent ref) {
      _customRefAssignedInTearoff = ref;
    }

    void foo() {
      _customRefAssignedInBlockFnBody.someMethodName();
      _customRefAssignedInBlockFnBody?.anotherMethodName();
      final bar = _customRefAssignedInBlockFnBody.someGetter;

      _customRefAssignedInArrowFn.someMethodName();
      _customRefAssignedInArrowFn?.anotherMethodName();
      final baz = _customRefAssignedInArrowFn.someGetter;
      
      _customRefAssignedInTearoff.someMethodName();
      _customRefAssignedInTearoff?.anotherMethodName();
      final biz = _customRefAssignedInTearoff.someGetter;
    }''';

  static const refUsageFixedBlockFnBodyRefAssignment = '''
    void _tearOffRefAssignment(ChildComponent ref) {
      _customRefAssignedInTearoff = ref;
    }

    void foo() {
      _customRefAssignedInBlockFnBody.current.someMethodName();
      _customRefAssignedInBlockFnBody.current?.anotherMethodName();
      final bar = _customRefAssignedInBlockFnBody.current.someGetter;

      _customRefAssignedInArrowFn.someMethodName();
      _customRefAssignedInArrowFn?.anotherMethodName();
      final baz = _customRefAssignedInArrowFn.someGetter;
      
      _customRefAssignedInTearoff.someMethodName();
      _customRefAssignedInTearoff?.anotherMethodName();
      final biz = _customRefAssignedInTearoff.someGetter;
    }''';

  static const refUsageFixedArrowFnRefAssignment = '''
    void _tearOffRefAssignment(ChildComponent ref) {
      _customRefAssignedInTearoff = ref;
    }

    void foo() {
      _customRefAssignedInBlockFnBody.current.someMethodName();
      _customRefAssignedInBlockFnBody.current?.anotherMethodName();
      final bar = _customRefAssignedInBlockFnBody.current.someGetter;

      _customRefAssignedInArrowFn.current.someMethodName();
      _customRefAssignedInArrowFn.current?.anotherMethodName();
      final baz = _customRefAssignedInArrowFn.current.someGetter;
      
      _customRefAssignedInTearoff.someMethodName();
      _customRefAssignedInTearoff?.anotherMethodName();
      final biz = _customRefAssignedInTearoff.someGetter;
    }''';

  static const renderReturn = '''
    return Fragment()(
      (Child()
        ..ref = (ref) {
          _customRefAssignedInBlockFnBody = ref;
        })(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _customRefAssignedInArrowFn = ref)
      )('hi'),
      (Child()
        ..id = 'biz'
        ..ref = _tearOffRefAssignment
      )('yo'),
      (Child())('there'),
    );
  ''';

  static const renderReturnFixedBlockFnBodyRefAssignment = '''
    return Fragment()(
      (Child()
        ..ref = _customRefAssignedInBlockFnBody)(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _customRefAssignedInArrowFn = ref)
      )('hi'),
      (Child()
        ..id = 'biz'
        ..ref = _tearOffRefAssignment
      )('yo'),
      (Child())('there'),
    );
  ''';

  static const renderReturnFixedArrowFnRefAssignment = '''
    return Fragment()(
      (Child()
        ..ref = _customRefAssignedInBlockFnBody)(props.children),
      (Child()
        ..id = 'bar'
        ..ref = _customRefAssignedInArrowFn
      )('hi'),
      (Child()
        ..id = 'biz'
        ..ref = _tearOffRefAssignment
      )('yo'),
      (Child())('there'),
    );
  ''';

  static const selectionToFixBlockFnBodyRefAssignment = '''#(ref) {
          _customRefAssignedInBlockFnBody = ref;
        }#''';

  static const selectionToFixArrowFnRefAssignment = '''#((ref) => _customRefAssignedInArrowFn = ref)#''';

  static const selectionForTearoffRefAssignmentError = '''..ref = #_tearOffRefAssignment#''';
}

abstract class CallbackRefDiagnosticWithFixTest extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => CallbackRefDiagnostic.fixKind;
}

@reflectiveTest
class CallbackRefDiagnosticFnComponentTest extends CallbackRefDiagnosticWithFixTest {
  static const usageSourceWithinFnComponent = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ChildComponent _customRefAssignedInBlockFnBody;
    ChildComponent _customRefAssignedInArrowFn;
    ChildComponent _customRefAssignedInTearoff;

    ${CallbackRefDiagnosticTest.refUsage}

    ${CallbackRefDiagnosticTest.renderReturn}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    final _customRefAssignedInBlockFnBody = useRef<dynamic>();
    ChildComponent _customRefAssignedInArrowFn;
    ChildComponent _customRefAssignedInTearoff;

    ${CallbackRefDiagnosticTest.refUsageFixedBlockFnBodyRefAssignment}

    ${CallbackRefDiagnosticTest.renderReturnFixedBlockFnBodyRefAssignment}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedArrowFnRefAssignment = '''
import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    final _customRefAssignedInBlockFnBody = useRef<dynamic>();
    final _customRefAssignedInArrowFn = useRef<dynamic>();
    ChildComponent _customRefAssignedInTearoff;

    ${CallbackRefDiagnosticTest.refUsageFixedArrowFnRefAssignment}

    ${CallbackRefDiagnosticTest.renderReturnFixedArrowFnRefAssignment}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  Future<void> test_blockFnBodyRefAssignment() async {
    final source = newSource('test.dart', usageSourceWithinFnComponent);
    await expectSingleErrorAt(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
  }

  Future<void> test_blockFnBodyRefAssignmentFix() async {
    var source = newSource('test.dart', usageSourceWithinFnComponent);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
  }

  Future<void> test_arrowFnRefAssignmentError() async {
    final source = newSource('test.dart', usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
  }

  Future<void> test_arrowFnRefAssignmentErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedArrowFnRefAssignment);
  }
}

@reflectiveTest
class CallbackRefDiagnosticFnComponentTestNoFix extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => null;

  Future<void> test_tearoffFnRefAssignment() async {
    final source = newSource('test.dart', CallbackRefDiagnosticFnComponentTest.usageSourceWithinFnComponent);
    final selection = createSelection(source, CallbackRefDiagnosticTest.selectionForTearoffRefAssignmentError);
    await expectSingleErrorAt(selection);
    // We intentionally do not want the diagnostic to suggest a fix since
    // the `addUseOrCreateRef` utility that builds the fix currently can't handle that use case.
    await expectNoErrorFix(selection);
  }
}

@reflectiveTest
class CallbackRefDiagnosticClassComponentTest extends CallbackRefDiagnosticWithFixTest {
  static const usageSourceWithinClassComponent = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  ChildComponent _customRefAssignedInBlockFnBody;
  ChildComponent _customRefAssignedInArrowFn;
  ChildComponent _customRefAssignedInTearoff;

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturn}
  }

  ${CallbackRefDiagnosticTest.refUsage}
}
''';

  static const usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  final _customRefAssignedInBlockFnBody = createRef<dynamic>();
  ChildComponent _customRefAssignedInArrowFn;
  ChildComponent _customRefAssignedInTearoff;

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturnFixedBlockFnBodyRefAssignment}
  }

  ${CallbackRefDiagnosticTest.refUsageFixedBlockFnBodyRefAssignment}
}
''';

  static const usageSourceWithinClassComponentFixedArrowFnRefAssignment = '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

UiFactory<UsesCallbackRefProps> UsesCallbackRef = castUiFactory(_\$UsesCallbackRef); // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  final _customRefAssignedInBlockFnBody = createRef<dynamic>();
  final _customRefAssignedInArrowFn = createRef<dynamic>();
  ChildComponent _customRefAssignedInTearoff;

  @override
  render() {
    ${CallbackRefDiagnosticTest.renderReturnFixedArrowFnRefAssignment}
  }

  ${CallbackRefDiagnosticTest.refUsageFixedArrowFnRefAssignment}
}
''';

  Future<void> test_blockFnBodyRefAssignment() async {
    final source = newSource('test.dart', usageSourceWithinClassComponent);
    await expectSingleErrorAt(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
  }

  Future<void> test_blockFnBodyRefAssignmentFix() async {
    var source = newSource('test.dart', usageSourceWithinClassComponent);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment);
  }

  Future<void> test_arrowFnRefAssignmentError() async {
    final source = newSource('test.dart', usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
  }

  Future<void> test_arrowFnRefAssignmentErrorFix() async {
    var source = newSource('test.dart', usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinClassComponentFixedArrowFnRefAssignment);
  }
}

@reflectiveTest
class CallbackRefDiagnosticClassComponentTestNoFix extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => null;

  Future<void> test_tearoffFnRefAssignment() async {
    final source = newSource('test.dart', CallbackRefDiagnosticClassComponentTest.usageSourceWithinClassComponent);
    final selection = createSelection(source, CallbackRefDiagnosticTest.selectionForTearoffRefAssignmentError);
    await expectSingleErrorAt(selection);
    // We intentionally do not want the diagnostic to suggest a fix since
    // the `addUseOrCreateRef` utility that builds the fix currently can't handle that use case.
    await expectNoErrorFix(selection);
  }
}
