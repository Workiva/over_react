// Copyright 2019 Workiva Inc.
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

library forward_ref_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/dom_components.dart';

import '../../test_util/test_util.dart';
import '../component/fixtures/basic_child_component.dart';
import 'fixtures/basic_ui_component.dart';

part 'forward_ref_test.over_react.g.dart';

main() {
  group('forward ref -', () {
    test('errors when wrapping a UiComponent', () {
      expect(() => forwardRef<BasicUiComponentProps>((props, ref) {
        return (BasicUiComponent()
          ..ref = ref
        )();
      })(BasicUiComponent), throwsArgumentError);
    });

    group('on a component with a dom component child', () {
      forwardRefTest(Dom.span, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<SpanElement>());
      });

      test('- using DomProps', () {
        UiFactory<DomProps> DivForwarded = forwardRef<DomProps>((props, ref) {
          return (Dom.div()
            ..ref = ref
          )();
        })(Dom.div);

        final Ref<DivElement> refObject = createRef();

        mount((DivForwarded()
          ..ref = refObject
        )());

        expect(refObject.current, TypeMatcher<DivElement>());
      });
    });

    group('on a component with a dart component child', () {
      forwardRefTest(BasicChild, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<BasicChildComponent>());
      });
    });
  });
}

void forwardRefTest(dynamic factory, {void Function(dynamic refValue) verifyRefValue}) {
  test('- passes a ref through the parent to its child', () {
    UiFactory<BasicProps> BasicForwarded = forwardRef<BasicProps>((props, ref) {
      return (factory()
        ..ref = ref
        ..id = props.childId
      )();
    })(Basic);

    final Ref refObject = createRef();

    mount((BasicForwarded()
      ..ref = refObject
      ..childId = 'test'
    )());

    // component props are accessed differently depending on if it is a dom component
    // or a dart component
    String idValue;
    if (refObject.current is Element) {
      idValue = refObject.current.id;
    } else {
      idValue = refObject.current.props['id'];
    }

    expect(idValue, equals('test'), reason: 'child component should have access to parent props');
    verifyRefValue(refObject.current);
  });
}

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
class _$BasicProps extends UiProps {
  String childId;
}

@Component2()
class BasicComponent extends UiComponent2<BasicProps> {
  @override
  render() => 'basic component';
}
