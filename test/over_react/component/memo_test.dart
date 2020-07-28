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

library memo_test;

import 'package:over_react/src/util/memo.dart';
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
import 'fixtures/basic_ui_component.dart';

part 'memo_test.over_react.g.dart';

main() {
  group('memo -', () {
    test('errors when wrapping a UiComponent', () {
      expect(
          () => memo<BasicUiComponentProps>((props) {
                return (BasicUiComponent())();
              })(BasicUiComponent),
          throwsArgumentError);
    });
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
