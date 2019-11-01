// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement buttonDisabledDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()
      ..isDisabled = true
    )('Primary button'),
    (Button()
      ..href = '#'
      ..isDisabled = true
      ..skin = ButtonSkin.SECONDARY
    )('Link')
  );
