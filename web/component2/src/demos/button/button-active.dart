import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement buttonActiveDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()
      ..isActive = true
    )('Primary button'),
    (Button()
      ..isActive = true
      ..skin = ButtonSkin.SECONDARY
    )('Button')
  );
