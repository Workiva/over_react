// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref_assist.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/assist_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddUseOrCreateRefAssistTest);
  });
}

@reflectiveTest
class AddUseOrCreateRefAssistTest extends AssistTestBase {
  @override
  AssistKind get assistKindUnderTest => AddUseOrCreateRefAssistContributor.addRef;

  String usageSourceWithinClassComponent({@required bool fixed}) => '''
import 'package:over_react/over_react.dart';

part 'refs.over_react.g.dart';

UiFactory<HasNoRefsProps> HasNoRefs = castUiFactory(_\$HasNoRefs); // ignore: undefined_identifier

mixin HasNoRefsProps on UiProps {}

class HasNoRefsComponent extends UiComponent2<HasNoRefsProps> {
  ${fixed ? 'final _childRef = createRef<dynamic>();\n\n  ' : ''}
  @override
  render() {
    return ${fixed ? '(Child()..ref = _childRef)' : 'Child()'}(props.children);
  }
}
''';

  String usageSourceWithinFnComponent({@required bool fixed}) => '''
import 'package:over_react/over_react.dart';

final HasNoRefs = uiFunction<UiProps>(
  (props) {
    ${fixed ? 'final _childRef = useRef<dynamic>();\n\n    ' : ''}
    return ${fixed ? '(Child()..ref = _childRef)' : 'Child()'}(props.children);
  },
  UiFactoryConfig(displayName: 'HasNoRefs'),
);
''';

  Future<void> test_noAssist() async {
    final source = newSource('test.dart', 'var foo = true;');
    final selection = createSelection(source, '#var foo = true;#');
    await expectNoAssist(selection);
  }

  Future<void> test_classComponentAssist() async {
    var source = newSource('test.dart', usageSourceWithinClassComponent(fixed: false));
    var selection = createSelection(source, 'return #Child#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, usageSourceWithinClassComponent(fixed: true));
  }

  Future<void> test_fnComponentAssist() async {
    var source = newSource('test.dart', usageSourceWithinFnComponent(fixed: false));
    var selection = createSelection(source, 'return #Child#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, usageSourceWithinFnComponent(fixed: true));
  }
}
