import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:redux/redux.dart';
import './builder/abstract_inheritance.dart';
import './builder/basic_with_state.dart';
import './builder/generic_inheritance_sub.dart';
import './builder/generic_inheritance_super.dart';

main() {
  setClientConfiguration();

  Store store = new Store(_exampleReducer);

  react_dom.render(
//      (ReduxProvider()..store = store)(
        Dom.div()(
          Dom.h3()('Components'),
          (ConnectedBasic()
            ..id = 'the id of this component'
          )(null, null, ['this is another child']),
        ), querySelector('#content')
//      )
  );
}


dynamic _exampleReducer(dynamic state, dynamic action) {
  if (action.type == 'UPDATE_TEXT') {
    return state.basicProps = action.text;
  }
}

class ReduxAction {
  String type;
  dynamic value;

  ReduxAction(this.type, this.value);
}
