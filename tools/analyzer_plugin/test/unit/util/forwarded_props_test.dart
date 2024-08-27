// Copyright 2024 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/over_react_builder_parsing.dart';
import 'package:over_react_analyzer_plugin/src/util/forwarded_props.dart';
import 'package:test/test.dart';

import '../../util/shared_analysis_context.dart';
import 'prop_declaration/util.dart';

void main() {
  group('getForwardedProps', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('correctly computes forwarded props for various cases:', () {
      late ResolvedUnitResult result;

      setUpAll(() async {
        result = await resolveFileAndGeneratedPart(sharedContext, /*language=Dart*/ r'''
// @dart=2.12
import 'package:over_react/over_react.dart';

part '{{PART_PATH}}';

mixin FooProps on UiProps {}
mixin BarProps on UiProps {}
mixin QuxProps on UiProps {}

mixin UnrelatedProps on UiProps {}

class TestProps = UiProps with FooProps, BarProps, QuxProps;

UiFactory<TestProps> Test = castUiFactory(_$Test);

UiFactory<TestProps> TestRawAddProps = uiFunction((props) {
  return (Test()
    ..addProps(props)
  )();
}, null); 

UiFactory<TestProps> TestRawAddAll = uiFunction((props) {
  return (Test()
    ..addAll(props)
  )();
}, null); 

UiFactory<TestProps> TestGetPropsToForward = uiFunction((props) {
  final consumedProps = props.staticMeta.forMixins({FooProps});
  return (Test()
    ..addProps(props.getPropsToForward(exclude: {FooProps}))
  )();
}, null);

mixin TestGetPropsToForwardNoArgProps on UiProps {}
UiFactory<TestGetPropsToForwardNoArgProps> TestGetPropsToForwardNoArg = uiFunction((props) {
  return (Test()
    ..addProps(props.getPropsToForward())
  )();
}, _$TestGetPropsToForwardNoArgConfig); 

UiFactory<TestProps> TestConsumedPropsVariable = uiFunction((props) {
  final consumedProps = props.staticMeta.forMixins({FooProps});
  return (Test()
    ..addUnconsumedProps(props, consumedProps)
  )();
}, null);

''');
      });

      FluentComponentUsage getSingleUsageWithinComponent(String componentName) {
        final component = result.unit.declarations.singleWhere((e) =>
            e is NamedCompilationUnitMember && e.name.lexeme == componentName ||
            e is TopLevelVariableDeclaration && e.firstVariable.name.lexeme == componentName);
        return getAllComponentUsages(component).single;
      }

      late InterfaceElement testPropsElement;
      late InterfaceElement fooPropsElement;
      late InterfaceElement barPropsElement;
      late InterfaceElement quxPropsElement;
      late InterfaceElement unrelatedPropsElement;

      setUp(() {
        testPropsElement = getInterfaceElement(result, 'TestProps');
        fooPropsElement = getInterfaceElement(result, 'FooProps');
        barPropsElement = getInterfaceElement(result, 'BarProps');
        quxPropsElement = getInterfaceElement(result, 'QuxProps');
        unrelatedPropsElement = getInterfaceElement(result, 'UnrelatedProps');
      });

      test('..addProps(props)', () {
        final usage = getSingleUsageWithinComponent('TestRawAddProps');
        final forwardedProps = getForwardedProps(usage);
        expect(forwardedProps, isNotNull);
        expect(forwardedProps!.propsClassBeingForwarded, testPropsElement);
        expect(forwardedProps.definitelyForwardsPropsFrom(fooPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(barPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(quxPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(unrelatedPropsElement), isFalse);
      });

      test('..addAll(props)', () {
        final usage = getSingleUsageWithinComponent('TestRawAddAll');
        final forwardedProps = getForwardedProps(usage);
        expect(forwardedProps, isNotNull);
        expect(forwardedProps!.propsClassBeingForwarded, testPropsElement);
        expect(forwardedProps.definitelyForwardsPropsFrom(fooPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(barPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(quxPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(unrelatedPropsElement), isFalse);
      });

      test('..addUnconsumedProps(props, consumedPropsVariable)', () {
        final usage = getSingleUsageWithinComponent('TestConsumedPropsVariable');
        final forwardedProps = getForwardedProps(usage);
        expect(forwardedProps, isNotNull);
        expect(forwardedProps!.propsClassBeingForwarded, testPropsElement);
        expect(forwardedProps.definitelyForwardsPropsFrom(fooPropsElement), isFalse);
        expect(forwardedProps.definitelyForwardsPropsFrom(barPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(quxPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(unrelatedPropsElement), isFalse);
      });

      test('..addProps(props.getPropsToForward(exclude: {...}))', () {
        final usage = getSingleUsageWithinComponent('TestGetPropsToForward');
        final forwardedProps = getForwardedProps(usage);
        expect(forwardedProps, isNotNull);
        expect(forwardedProps!.propsClassBeingForwarded, testPropsElement);
        expect(forwardedProps.definitelyForwardsPropsFrom(fooPropsElement), isFalse);
        expect(forwardedProps.definitelyForwardsPropsFrom(barPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(quxPropsElement), isTrue);
        expect(forwardedProps.definitelyForwardsPropsFrom(unrelatedPropsElement), isFalse);
      });

      test('..addProps(props.getPropsToForward()) - inferred from generic', () {
        final usage = getSingleUsageWithinComponent('TestGetPropsToForwardNoArg');
        final forwardedProps = getForwardedProps(usage);
        expect(forwardedProps, isNotNull);

        final propsElement = getInterfaceElement(result, 'TestGetPropsToForwardNoArgProps');

        expect(forwardedProps!.propsClassBeingForwarded, propsElement);
        expect(forwardedProps.definitelyForwardsPropsFrom(propsElement), isFalse);
        expect(forwardedProps.definitelyForwardsPropsFrom(unrelatedPropsElement), isFalse);
      });
    });
  });
}
