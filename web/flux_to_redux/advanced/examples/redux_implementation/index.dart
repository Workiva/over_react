import 'dart:html';

import 'package:over_react/components.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/should_not_update.dart';
import './components/random_color_redux.dart';
import './store.dart';

main() {
  react_dom.render(
      ErrorBoundary()(
        (ReduxProvider()..store = reduxStore)(
          ConnectedRandomColorRedux()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
