part of over_react.web.demos;

ReactElement buttonExamplesDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    Button()('Primary'),
    (Button()..skin = ButtonSkin.SECONDARY)('Secondary'),
    (Button()..skin = ButtonSkin.SUCCESS)('Success'),
    (Button()..skin = ButtonSkin.INFO)('Info'),
    (Button()..skin = ButtonSkin.WARNING)('Warning'),
    (Button()..skin = ButtonSkin.DANGER)('Danger'),
    (Button()..skin = ButtonSkin.LINK)('Link')
  );
