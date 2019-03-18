import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement progressBasicDemo() => Dom.div()(
  (Progress()
    ..showCaption = true
    ..captionProps = (domProps()..className = 'text-xs-center')
    ..caption = 'Reticulating splines...'
  )(),
  (Progress()
    ..value = 25.0
    ..showCaption = true
    ..captionProps = (domProps()..className = 'text-xs-center')
    ..caption = 'Reticulating splines...'
  )(),
  (Progress()
    ..value = 50.0
    ..showCaption = true
    ..captionProps = (domProps()..className = 'text-xs-center')
    ..caption = 'Reticulating splines...'
  )(),
  (Progress()
    ..value = 75.0
    ..showCaption = true
    ..captionProps = (domProps()..className = 'text-xs-center')
    ..caption = 'Reticulating splines...'
  )(),
  (Progress()
    ..value = 100.0
    ..showCaption = true
    ..captionProps = (domProps()..className = 'text-xs-center')
    ..caption = 'Reticulating splines...'
  )()
);
