// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement buttonExamplesDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    Button()('Primary'),
    (Button()..skin = ButtonSkin.SECONDARY)('Secondary'),
    (Button()..skin = ButtonSkin.SUCCESS)('Success'),
    (Button()..skin = ButtonSkin.INFO)('Info'),
    (Button()..skin = ButtonSkin.WARNING)('Warning'),
    (Button()..skin = ButtonSkin.DANGER)('Danger'),
    (Button()
      ..href = '#'
      ..skin = ButtonSkin.LINK
    )('Link')
  );
