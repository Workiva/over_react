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
import 'dart:js_util';

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/dom_components.dart';

import '../../test_util/test_util.dart';
import '../component/fixtures/basic_child_component.dart';

part 'forward_ref_test.over_react.g.dart';

main() {
  group('forward ref -', () {
    group('on a component with a dom component child', () {
      forwardRefTest(Dom.span, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<SpanElement>());
      });
    });

    group('on a component with a dart component child', () {
      forwardRefTest(BasicChild, verifyRefValue: (ref) {
        expect(ref, TypeMatcher<BasicChildComponent>());
      });
    });
  });
}

void forwardRefTest(dynamic factory, {void verifyRefValue(dynamic refValue)}) {
  test('- passes a ref through the parent to its child', () {
    UiFactory<BasicProps> BasicForwarded = forwardRef<BasicProps>((props, ref) {
      return (factory()
        ..ref = ref
        ..id = props.childId
      )();
    })(Basic);

    var refValue = createRef();

    mount((BasicForwarded()
      ..ref = refValue
      ..childId = 'test'
    )());

    var idValue;
    if (hasProperty(refValue.current, 'id')) {
      idValue = refValue.current.id;
    } else {
      idValue = refValue.current.props['id'];
    }

    expect(idValue, equals('test'), reason: 'child component should have access to parent props');
    verifyRefValue(refValue.current);
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
