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
          
          mixin AProps on UiProps {}
          mixin BProps on UiProps {}
          mixin CProps on UiProps {}
          
          class HasABCProps = UiProps with AProps, BProps, CProps;
          
          mixin UnrelatedProps on UiProps {}
          
          late UiFactory<UiProps> NotCare;
      ''';

      Future<ResolvedUnitResult> sharedResolveSource(String source) =>
          resolveFileAndGeneratedPart(sharedContext, '$sharedSourcePrefix\n$source');

      test('..addProps(props)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<HasABCProps> HasABC = uiFunction((props) {
              return (NotCare()
                ..addProps(props)
              )();
            }, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addAll(props)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<HasABCProps> HasABC = uiFunction((props) {
              return (NotCare()
                ..addAll(props)
              )();
            }, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addUnconsumedProps(props, consumedPropsVariable)', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<HasABCProps> HasABC = uiFunction((props) {
              final consumedProps = props.staticMeta.forMixins({AProps});
              return (NotCare()
                ..addUnconsumedProps(props, consumedProps)
              )();
            }, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage)!;
        expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addProps(props.getPropsToForward(exclude: {...}))', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<HasABCProps> HasABC = uiFunction((props) {
              final consumedProps = props.staticMeta.forMixins({AProps});
              return (NotCare()
                ..addProps(props.getPropsToForward(exclude: {AProps}))
              )();
            }, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = getForwardedProps(usage);
        expect(f, isNotNull);
        expect(f!.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('..addProps(props.getPropsToForward()) - inferred from generic', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<AProps> A = uiFunction((props) {
              return (NotCare()
                ..addProps(props.getPropsToForward())
              )();
            }, _$AConfig); 
            
            // For this test case, unlike others, we need a component that only has one props mixin; 
            // declare this unused HasABC so we don't get builder errors.
            UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final propsElement = result.lookUpInterface('AProps');

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
