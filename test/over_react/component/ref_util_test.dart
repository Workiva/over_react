// Copyright 2020 Workiva Inc.
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
// ignore_for_file: deprecated_member_use_from_same_package
library forward_ref_test;

import 'dart:html';
import 'dart:js_util';

import 'package:meta/meta.dart';
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/dom_components.dart';

import '../../test_util/test_util.dart';
import '../component/fixtures/basic_child_component.dart';

part 'ref_util_test.over_react.g.dart'; // ignore: uri_has_not_been_generated

main() {

  group('uiForwardRef -', () {
    group('fundamentally behaves the same as `forwardRef', () {
      commonRefForwardingTests();
    });

    group('on a function component child', () {
      testForwardRefWith(BasicChild, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<BasicChildComponent>());
      });

      group('using the factory\'s `asForwardRefConfig` syntax', () {
        test('- sets displayName on the rendered component as expected', () {
          final BasicForwarded = uiForwardRef<BasicUiFunctionProps>((props, ref) {
            return (BasicUiFunction()..ref = ref)();
          }, BasicUiFunction.asForwardRefConfig());

          final Ref refObject = createRef();
          final vDomElement = (BasicForwarded()..ref = refObject)();

          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), '');
        });

        test('when displayName argument is passed to the config constructor', () {
          final BasicForwarded = uiForwardRef<BasicUiFunctionProps>((props, ref) {
            return (BasicUiFunction()..ref = ref)();
          }, BasicUiFunction.asForwardRefConfig(displayName: displayName));

          final Ref refObject = createRef();
          final vDomElement = (BasicForwarded()..ref = refObject)();

          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), displayName);
        });

        group('returns normally when passed children', () {
          test('that are in a List literal', () {
            final BasicForwarded = uiForwardRef<BasicUiFunctionProps>((props, ref) {
              return (BasicUiFunction()..ref = ref)();
            }, BasicUiFunction.asForwardRefConfig());

            expect(() => mount(BasicForwarded()(['test'])), returnsNormally);
          });

          test('that are not in a List literal', () {
            final BasicForwarded = uiForwardRef<BasicUiFunctionProps>((props, ref) {
              return (BasicUiFunction()..ref = ref)();
            }, BasicUiFunction.asForwardRefConfig());

            expect(() => mount(BasicForwarded()('test')), returnsNormally);
          });
        });
      });
    });

    group('using a generated factory', () {
      test('- sets displayName on the rendered component as expected', () {
        final Ref refObject = createRef();
        final vDomElement = (TopLevelForwardUiRefFunction()..ref = refObject)();

        expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'),
            'TopLevelForwardUiRefFunction');
      });

      group('returns normally when passed children', () {
        test('that are in a List literal', () {
          expect(() => mount(TopLevelForwardUiRefFunction()(['test'])), returnsNormally);
        });

        test('that are not in a List literal', () {
          expect(() => mount(TopLevelForwardUiRefFunction()('test')), returnsNormally);
        });
      });
    });

    test('throws an argument error if the config is null', () {
      expect(() {
        uiForwardRef((_, __) => Dom.div()('Example'), null);
      }, throwsArgumentError);
    });
  });
}

