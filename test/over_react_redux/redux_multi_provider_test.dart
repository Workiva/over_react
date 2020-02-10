import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../test_util/test_util.dart';


main() {
  Store store1;
  Store store2;
  Store store3;

  Context context1;
  Context context2;
  Context context3;

  setUp(() {
    store1 = Store<ReduxState>(reducer);
    store2 = Store<ReduxState>(reducer);
    store3 = Store<ReduxState>(reducer);

    context1 = createContext();
    context2 = createContext();
    context3 = createContext();
  });

  group('ReduxMultiProvider', () {
    test('creates a provider for every store', () {
      final jacket = mount(Dom.div()((ReduxMultiProvider()
        ..storesByContext = {
          context1: store1,
          context2: store2,
          context3: store3,
        }
      )(
        Dom.div()('Foo'),
      )), attachedToDocument: true);

      final node = jacket.getNode();
      print(node.outerHtml);
      expect(node.children.length, 3);
    });
  });
}

class ReduxState {
  final String field;

  ReduxState(this.field);
}

ReduxState reducer(ReduxState oldState, dynamic action) => ReduxState(action.field ?? oldState.field);