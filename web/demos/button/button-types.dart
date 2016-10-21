part of over_react.web.demos;

ReactElement buttonTypesDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    Button()('Button'),
    (Button()..href = '#')('Link'),
    (Button()..type = ButtonType.SUBMIT)('Submit'),
    (Button()..type = ButtonType.RESET)('Reset')
  );
