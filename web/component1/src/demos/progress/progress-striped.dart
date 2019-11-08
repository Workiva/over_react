// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement progressStripedDemo() => Dom.div()(
  (Progress()
    ..value = 10.0
    ..isStriped = true
  )(),
  (Progress()
    ..value = 25.0
    ..skin = ProgressSkin.SUCCESS
    ..isStriped = true
  )(),
  (Progress()
    ..value = 50.0
    ..skin = ProgressSkin.INFO
    ..isStriped = true
  )(),
  (Progress()
    ..value = 75.0
    ..skin = ProgressSkin.WARNING
    ..isStriped = true
  )(),
  (Progress()
    ..value = 100.0
    ..skin = ProgressSkin.DANGER
    ..isStriped = true
  )()
);
