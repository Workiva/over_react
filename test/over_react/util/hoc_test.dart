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

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:test/test.dart';

import '../../over_react_redux/fixtures/counter.dart';
import '../../over_react_redux/fixtures/store.dart';
import '../../test_util/test_util.dart';

main() {
  group('composeHocs', () {
    test('will render a nested component', () {
      CounterProps Function() components = composeHocs([
        connect<CounterState, CounterProps>(),
        connect<CounterState, CounterProps>(),
      ])(Counter);

      final jacket = mount(
        Dom.div()(
          (ReduxProvider()..store = store1)(
            components()(),
          ),
        ),
        attachedToDocument: true,
      );

      final component = queryByTestId(jacket.getNode(), 'counter-component');

      expect(component, isNotNull);
    });

    test('reduces HOCs in the expected order', () {
      const data0 = '0';
      const data1 = '1';

      CounterProps Function() composeHocComponent = composeHocs([
        connect<CounterState, CounterProps>(
          mapStateToProps: (_) => {
            'data-0': data0,
            'data-both': data0,
          },
        ),
        connect<CounterState, CounterProps>(
          mapStateToProps: (_) => {
            'data-1': data1,
            'data-both': data1,
          },
        )
      ])(Counter);

      CounterProps Function() verboseHoc = connect<CounterState, CounterProps>(
        mapStateToProps: (_) => {
          'data-0': data0,
          'data-both': data0,
        },
      )(connect<CounterState, CounterProps>(
        mapStateToProps: (_) => {
          'data-1': data1,
          'data-both': data1,
        },
      )(Counter));

      final jacket = mount(
        Dom.div()(
          (ReduxProvider()..store = store1)(
            (composeHocComponent()..addTestId('compose-hoc'))(),
            (verboseHoc()..addTestId('verbose-hoc'))(),
          ),
        ),
        attachedToDocument: true,
      );

      final composeHocNodeAttributes =
          queryByTestId(jacket.getNode(), 'compose-hoc').attributes;
      final verboseHocNode = queryByTestId(jacket.getNode(), 'verbose-hoc');

      expect(composeHocNodeAttributes, containsPair('data-0', data0));
      expect(composeHocNodeAttributes, containsPair('data-1', data1));
      expect(composeHocNodeAttributes, containsPair('data-both', data1));
      expect(composeHocNodeAttributes['data-both'], verboseHocNode.attributes['data-both']);
    });
  });
}
