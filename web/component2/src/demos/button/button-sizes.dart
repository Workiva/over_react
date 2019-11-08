import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement buttonSizesDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()..size = ButtonSize.SMALL)('Small'),
    Button()('Default'),
    (Button()..size = ButtonSize.LARGE)('Large')
  );
