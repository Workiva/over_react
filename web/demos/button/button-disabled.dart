part of over_react.web.demos;

ReactElement buttonDisabledDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()
      ..isDisabled = true
    )('Primary button'),
    (Button()
      ..href = '#'
      ..isDisabled = true
      ..skin = ButtonSkin.SECONDARY
    )('Link')
  );
