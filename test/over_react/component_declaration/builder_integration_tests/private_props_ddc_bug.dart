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

@TestOn('browser')

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../test_util/test_util.dart';

part 'private_props_ddc_bug.over_react.g.dart';

main() {
  test('sets private props correctly in `getDefaultProps`', () {
    var instance = render((Foo())());

    expect(instance, isNotNull); // sanity check

    var node = findDomNode(instance)!;

    expect(node.text, contains('some private value'));
  });
}


@Factory()
UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$FooProps extends UiProps {
  // ignore: unused_field
  String? _privateProp;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  @override
  Map getDefaultProps() => newProps().._privateProp = 'some private value';

  @override
  render() => (Dom.div())(props._privateProp);
}
