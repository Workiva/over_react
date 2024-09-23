// This file is a non-null safe copy of diagnostics tests.
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/callback_ref.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_bases/diagnostic_test_base.dart';

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
      
      _aDomRef?.detached();
      final abc = _aDomRef?.offset;
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
      
      _aDomRef?.detached();
      final abc = _aDomRef?.offset;
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
      
      _aDomRef?.detached();
      final abc = _aDomRef?.offset;
    }''';

  static const refUsageDomRefAssignment = '''
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
      
      _aDomRef.current?.detached();
      final abc = _aDomRef.current?.offset;
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
      (Dom.div()
        ..ref = (ref) {
          _aDomRef = ref;
        })(),
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
      (Dom.div()
        ..ref = (ref) {
          _aDomRef = ref;
        })(),
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
      (Dom.div()
        ..ref = (ref) {
          _aDomRef = ref;
        })(),
    );
  ''';

  static const renderReturnDomRefAssignment = '''
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
      (Dom.div()
        ..ref = _aDomRef)(),
    );
  ''';

  static const selectionToFixBlockFnBodyRefAssignment = '''#(ref) {
          _customRefAssignedInBlockFnBody = ref;
        }#''';

  static const selectionToFixArrowFnRefAssignment = '''#((ref) => _customRefAssignedInArrowFn = ref)#''';

  static const selectionForTearoffRefAssignmentError = '''..ref = #_tearOffRefAssignment#''';

  static const selectionForDomRefAssignmentError = '''#(ref) {
          _aDomRef = ref;
        }#''';
}

abstract class CallbackRefDiagnosticWithFixTest extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => CallbackRefDiagnostic.fixKind;
}

@reflectiveTest
class CallbackRefDiagnosticFnComponentTest extends CallbackRefDiagnosticWithFixTest {
  static const usageSourceWithinFnComponent = '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ChildComponent _customRefAssignedInBlockFnBody;
    ChildComponent _customRefAssignedInArrowFn;
    ChildComponent _customRefAssignedInTearoff;
    Element _aDomRef;

    ${CallbackRefDiagnosticTest.refUsage}

    ${CallbackRefDiagnosticTest.renderReturn}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment = '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    final _customRefAssignedInBlockFnBody = useRef<dynamic>();
    ChildComponent _customRefAssignedInArrowFn;
    ChildComponent _customRefAssignedInTearoff;
    Element _aDomRef;

    ${CallbackRefDiagnosticTest.refUsageFixedBlockFnBodyRefAssignment}

    ${CallbackRefDiagnosticTest.renderReturnFixedBlockFnBodyRefAssignment}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedArrowFnRefAssignment = '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    final _customRefAssignedInBlockFnBody = useRef<dynamic>();
    final _customRefAssignedInArrowFn = useRef<dynamic>();
    ChildComponent _customRefAssignedInTearoff;
    Element _aDomRef;

    ${CallbackRefDiagnosticTest.refUsageFixedArrowFnRefAssignment}

    ${CallbackRefDiagnosticTest.renderReturnFixedArrowFnRefAssignment}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  static const usageSourceWithinFnComponentFixedDomRefAssignment = '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    final _customRefAssignedInBlockFnBody = useRef<dynamic>();
    final _customRefAssignedInArrowFn = useRef<dynamic>();
    ChildComponent _customRefAssignedInTearoff;
    final _aDomRef = useRef<Element>();

    ${CallbackRefDiagnosticTest.refUsageDomRefAssignment}

    ${CallbackRefDiagnosticTest.renderReturnDomRefAssignment}
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
''';

  Future<void> test_blockFnBodyRefAssignment() async {
    final source = newSource(usageSourceWithinFnComponent);
    await expectSingleErrorAt(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
  }

  Future<void> test_blockFnBodyDomRefAssignment() async {
    final source = newSource(usageSourceWithinFnComponent);
    await expectSingleErrorAt(
        createSelection(source, CallbackRefDiagnosticTest.selectionForDomRefAssignmentError));
  }

  Future<void> test_blockFnBodyRefAssignmentFix() async {
    var source = newSource(usageSourceWithinFnComponent);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
  }

  Future<void> test_arrowFnRefAssignmentError() async {
    final source = newSource(usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
  }

  Future<void> test_arrowFnRefAssignmentErrorFix() async {
    var source = newSource(usageSourceWithinFnComponentFixedBlockFnBodyRefAssignment);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedArrowFnRefAssignment);
  }

  Future<void> test_blockFnBodyDomRefAssignmentFix() async {
    var source = newSource(usageSourceWithinFnComponentFixedArrowFnRefAssignment);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionForDomRefAssignmentError));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, usageSourceWithinFnComponentFixedDomRefAssignment);
  }
}

@reflectiveTest
class CallbackRefDiagnosticFnComponentTestNoFix extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => null;

  Future<void> test_tearoffFnRefAssignment() async {
    final source = newSource(CallbackRefDiagnosticFnComponentTest.usageSourceWithinFnComponent);
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
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

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
    final source = newSource(usageSourceWithinClassComponent);
    await expectSingleErrorAt(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
  }

  Future<void> test_blockFnBodyRefAssignmentFix() async {
    var source = newSource(usageSourceWithinClassComponent);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixBlockFnBodyRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data,
        substituteSource(usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment, path: source.uri.path));
  }

  Future<void> test_arrowFnRefAssignmentError() async {
    final source = newSource(usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment);
    await expectSingleErrorAt(createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
  }

  Future<void> test_arrowFnRefAssignmentErrorFix() async {
    var source = newSource(usageSourceWithinClassComponentFixedBlockFnBodyRefAssignment);
    final errorFix = await expectSingleErrorFix(
        createSelection(source, CallbackRefDiagnosticTest.selectionToFixArrowFnRefAssignment));
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data,
        substituteSource(usageSourceWithinClassComponentFixedArrowFnRefAssignment, path: source.uri.path));
  }
}

@reflectiveTest
class CallbackRefDiagnosticClassComponentTestNoFix extends CallbackRefDiagnosticTest {
  @override
  get fixKindUnderTest => null;

  Future<void> test_tearoffFnRefAssignment() async {
    final source = newSource(CallbackRefDiagnosticClassComponentTest.usageSourceWithinClassComponent);
    final selection = createSelection(source, CallbackRefDiagnosticTest.selectionForTearoffRefAssignmentError);
    await expectSingleErrorAt(selection);
    // We intentionally do not want the diagnostic to suggest a fix since
    // the `addUseOrCreateRef` utility that builds the fix currently can't handle that use case.
    await expectNoErrorFix(selection);
  }
}
