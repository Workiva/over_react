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
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/forwarded_props.dart';
import 'package:test/test.dart';

import '../../util/shared_analysis_context.dart';
import 'prop_declaration/util.dart';

void main() {
  group('getForwardedProps', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('correctly computes forwarded props for various cases:', () {
      const sharedSourcePrefix = /*language=dart*/ r'''
          // @dart=2.12
          import 'package:over_react/over_react.dart';
          
          part '{{PART_PATH}}';
          
          mixin FooProps on UiProps {}
          mixin BarProps on UiProps {}
          mixin QuxProps on UiProps {}
          
          mixin UnrelatedProps on UiProps {}
          
          class TestProps = UiProps with FooProps, BarProps, QuxProps;
          
          UiFactory<TestProps> Test = castUiFactory(_$Test);
      ''';

      Future<ResolvedUnitResult> sharedResolveSource(String source) =>
          resolveFileAndGeneratedPart(sharedContext, '$sharedSourcePrefix\n$source');

      test('..addProps(props)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<TestProps> CaseRawAddProps = uiFunction((props) {
              return (Test()
                ..addProps(props)
              )();
            }, null);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('TestProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('FooProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BarProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('QuxProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addAll(props)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<TestProps> _ = uiFunction<TestProps>((props) {
              return (Test()
                ..addAll(props)
              )();
            }, null);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('TestProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('FooProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BarProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('QuxProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addUnconsumedProps(props, consumedPropsVariable)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<TestProps> _ = uiFunction<TestProps>((props) {
              final consumedProps = props.staticMeta.forMixins({FooProps});
              return (Test()
                ..addUnconsumedProps(props, consumedProps)
              )();
            }, null);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('TestProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('FooProps')), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BarProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('QuxProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addProps(props.getPropsToForward(exclude: {...}))', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<TestProps> _ = uiFunction((props) {
              final consumedProps = props.staticMeta.forMixins({FooProps});
              return (Test()
                ..addProps(props.getPropsToForward(exclude: {FooProps}))
              )();
            }, null);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage);
        expect(f, isNotNull);
        expect(f!.propsClassBeingForwarded, result.lookUpInterface('TestProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('FooProps')), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BarProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('QuxProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addProps(props.getPropsToForward()) - inferred from generic', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            mixin TestGetPropsToForwardNoArgProps on UiProps {}
            UiFactory<TestGetPropsToForwardNoArgProps> TestGetPropsToForwardNoArg = uiFunction((props) {
              return (Test()
                ..addProps(props.getPropsToForward())
              )();
            }, _$TestGetPropsToForwardNoArgConfig); 
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final propsElement = result.lookUpInterface('TestGetPropsToForwardNoArgProps');

        final f = getForwardedProps(usage);
        expect(f!.propsClassBeingForwarded, propsElement);
        expect(f.definitelyForwardsPropsFrom(propsElement), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });
    });
  });
}

extension on ResolvedUnitResult {
  /// Extension form of [getInterfaceElement] to help make tests more concise.
  InterfaceElement lookUpInterface(String name) => getInterfaceElement(this, name);
}