@isTestGroup
void commonRefForwardingTests() {
  UiFactory<BasicProps> getFactoryForBasic({
    String displayName,
  }) {
    if (displayName == null) {
      return uiForwardRef<BasicProps>((props, ref) {
        return (Basic()..ref = ref)(props.children);
      }, Basic.asForwardRefConfig());
    } else {
      return uiForwardRef<BasicProps>((props, ref) {
        return (Basic()..ref = ref)(props.children);
      }, Basic.asForwardRefConfig(displayName: displayName));
    }
  }

  UiFactory<DomProps> getFactoryForDiv({
    String displayName,
  }) {
    ReactElement div(dynamic ref, dynamic children) => (Dom.div()..ref = ref)(children);

    if (displayName == null) {
      return uiForwardRef<DomProps>((props, ref) {
        return div(ref, props.children);
      }, Dom.div.asForwardRefConfig());
    } else {
      return uiForwardRef<DomProps>((props, ref) {
        return div(ref, props.children);
      }, Dom.div.asForwardRefConfig(displayName: displayName));
    }
  }

  group('- commonRefForwardingTests -', () {
    group('on a component with a dom component child', () {
      testForwardRefWith(Dom.span, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<SpanElement>());
      });

      test('- while consuming the `DomProps` props class', () {
        UiFactory<DomProps> DivForwarded = getFactoryForDiv();

        final Ref<DivElement> refObject = createRef();

        mount((DivForwarded()..ref = refObject)());

        expect(refObject.current, TypeMatcher<DivElement>());
      });

      group('- sets displayName on the rendered component as expected', () {
        test('when displayName argument is not passed to forwardRef', () {
          UiFactory<DomProps> DivForwarded = getFactoryForDiv();

          final refObject = createRef<DivElement>();
          final vDomElement = (DivForwarded()..ref = refObject)();

          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), '');
        });

        test('when displayName argument is passed to the config constructor', () {
          UiFactory<DomProps> DivForwarded = getFactoryForDiv(displayName: displayName);

          final refObject = createRef<DivElement>();
          final vDomElement = (DivForwarded()..ref = refObject)();


          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), displayName);
        });
      });

      group('returns normally when passed children', () {
        test('that are in a List literal', () {
          expect(() => mount(getFactoryForDiv()()(['test'])), returnsNormally);
        });

        test('that are not in a List literal', () {
          expect(() => mount(getFactoryForDiv()()('test')), returnsNormally);
        });
      });
    });

    group('on a component with a dart component child', () {
      testForwardRefWith(Basic, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<BasicComponent>());
      });

      group('- sets displayName on the rendered component as expected', () {
        test('when displayName argument is not passed to forwardRef', () {
          final BasicForwarded = getFactoryForBasic();

          final Ref refObject = createRef();
          final vDomElement = (BasicForwarded()..ref = refObject)();

          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), '');
        });

        test('when displayName argument is passed to the config constructor', () {
          final BasicForwarded = getFactoryForBasic(displayName: displayName);

          final Ref refObject = createRef();
          final vDomElement = (BasicForwarded()..ref = refObject)();

          expect(getProperty(getProperty(vDomElement.type, 'render'), 'name'), displayName);
        });
      });

      group('returns normally when passed children', () {
        test('that are in a List literal', () {
          expect(() => mount(getFactoryForBasic()()(['test'])), returnsNormally);
        });

        test('that are not in a List literal', () {
          expect(() => mount(getFactoryForBasic()()('test')), returnsNormally);
        });
      });
    });
  });
}

const displayName = 'AVerySpecificDisplayName';

void testForwardRefWith(dynamic factory,
    {void Function(dynamic refValue) verifyRefValue}) {
  test('- passes a ref through the parent to its child', () {
    final BasicForwarded = uiForwardRef<BasicProps>((props, ref) {
      return (factory()
        ..ref = ref
        ..id = props.childId)();
    }, Basic.asForwardRefConfig());

    final Ref refObject = createRef();

    mount((BasicForwarded()
      ..ref = refObject
      ..childId = 'test')());

    // component props are accessed differently depending on if it is a dom component
    // or a dart component
    String idValue;
    final current = refObject.current;
    if (current is Element) {
      idValue = current.id;
    } else {
      idValue = current.props['id'] as String;
    }

    expect(idValue, equals('test'), reason: 'child component receives props passed to it');
    verifyRefValue(current);
  });
}

UiFactory<BasicProps> Basic = _$Basic; // ignore: undefined_identifier, invalid_assignment

mixin BasicProps on UiProps {
  String childId;
}

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  render() => props.children.isEmpty ? 'basic component' : props.children;
}

mixin BasicUiFunctionProps on UiProps {}

class SecondaryBasicUiFunctionProps = UiProps with BasicUiFunctionProps;

final BasicUiFunction = uiFunction<BasicUiFunctionProps>(
  (props) {
    return props.children.isEmpty ? 'basic component' : props.children;
  },
  _$BasicUiFunctionConfig, // ignore: undefined_identifier
);

final TopLevelForwardUiRefFunction = uiForwardRef<SecondaryBasicUiFunctionProps>(
  (props, ref) {
    return (BasicUiFunction()..ref = ref)(props.children);
  },
  _$TopLevelForwardUiRefFunctionConfig, // ignore: undefined_identifier
);
