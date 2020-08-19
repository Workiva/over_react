import 'package:over_react/over_react.dart';

import 'box.dart';
import 'container.dart';

part 'example_entrypoint.over_react.g.dart'; // ignore: uri_has_not_been_generated

mixin ExampleEntrypointProps on UiProps {}

UiFactory<ExampleEntrypointProps> ExampleEntrypoint = uiFunction(
  (props) {
    return Fragment()(
      ContainerWrapper()(
        (BoxWrapper()..color = 'blue')(),
        NoPropsBoxWrapper()(),
        (FunctionStylesBoxWrapper()
          ..height = 100
          ..width = 100
        )(),
        FunctionStylesNoPropsBoxWrapper()(),
      ),
      (ContainerWrapper()..backgroundColor = 'papayawhip')(
        OptionsBoxWrapper()(),
        BoxWithElement()('This box is tied to a custom style element'),
        BoxWithMedia()(
          'This box is tied to a Style element has a media attribute',
        ),
        ParentBoxWrapper()(),
      ),
    );
  },
  $ExampleEntrypointConfig, // ignore: undefined_identifier
);
