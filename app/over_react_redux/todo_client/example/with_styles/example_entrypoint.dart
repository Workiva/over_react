import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

import 'mui_basic_example.dart';

part 'example_entrypoint.over_react.g.dart'; // ignore: uri_has_not_been_generated

mixin ExampleEntrypointProps on UiProps {}

UiFactory<ExampleEntrypointProps> ExampleEntrypoint = uiFunction(
  (props) {
    return Fragment()(
      Container()(
        Dom.h4()(
          'MUI Docs Examples',
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Basic HOC Button'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              Dom.h5()('No Styles'),
              HigherOrderComponent()(),
            ),
            (Grid()..item = true)(
              Dom.h5()('Styles'),
              HigherOrderComponentWithStyles()(),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Dynamic Styles'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              Dom.h5()('No Styles'),
              MyButtonRaw()(),
            ),
            (Grid()..item = true)(
              Dom.h5()('Styles'),
              (MyButton()..color = 'red')('Red'),
              (MyButton()..color = 'Blue')('Blue'),
            ),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              Dom.h5()('Nested'),
            ),
            (Grid()..container = true)(
              (Grid()..item = true)(
                Parent()(),
              ),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Themed Styles'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              Dom.h5()('Themed'),
            ),
            (Grid()..container = true)(
              (Grid()..item = true)(
                ThemedButtonWithStyles()(),
              ),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Custom Themed Styles'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              Dom.h5()('Custom Themed'),
            ),
            (Grid()..container = true)(
              (Grid()..item = true)(
                CustomThemedButtonWithStyles()(),
              ),
            ),
          ),
        ),
      ),
    );
  },
  $ExampleEntrypointConfig, // ignore: undefined_identifier
);
