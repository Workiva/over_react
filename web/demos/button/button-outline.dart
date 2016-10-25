part of over_react.web.demos;

ReactElement buttonOutlineDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()..skin = ButtonSkin.PRIMARY_OUTLINE)('Primary'),
    (Button()..skin = ButtonSkin.SECONDARY_OUTLINE)('Secondary'),
    (Button()..skin = ButtonSkin.SUCCESS_OUTLINE)('Success'),
    (Button()..skin = ButtonSkin.INFO_OUTLINE)('Info'),
    (Button()..skin = ButtonSkin.WARNING_OUTLINE)('Warning'),
    (Button()..skin = ButtonSkin.DANGER_OUTLINE)('Danger')
  );
