import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import './components/my_provider_component.dart';
import './components/my_context_component.dart';
import './context.dart';

main() {
  setClientConfiguration();

  react_dom.render(
    ErrorBoundary()(
      MyProviderComponent()(
        someContext.Consumer()(
          (value){
            return Dom.div()('$value');
          },
        ),
      ),
      MyContextComponent()(),
    ), querySelector('#content')
  );
}


