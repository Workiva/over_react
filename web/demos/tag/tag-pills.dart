part of over_react.web.demos;

ReactElement tagPillsDemo() => Dom.div()(
  (Tag()
    ..isPill = true
    ..skin = TagSkin.DEFAULT
  )('Default'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.PRIMARY
  )('Primary'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.SUCCESS
  )('Success'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.INFO
  )('Info'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.WARNING
  )('Warning'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.DANGER
  )('Danger')
);
