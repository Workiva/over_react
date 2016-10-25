part of over_react.web.demos;

ReactElement progressContextualDemo() => Dom.div()(
  (Progress()
    ..value = 25.0
    ..skin = ProgressSkin.SUCCESS
  )(),
  (Progress()
    ..value = 50.0
    ..skin = ProgressSkin.INFO
  )(),
  (Progress()
    ..value = 75.0
    ..skin = ProgressSkin.WARNING
  )(),
  (Progress()
    ..value = 100.0
    ..skin = ProgressSkin.DANGER
  )()
);
