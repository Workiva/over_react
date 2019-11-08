// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement progressAnimatedStripesDemo() =>
  (Progress()
    ..value = 25.0
    ..isStriped = true
    ..isAnimated = true
  )();
