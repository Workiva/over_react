part of over_react.web.demos;

ReactElement buttonBlockDemo() => Dom.div()(
  (Button()
    ..isBlock = true
  )('Block level button'),
  (Button()
    ..isBlock = true
    ..skin = ButtonSkin.SECONDARY
  )('Block level button')
);
