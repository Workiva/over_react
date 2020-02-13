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
              )
          ), attachedToDocument: true,
      );

      final component = queryByTestId(jacket.getNode(), 'counter-component');

      expect(component, isNotNull);
    });
  });
}