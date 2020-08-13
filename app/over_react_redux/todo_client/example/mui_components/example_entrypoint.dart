import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

import 'box.dart';
import 'container.dart';

part 'example_entrypoint.over_react.g.dart'; // ignore: uri_has_not_been_generated

mixin ExampleEntrypointProps on UiProps {}

UiFactory<ExampleEntrypointProps> ExampleEntrypoint = uiFunction((props) {
    return Fragment()(
        ContainerWrapper()(
          (BoxWrapper()..color='blue')(),
          NoPropsBoxWrapper()(),
        )
    );
  },
  $ExampleEntrypointConfig, // ignore: undefined_identifier
);