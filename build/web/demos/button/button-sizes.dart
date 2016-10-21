part of over_react.web.demos;

ReactElement buttonSizesDemo() =>
  (Dom.div()..className = 'btn-toolbar')(
    (Button()..size = ButtonSize.SMALL)('Small'),
    Button()('Default'),
    (Button()..size = ButtonSize.LARGE)('Large')
  );
