part of over_react.web.demos;

ReactElement tagContextualDemo() => Dom.div()(
  (Tag()..skin = TagSkin.DEFAULT)('Default'),
  (Tag()..skin = TagSkin.PRIMARY)('Primary'),
  (Tag()..skin = TagSkin.SUCCESS)('Success'),
  (Tag()..skin = TagSkin.INFO)('Info'),
  (Tag()..skin = TagSkin.WARNING)('Warning'),
  (Tag()..skin = TagSkin.DANGER)('Danger')
);
