part of over_react.web.demos;

ReactElement buttonActiveDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()
      ..isActive = true
    )('Primary button'),
    (Button()
      ..isActive = true
      ..skin = ButtonSkin.SECONDARY
    )('Button')
  );
