// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util/builder_invocation.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_bases/diagnostic_test_base.dart';
import '../../test_bases/server_plugin_contributor_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(InvalidChildDiagnosticTest);
    defineReflectiveTests(InvalidChildDiagnosticTest_UninvokedBuildersFix);
  });
}

@reflectiveTest
class InvalidChildDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => InvalidChildDiagnostic.code;

  @override
  FixKind? get fixKindUnderTest => null;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';

class MyObject {
  String id;
}

dynamic functionThatReturnsDynamic() {}
''';

  Future<void> test_noErrors() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
      test() => Dom.div()(
        //
        // Valid child types
        //
        Dom.div()(),
        1,
        1.2,
        'Hello world!',
        null,
        false,
        functionThatReturnsDynamic(),
        [1, 2, 3],
        ['foo', 2, true],
        [MyObject(), MyObject()].map((obj) => obj.id),
      );
    ''');

    expect(await getAllErrors(source, includeOtherCodes: true), isEmpty);
  }

  Future<void> test_errorUnsupportedChildTypes() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
      void voidVar;        
      test() => Dom.div()(
        //
        // Unsupported types
        //
        {'just': 'a map'},
        MyObject(),
        Future(() {}),
      );
    ''');

    expect(
        await getAllErrors(source),
        unorderedEquals(<dynamic>[
          isA<AnalysisError>().having(
              (e) => e.message, 'message', "Objects of type 'Map<String, String>' are not valid React children."),
          isA<AnalysisError>()
              .having((e) => e.message, 'message', "Objects of type 'MyObject' are not valid React children."),
          isA<AnalysisError>()
              .having((e) => e.message, 'message', "Objects of type 'Future<Null>' are not valid React children."),
        ]));
  }

  Future<void> test_errorChecksIterables() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
      void voidVar;        
      test() => Dom.div()(
        // Iterable type parameters are checked
        [MyObject()],
        [1, 2, 3].map((_) => MyObject()),
        [1, 2, 3].map((number) async => (Dom.div()..key = number)(number)),
      );
    ''');

    expect(
        await getAllErrors(source),
        unorderedEquals(<dynamic>[
          isA<AnalysisError>()
              .having((e) => e.message, 'message', "Objects of type 'MyObject' are not valid React children."),
          isA<AnalysisError>()
              .having((e) => e.message, 'message', "Objects of type 'MyObject' are not valid React children."),
          isA<AnalysisError>().having(
              (e) => e.message, 'message', "Objects of type 'Future<ReactElement>' are not valid React children."),
        ]));
  }
}

@reflectiveTest
class InvalidChildDiagnosticTest_UninvokedBuildersFix extends DiagnosticTestBase {
  @override
  get errorUnderTest => InvalidChildDiagnostic.code;

  @override
  FixKind? get fixKindUnderTest => addBuilderInvocationFix;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';
''';

  Future<void> test_errorUninvokedBuilders() async {
    var source = newSourceWithPrefix(/*language=dart*/ r'''
test() => Dom.div()(
  // Unsupported types, uninvoked builders: has quick fix
  Dom.div(),
  (Dom.div()),
  (Dom.div()..id = 'hi'),
  Dom.div()..id = 'hi',
);
''');

    final errors = await getAllErrors(source);
    expect(
        errors,
        allOf(
            hasLength(4),
            everyElement(isA<AnalysisError>()
                .having((e) => e.message, 'message', "Objects of type 'DomProps' are not valid React children."))));

    for (final error in errors.toList().reversed) {
      final fix = await expectSingleErrorFix(SourceSelection(source, error.location.offset, error.location.length));
      source = applyErrorFixes(fix, source);
    }
    expect(source.contents.data, /*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';
test() => Dom.div()(
  // Unsupported types, uninvoked builders: has quick fix
  Dom.div()(),
  (Dom.div())(),
  (Dom.div()..id = 'hi')(),
  (Dom.div()..id = 'hi')(),
);
''');
  }
}
