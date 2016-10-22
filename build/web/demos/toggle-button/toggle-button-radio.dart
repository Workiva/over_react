part of over_react.web.demos;

ReactElement radioToggleButtonDemo() =>
  (ToggleButtonGroup()
    ..toggleType = ToggleBehaviorType.RADIO
  )(
    (ToggleButton()
      ..value = '1'
    )('Radio 1'),
    (ToggleButton()
      ..value = '2'
      ..defaultChecked = true
    )('Radio 2'),
    (ToggleButton()
      ..value = '3'
    )('Radio 3')
  );
