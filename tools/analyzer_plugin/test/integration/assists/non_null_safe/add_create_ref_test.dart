// This file is a non-null safe copy of assist tests.
import 'dart:async';

import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref_assist.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_bases/assist_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddUseOrCreateRefAssistTest);
  });
}

@reflectiveTest
class AddUseOrCreateRefAssistTest extends AssistTestBase {
  @override
  AssistKind get assistKindUnderTest => AddUseOrCreateRefAssistContributor.addRef;

  String usageSourceWithinClassComponent({required bool fixed, bool dom = false}) {
    final factory = dom ? 'Dom.div' : 'Child';
    final refName = dom ? '_divRef' : '_childRef';
    return '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

UiFactory<HasNoRefsProps> HasNoRefs = castUiFactory(_\$HasNoRefs); // ignore: undefined_identifier

mixin HasNoRefsProps on UiProps {}

class HasNoRefsComponent extends UiComponent2<HasNoRefsProps> {
  ${fixed ? 'final $refName = createRef<${dom ? 'Element' : 'dynamic'}>();\n\n  ' : ''}
  @override
  render() {
    return ${fixed ? '''($factory()
      ..id = 'foo'
      ..ref = $refName)''' : '''($factory()..id = 'foo')'''}(props.children);
  }
}
''';
  }

  String usageSourceWithinFnComponent({required bool fixed, bool dom = false}) {
    final factory = dom ? 'Dom.div' : 'Child';
    final refName = dom ? '_divRef' : '_childRef';
    return '''
// @dart=2.11
import 'dart:html';

import 'package:over_react/over_react.dart';

final HasNoRefs = uiFunction<UiProps>(
  (props) {
    ${fixed ? 'final $refName = useRef<${dom ? 'Element' : 'dynamic'}>();\n\n    ' : ''}
    return ${fixed ? '''($factory()
      ..id = 'foo'
      ..ref = $refName)''' : '''($factory()..id = 'foo')'''}(props.children);
  },
  UiFactoryConfig(displayName: 'HasNoRefs'),
);
''';
  }

  Future<void> test_noAssist() async {
    final source = newSource('var foo = true;');
    final selection = createSelection(source, '#var foo = true;#');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistWithExistingRefInFnComponentDecl() async {
    final source = newSource('''
// @dart=2.11
import 'package:over_react/over_react.dart';

final HasRefs = uiFunction<UiProps>(
  (props) {
    final _childRef = useRef<dynamic>();
    return (Child()..ref = _childRef)(props.children);
  },
  UiFactoryConfig(displayName: 'HasRefs'),
);
''');
    final selection = createSelection(source, 'return (##Child()');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistWithSelectionOutsideReturnExpressionInFnComponent() async {
    var source = newSource(usageSourceWithinFnComponent(fixed: false));
    var selection = createSelection(source, '<UiProps>(##');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistWithExistingRefInClassComponentDecl() async {
    final source = newSource('''
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

UiFactory<HasRefsProps> HasRefs = castUiFactory(_\$HasRefs); // ignore: undefined_identifier

mixin HasRefsProps on UiProps {}

class HasRefsComponent extends UiComponent2<HasRefsProps> {
  final _childRef = createRef<dynamic>();
  
  @override
  render() {
    return (Child()..ref = _childRef)(props.children);
  }
}
''');
    final selection = createSelection(source, 'return (##Child()');
    await expectNoAssist(selection);
  }

  Future<void> test_noAssistWithSelectionOutsideReturnExpressionInClassComponent() async {
    var source = newSource(usageSourceWithinClassComponent(fixed: false));
    var selection = createSelection(source, '<HasNoRefsProps> {##');
    await expectNoAssist(selection);
  }

  Future<void> test_classComponentAssist_componentNameSelection() async {
    var source = newSource(usageSourceWithinClassComponent(fixed: false));
    var selection = createSelection(source, 'return (#Child#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinClassComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_classComponentAssist_zeroWidthSelection() async {
    var source = newSource(usageSourceWithinClassComponent(fixed: false));
    var selection = createSelection(source, 'return (##Child()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinClassComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_classComponentAssist_propCascadeSelection() async {
    var source = newSource(usageSourceWithinClassComponent(fixed: false));
    var selection = createSelection(source, '..id ##= \'foo\'');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinClassComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_classComponentAssist_domElement() async {
    var source = newSource(usageSourceWithinClassComponent(fixed: false, dom: true));
    var selection = createSelection(source, 'return (#Dom.div#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinClassComponent(fixed: true, dom: true), path: source.uri.path));
  }

  Future<void> test_fnComponentAssist_componentNameSelection() async {
    var source = newSource(usageSourceWithinFnComponent(fixed: false));
    var selection = createSelection(source, 'return (#Child#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinFnComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_fnComponentAssist_zeroWidthSelection() async {
    var source = newSource(usageSourceWithinFnComponent(fixed: false));
    var selection = createSelection(source, 'return (##Child()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinFnComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_fnComponentAssist_propCascadeSelection() async {
    var source = newSource(usageSourceWithinFnComponent(fixed: false));
    var selection = createSelection(source, '..id ##= \'foo\'');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinFnComponent(fixed: true), path: source.uri.path));
  }

  Future<void> test_fnComponentAssist_domElement() async {
    var source = newSource(usageSourceWithinFnComponent(fixed: false, dom: true));
    var selection = createSelection(source, 'return (#Dom.div#()');
    final change = await expectAndGetSingleAssist(selection);
    source = applySourceChange(change, source);
    expect(source.contents.data, substituteSource(usageSourceWithinFnComponent(fixed: true, dom: true), path: source.uri.path));
  }
}
