import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

import 'mui_basic_example.dart';
import 'options_examples.dart';
import 'over_react_specific_examples.dart';

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
              MyButtonRaw()('No Color'),
            ),
            (Grid()..item = true)(
              Dom.h5()('Styles'),
              (MyButton()..color = 'red')('Red'),
              (MyButton()..color = 'Blue')('Blue'),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Nested Example'),
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
      ),
      Container()(
        Dom.h4()(
          'withStyles Options Examples',
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Backup theme'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              CustomThemedButtonWithStyles()(),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Custom Style Element'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              CustomStyleElementWithStyles()(),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Media Option'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              MediaOptionButton()(),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Specified Index'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              SpecifiedIndexButtonWithStyles()(),
            ),
          ),
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('Misc.'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              MiscOptionsWithStyles()(),
            ),
          ),
        ),
      ),
      Container()(
        Dom.h4()(
          'OverReact specific examples',
        ),
        (Grid()..container = true)(
          (Grid()..item = true)(
            Dom.h5()('A class wrapped in withStyles'),
          ),
          (Grid()..container = true)(
            (Grid()..item = true)(
              (StyledClassBasedComponent()..color = 'blue')(),
            ),
          ),
        ),
      ),
    );
  },
  $ExampleEntrypointConfig, // ignore: undefined_identifier
);
