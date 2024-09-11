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
import 'package:over_react_analyzer_plugin/src/util/prop_forwarding/forwarded_props.dart';
import 'package:test/test.dart';

import '../../util/shared_analysis_context.dart';
import 'prop_declaration/util.dart';

void main() {
  group('prop_forwarding:', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('computeForwardedProps correctly computes forwarded props for various cases:', () {
      const sharedSourcePrefix = /*language=dart*/ r'''
          // @dart=2.12
          import 'package:over_react/over_react.dart';
          
          part '{{PART_PATH}}';
          
          // [1] Create static meta variables that we only support for legacy props.
          //     We want to test referencing them, and we'll do so with these mixins
          //     to be able to reuse this test setup.
          // [2] We can skip most all the analyzer ignore comments you'd usually need for this boilerplate,
          //     since these tests generate code first before analyzing.
          
          mixin AProps on UiProps {
            static const meta = $AProps.meta; // [1]
                        
            String? a;
          }
          mixin BProps on UiProps {
            static const meta = $BProps.meta; // [1]
            
            String? b;
          }
          mixin CProps on UiProps {
            static const meta = $CProps.meta; // [1]
            
            String? c;
          }
          
          class HasABCProps = UiProps with AProps, BProps, CProps;
          
          mixin UnrelatedProps on UiProps {}
          
          late UiFactory<UiProps> NotCare;
          
          // [2]
          @AbstractProps()
          abstract class _$LegacyUnrelatedProps extends UiProps {}
          abstract class LegacyUnrelatedProps extends _$LegacyUnrelatedProps with _$LegacyUnrelatedPropsAccessorsMixin {
            static const PropsMeta meta = _$metaForLegacyUnrelatedProps;
          }
          
          late bool condition;
      ''';

      Future<ResolvedUnitResult> sharedResolveSource(String source) =>
          resolveFileAndGeneratedPart(sharedContext, '$sharedSourcePrefix\n$source');

      group('adding `props` without filtering:', () {
        for (final methodName in ['addAll', 'addProps']) {
          group('via $methodName:', () {
            test('', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  UiFactory<HasABCProps> HasABC = uiFunction((props) {
                    return (NotCare()
                      ..METHOD_NAME(props)
                    )();
                  }, _$HasABCConfig);
              '''
                  .replaceAll('METHOD_NAME', methodName));
              final usage = getAllComponentUsages(result.unit).single;

              final f = computeForwardedProps(usage)!;
              expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
              expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });

            group('unless props are not from render, and gracefully handles these cases:', () {
              test('typed as props', () async {
                final result = await sharedResolveSource(/*language=dart*/ r'''
                    late HasABCProps notPropsFromRender;
                    UiFactory<HasABCProps> HasABC = uiFunction((props) {
                      return (NotCare()
                        ..METHOD_NAME(notPropsFromRender)
                      )();
                    }, _$HasABCConfig);
                '''
                    .replaceAll('METHOD_NAME', methodName));
                final usage = getAllComponentUsages(result.unit).single;
                expect(computeForwardedProps(usage), isNull);
              });

              test('not typed as props', () async {
                final result = await sharedResolveSource(/*language=dart*/ r'''
                    UiFactory<HasABCProps> HasABC = uiFunction((props) {
                      return (NotCare()
                        ..METHOD_NAME({})
                      )();
                    }, _$HasABCConfig);
                '''
                    .replaceAll('METHOD_NAME', methodName));
                final usage = getAllComponentUsages(result.unit).single;
                expect(computeForwardedProps(usage), isNull);
              });
            });
          });
        }
      });

      group('UiProps.addUnconsumedProps:', () {
        group('..addUnconsumedProps(props, ...)', () {
          test('using .forMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = uiFunction((props) {
                  return (NotCare()
                    ..addUnconsumedProps(props, props.staticMeta.forMixins({AProps, BProps}))
                  )();
                }, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          test('using .allExceptForMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = uiFunction((props) {
                  return (NotCare()
                    ..addUnconsumedProps(props, props.staticMeta.allExceptForMixins({BProps, CProps}))
                  )();
                }, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });
        });

        test('..addUnconsumedProps(props, consumedPropsVariable)', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = uiFunction((props) {
                final consumedProps = props.staticMeta.forMixins({AProps, BProps});
                return (NotCare()
                  ..addUnconsumedProps(props, consumedProps)
                )();
              }, _$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;

          final f = computeForwardedProps(usage)!;
          expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
          expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        });

        group('unless props are not from render, and gracefully handles these cases:', () {
          test('typed as props', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                late HasABCProps notPropsFromRender;
                UiFactory<HasABCProps> HasABC = uiFunction((props) {
                  return (NotCare()
                    ..addUnconsumedProps(notPropsFromRender, props.staticMeta.forMixins({AProps, BProps}))
                  )();
                }, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;
            expect(computeForwardedProps(usage), isNull);
          });

          test('not typed as props', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = uiFunction((props) {
                  return (NotCare()
                    ..addUnconsumedProps({}, props.staticMeta.forMixins({AProps, BProps}))
                  )();
                }, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;
            expect(computeForwardedProps(usage), isNull);
          });
        });
      });

      group('PropsToForward.getPropsToForward:', () {
        for (final methodName in ['addAll', 'addProps']) {
          group('adding via $methodName:', () {
            group('props.getPropsToForward(exclude: {...})', () {
              test('', () async {
                final result = await sharedResolveSource(/*language=dart*/ r'''
                    UiFactory<HasABCProps> HasABC = uiFunction((props) {
                      return (NotCare()
                        ..METHOD_NAME(props.getPropsToForward(exclude: {AProps, BProps}))
                      )();
                    }, _$HasABCConfig);
                '''
                    .replaceAll('METHOD_NAME', methodName));
                final usage = getAllComponentUsages(result.unit).single;

                final f = computeForwardedProps(usage);
                expect(f, isNotNull);
                expect(f!.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
                expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
                expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
                expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
                expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
              });

              group('unless props are not from render, and gracefully handles these cases:', () {
                test('typed as props', () async {
                  final result = await sharedResolveSource(/*language=dart*/ r'''
                      late HasABCProps notPropsFromRender;
                      UiFactory<HasABCProps> HasABC = uiFunction((props) {
                        return (NotCare()
                          ..METHOD_NAME(notPropsFromRender.getPropsToForward(exclude: {AProps, BProps}))
                        )();
                      }, _$HasABCConfig);
                  '''
                      .replaceAll('METHOD_NAME', methodName));
                  final usage = getAllComponentUsages(result.unit).single;
                  expect(computeForwardedProps(usage), isNull);
                });

                test('not typed as props', () async {
                  final result = await sharedResolveSource(/*language=dart*/ r'''
                      late UiProps notPropsFromRender;
                      UiFactory<HasABCProps> HasABC = uiFunction((props) {
                        return (NotCare()
                          ..METHOD_NAME(notPropsFromRender.getPropsToForward(exclude: {AProps, BProps}))
                        )();
                      }, _$HasABCConfig);
                  '''
                      .replaceAll('METHOD_NAME', methodName));
                  final usage = getAllComponentUsages(result.unit).single;
                  expect(computeForwardedProps(usage), isNull);
                });
              });
            });

            test('props.getPropsToForward() - inferred from generic', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                    UiFactory<AProps> A = uiFunction((props) {
                      return (NotCare()
                        ..METHOD_NAME(props.getPropsToForward())
                      )();
                    }, _$AConfig); 
                    
                    // For this test case, unlike others, we need a component that only has one props mixin; 
                    // declare this unused HasABC so we don't get builder errors.
                    UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
                '''
                  .replaceAll('METHOD_NAME', methodName));
              final usage = getAllComponentUsages(result.unit).single;

              final propsElement = result.lookUpInterface('AProps');

              final f = computeForwardedProps(usage);
              expect(f!.propsClassBeingForwarded, propsElement);
              expect(f.definitelyForwardsPropsFrom(propsElement), isFalse);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });
          });
        }
      });

      group('PropsToForward.addPropsToForward:', () {
        group('..modifyProps(props.addPropsToForward(exclude: {...}))', () {
          test('', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = uiFunction((props) {
                  return (NotCare()
                    ..modifyProps(props.addPropsToForward(exclude: {AProps, BProps}))
                  )();
                }, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage);
            expect(f, isNotNull);
            expect(f!.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          group('unless props are not from render, and gracefully handles these cases:', () {
            test('typed as props', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  late HasABCProps notPropsFromRender;
                  UiFactory<HasABCProps> HasABC = uiFunction((props) {
                    return (NotCare()
                      ..modifyProps(notPropsFromRender.addPropsToForward(exclude: {AProps, BProps}))
                    )();
                  }, _$HasABCConfig);
              ''');
              final usage = getAllComponentUsages(result.unit).single;
              expect(computeForwardedProps(usage), isNull);
            });

            test('not typed as props', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  late UiProps notPropsFromRender;
                  UiFactory<HasABCProps> HasABC = uiFunction((props) {
                    return (NotCare()
                      ..addProps(notPropsFromRender.getPropsToForward(exclude: {AProps, BProps}))
                    )();
                  }, _$HasABCConfig);
              ''');
              final usage = getAllComponentUsages(result.unit).single;
              expect(computeForwardedProps(usage), isNull);
            });
          });
        });

        test('..modifyProps(props.addPropsToForward()) - inferred from generic', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<AProps> A = uiFunction((props) {
                return (NotCare()
                  ..modifyProps(props.addPropsToForward())
                )();
              }, _$AConfig); 
              
              // For this test case, unlike others, we need a component that only has one props mixin; 
              // declare this unused HasABC so we don't get builder errors.
              UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;

          final propsElement = result.lookUpInterface('AProps');

          final f = computeForwardedProps(usage);
          expect(f!.propsClassBeingForwarded, propsElement);
          expect(f.definitelyForwardsPropsFrom(propsElement), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        });
      });

      group('class component methods:', () {
        group('when consumedProps uses', () {
          group('static meta variables (legacy boilerplate only)', () {
            test('in a list', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                  class HasABCComponent extends UiComponent2<HasABCProps> {
                    @override get consumedProps => [AProps.meta, BProps.meta];
                    @override render() {
                      return (NotCare()
                        ..modifyProps(addUnconsumedProps)
                      )();
                    }
                  }
              ''');
              final usage = getAllComponentUsages(result.unit).single;

              final f = computeForwardedProps(usage)!;
              expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
              expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });

            test('in a set', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                  class HasABCComponent extends UiComponent2<HasABCProps> {
                    @override get consumedProps => {AProps.meta, BProps.meta};
                    @override render() {
                      return (NotCare()
                        ..modifyProps(addUnconsumedProps)
                      )();
                    }
                  }
              ''');
              final usage = getAllComponentUsages(result.unit).single;

              final f = computeForwardedProps(usage)!;
              expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
              expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });
          });

          test('propsMeta.forMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override get consumedProps => propsMeta.forMixins({AProps, BProps});
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          test('propsMeta.allExceptForMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override get consumedProps => propsMeta.allExceptForMixins({BProps, CProps});
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          test('props.staticMeta.forMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override get consumedProps => props.staticMeta.forMixins({AProps, BProps});
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          test('props.staticMeta.allExceptForMixins', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override get consumedProps => props.staticMeta.allExceptForMixins({BProps, CProps});
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          group('empty list', () {
            test('', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                  class HasABCComponent extends UiComponent2<HasABCProps> {
                    @override get consumedProps => [];
                    @override render() {
                      return (NotCare()
                        ..modifyProps(addUnconsumedProps)
                      )();
                    }
                  }
              ''');
              final usage = getAllComponentUsages(result.unit).single;

              final f = computeForwardedProps(usage)!;
              expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
              expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });

            test('empty list (const)', () async {
              final result = await sharedResolveSource(/*language=dart*/ r'''
                  UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                  class HasABCComponent extends UiComponent2<HasABCProps> {
                    @override get consumedProps => const [];
                    @override render() {
                      return (NotCare()
                        ..modifyProps(addUnconsumedProps)
                      )();
                    }
                  }
              ''');
              final usage = getAllComponentUsages(result.unit).single;

              final f = computeForwardedProps(usage)!;
              expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
              expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
              expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
            });
          });

          test('empty set', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override get consumedProps => {};
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });
        });

        test('..addProps(copyUnconsumedProps())', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
              class HasABCComponent extends UiComponent2<HasABCProps> {
                @override get consumedProps => propsMeta.forMixins({AProps, BProps});
                @override render() {
                  return (NotCare()
                    ..addProps(copyUnconsumedProps())
                  )();
                }
              }
          ''');
          final usage = getAllComponentUsages(result.unit).single;

          final f = computeForwardedProps(usage)!;
          expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
          expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        });

        test('..addAll(copyUnconsumedProps())', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
              class HasABCComponent extends UiComponent2<HasABCProps> {
                @override get consumedProps => propsMeta.forMixins({AProps, BProps});
                @override render() {
                  return (NotCare()
                    ..addAll(copyUnconsumedProps())
                  )();
                }
              }
          ''');
          final usage = getAllComponentUsages(result.unit).single;

          final f = computeForwardedProps(usage)!;
          expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
          expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        });

        test('..modifyProps(addUnconsumedProps)', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
              class HasABCComponent extends UiComponent2<HasABCProps> {
                @override get consumedProps => propsMeta.forMixins({AProps, BProps});
                @override render() {
                  return (NotCare()
                    ..modifyProps(addUnconsumedProps)
                  )();
                }
              }
          ''');
          final usage = getAllComponentUsages(result.unit).single;

          final f = computeForwardedProps(usage)!;
          expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
          expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
          expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        });

        group('when there is no consumedProps override', () {
          test('UiComponent', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                @Factory()
                UiFactory<LegacyHasABCProps> LegacyHasABC = castUiFactory(_$LegacyHasABC);
                
                // [2]
                @Props()
                class _$LegacyHasABCProps extends UiProps with
                    AProps, $AProps, BProps, $BProps, CProps, $CProps {}
                    
                class LegacyHasABCProps extends _$LegacyHasABCProps with _$LegacyHasABCPropsAccessorsMixin {
                  static const PropsMeta meta = _$metaForLegacyHasABCProps;
                }    
            
                @Component()
                class LegacyHasABCComponent extends UiComponent<LegacyHasABCProps> {
                  @override render() {
                    return (NotCare()
                      ..addProps(copyUnconsumedProps())
                    )();
                  }
                }
                
                // For this test case, unlike others, we need a legacy boilerplate declaration; 
                // declare this unused HasABC so we don't get builder errors.
                UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('LegacyHasABCProps'));
            // For UiComponent, only props declared in the concrete props class are considered consumed by default;
            // props declared in other mixins are not included.
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('LegacyHasABCProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isTrue);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });

          test('UiComponent2', () async {
            final result = await sharedResolveSource(/*language=dart*/ r'''
                UiFactory<HasABCProps> HasABC = castUiFactory(_$HasABC);
                class HasABCComponent extends UiComponent2<HasABCProps> {
                  @override render() {
                    return (NotCare()
                      ..modifyProps(addUnconsumedProps)
                    )();
                  }
                }
            ''');
            final usage = getAllComponentUsages(result.unit).single;

            final f = computeForwardedProps(usage)!;
            expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
            expect(f.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isFalse);
            expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
          });
        });
      });

      test("when the props being forwarded are the same type as the component's props", () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            UiFactory<AProps> A = uiFunction((props) {
              return (NotCare()
                ..addProps(props.getPropsToForward(exclude: {}))
              )();
            }, _$AConfig); 
            
            // For this test case, unlike others, we need a component that only has one props mixin; 
            // declare this unused HasABC so we don't get builder errors.
            UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final propsElement = result.lookUpInterface('AProps');
        final f = computeForwardedProps(usage);
        expect(f!.propsClassBeingForwarded, propsElement);
        expect(f.definitelyForwardsPropsFrom(propsElement), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
      });

      test('normalizes legacy boilerplate to their companion classes', () async {
        final result = await sharedResolveSource(/*language=dart*/ r'''
            @Factory()
            UiFactory<LegacyProps> Legacy = castUiFactory(_$Legacy);
            
            // [2]
            @Props()
            class _$LegacyProps extends UiProps {}
                
            class LegacyProps extends _$LegacyProps with _$LegacyPropsAccessorsMixin {
              static const PropsMeta meta = _$metaForLegacyProps;
            }    
        
            @Component()
            class LegacyComponent extends UiComponent<LegacyProps> {
              get consumedProps => [];
              @override render() {
                return (NotCare()
                  ..addProps(copyUnconsumedProps())
                )();
              }
            }
            
            // For this test case, unlike others, we need a legacy boilerplate declaration; 
            // declare this unused HasABC so we don't get builder errors.
            UiFactory<HasABCProps> HasABC = uiFunction((props) {}, _$HasABCConfig);
        ''');
        final usage = getAllComponentUsages(result.unit).single;

        final f = computeForwardedProps(usage)!;
        expect(f.forwardingConfig, isNotNull, reason: 'forwarding config should be resolved');
        expect(f.propsClassBeingForwarded, result.lookUpInterface('LegacyProps'));
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('LegacyProps')), isTrue);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface(r'_$LegacyProps')), isTrue,
            reason: 'should normalize to companion');
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface('LegacyUnrelatedProps')), isFalse);
        expect(f.definitelyForwardsPropsFrom(result.lookUpInterface(r'_$LegacyUnrelatedProps')), isFalse,
            reason: 'should return false when companion is not inherited by props being forwarded');
      });

      group("other cases that shouldn't be picked up as forwarded props:", () {
        test('addUnconsumedDomProps', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = uiFunction((props) {
                return (NotCare()
                  ..addUnconsumedDomProps(props, props.staticMeta.forMixins({AProps, BProps}))
                )();
              }, _$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;
          expect(computeForwardedProps(usage), isNull);
        });

        test('no forwarded props, just setting other props unrelated method calls', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = uiFunction((props) {
                return (NotCare()
                  ..id = ''
                  ..addTestId('foo')
                )();
              }, _$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;
          expect(computeForwardedProps(usage), isNull);
        });

        test('no cascade', () async {
          final result = await sharedResolveSource(/*language=dart*/ r'''
              UiFactory<HasABCProps> HasABC = uiFunction((props) {
                return NotCare()();
              }, _$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;
          expect(computeForwardedProps(usage), isNull);
        });
      });

      group('returns a PropsToForward with a null forwarding config when forwarded props could not be resolved:', () {
        Future<void> sharedTest(String usageCascadeSource, {String otherSource = ''}) async {
          final result = await sharedResolveSource('''
            UiFactory<HasABCProps> HasABC = uiFunction((props) {
              $otherSource
              return (NotCare()
                $usageCascadeSource
              )();
            }, _\$HasABCConfig);
          ''');
          final usage = getAllComponentUsages(result.unit).single;
          final forwardedProps = computeForwardedProps(usage);
          expect(forwardedProps, isNotNull);
          expect(forwardedProps!.forwardingConfig, isNull, reason: 'should be unresolved');
          expect(forwardedProps.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        }

        Future<void> sharedClassConsumedPropsTest(String consumedPropsBodySource) async {
          final result = await sharedResolveSource('''
            UiFactory<HasABCProps> HasABC = castUiFactory(_\$HasABC);
            class HasABCComponent extends UiComponent2<HasABCProps> {
              @override get consumedProps $consumedPropsBodySource
              @override render() {
                return (NotCare()..modifyProps(addUnconsumedProps))();
              }
            }
          ''');
          final usage = getAllComponentUsages(result.unit).single;
          final forwardedProps = computeForwardedProps(usage);
          expect(forwardedProps, isNotNull);
          expect(forwardedProps!.forwardingConfig, isNull, reason: 'should be unresolved');
          expect(forwardedProps.propsClassBeingForwarded, result.lookUpInterface('HasABCProps'));
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('AProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('BProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('CProps')), isFalse);
          expect(forwardedProps.definitelyForwardsPropsFrom(result.lookUpInterface('UnrelatedProps')), isFalse);
        }

        group('unresolved props mixin references in ', () {
          const unresolvablePropsMixinsSet = '''{
            NotARealPropsMixin, // ignore: undefined_identifier
          }''';

          test('getPropsToForward', () => sharedTest('''
            ..addProps(props.getPropsToForward(exclude: $unresolvablePropsMixinsSet))
          '''));

          test('addPropsToForward', () => sharedTest('''
            ..modifyProps(props.addPropsToForward(exclude: $unresolvablePropsMixinsSet))
          '''));

          test('addUnconsumedProps', () => sharedTest('''
            ..addUnconsumedProps(props, props.staticMeta.forMixins($unresolvablePropsMixinsSet))
          '''));

          test('a consumedProps variable', () => sharedTest('''
            ..addUnconsumedProps(props, consumedProps)
          ''', otherSource: 'final consumedProps = props.staticMeta.forMixins($unresolvablePropsMixinsSet);'));
        });

        group('conditional props mixin references in ', () {
          const conditionalPropsMixinsSet = '''{
            AProps,
            if (condition) BProps,
          }''';

          test('getPropsToForward', () => sharedTest('''
            ..addProps(props.getPropsToForward(exclude: $conditionalPropsMixinsSet))
          '''));

          test('addPropsToForward', () => sharedTest('''
            ..modifyProps(props.addPropsToForward(exclude: $conditionalPropsMixinsSet))
          '''));

          test('addUnconsumedProps', () => sharedTest('''
            ..addUnconsumedProps(props, props.staticMeta.forMixins($conditionalPropsMixinsSet))
          '''));

          test('a consumedProps variable', () => sharedTest('''
            ..addUnconsumedProps(props, consumedProps)
          ''', otherSource: 'final consumedProps = props.staticMeta.forMixins($conditionalPropsMixinsSet);'));
        });

        group('consumedProps variable that', () {
          test('is unresolvable', () => sharedTest('''
            ..addUnconsumedProps(
              props,
              unresolvedConsumedPropsVariable, // ignore: undefined_identifier
            )
          '''));

          test('is not initialized in its declaration', () => sharedTest('''
            ..addUnconsumedProps(props, consumedProps)
          ''', otherSource: '''
            Iterable<PropsMeta> consumedProps; 
            consumedProps = props.staticMeta.forMixins({AProps, BProps});
          '''));
        });

        group('consumedProps getter that ', () {
          test('references props meta that cannot be resolved', () => sharedClassConsumedPropsTest('''
            => [
              NotARealPropsMixin.meta, // ignore: undefined_identifier
            ];
          '''));

          test('has more than one return statements', () => sharedClassConsumedPropsTest('''
            {
              if (condition) return {};
              return {AProps.meta};
            }
          '''));

          test('references something other than `PropsClass.meta`', () => sharedClassConsumedPropsTest('''
            {
              const meta = AProps.meta;
              return [meta];
            }
          '''));
        });
      });
    });
  });
}

extension on ResolvedUnitResult {
  /// Extension form of [getInterfaceElement] to help make tests more concise.
  InterfaceElement lookUpInterface(String name) => getInterfaceElement(this, name);
}
