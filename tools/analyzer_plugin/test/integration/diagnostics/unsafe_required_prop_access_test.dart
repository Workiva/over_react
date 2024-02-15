// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/unsafe_required_prop_access.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UnsafeRequiredPropAccessTest);
  });
}

@reflectiveTest
class UnsafeRequiredPropAccessTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => UnsafeRequiredPropAccessDiagnostic.code;

  @override
  get fixKindUnderTest => UnsafeRequiredPropAccessDiagnostic.fixKind;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

// ignore_for_file: unused_local_variable

UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier

mixin FooProps on UiProps {
  late String requiredProp;
  String? optionalProp;
}
''';

  Future<void> test_noErrorsForPropsWithDisabledValidation() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test(FooProps props) {
        if (props.containsProp((p) => p.requiredProp)) {
          print(props.requiredProp);
        }
      }
    '''));
  }
}
