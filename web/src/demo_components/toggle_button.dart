part of over_react.web.demo_components;

/// Use [ToggleButton]s in order to render functional `<input type="checkbox">`
/// or `<input type="radio">` elements that look like a [Button].
///
/// See: <http://v4-alpha.getbootstrap.com/components/buttons/#checkbox-and-radio-buttons>
@Factory()
UiFactory<ToggleButtonProps> ToggleButton;

@Props()
class ToggleButtonProps extends ButtonProps with AbstractInputPropsMixin {
  /// Whether the `<input>` rendered by the [ToggleButton] should have focus upon mounting.
  ///
  /// _Proxies [DomProps.autoFocus]._
  ///
  /// Default: `false`
  @Accessor(keyNamespace: '')
  bool autoFocus;

  /// Whether the [ToggleButton] is checked by default.
  ///
  /// Setting this without the setting the [checked] prop to will make the
  /// [ToggleButton] _uncontrolled_; it will initially render checked or unchecked
  /// depending on the value of this prop, and then update itself automatically
  /// in response to user input, like a normal HTML input.
  ///
  /// Related: [checked]
  ///
  /// _Proxies [DomProps.defaultChecked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#uncontrolled-components>.
  @Accessor(keyNamespace: '')
  bool defaultChecked;

  /// Whether the [ToggleButton] is checked.
  ///
  /// Setting this will make the [ToggleButton] _controlled_; it will not update
  /// automatically in response to user input, but instead will always render
  /// checked or unchecked depending on the value of this prop.
  ///
  /// Related: [defaultChecked]
  ///
  /// _Proxies [DomProps.checked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#controlled-components>.
  @Accessor(keyNamespace: '')
  bool checked;
}

@State()
class ToggleButtonState extends ButtonState with AbstractInputStateMixin {
  /// Tracks if the [ToggleButton] is focused. Determines whether to render with the `js-focus` CSS
  /// class.
  ///
  /// Initial: [ToggleButtonProps.autoFocus]
  bool isFocused;

  /// Tracks if the [ToggleButton] input is `checked`. Determines whether to render with the `active` CSS class.
  ///
  /// Initial: [ToggleButtonProps.checked] `??` [ToggleButtonProps.defaultChecked] `?? false`
  bool isChecked;
}

@Component(subtypeOf: ButtonComponent)
class ToggleButtonComponent extends ButtonComponent<ToggleButtonProps, ToggleButtonState> {
  // Refs

  /// A reference to the [Dom.input] rendered via [renderInput] within the [ToggleButton].
  InputElement inputRef;

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(super.getDefaultProps())
    ..toggleType = ToggleBehaviorType.CHECKBOX
  );

  @override
  Map getInitialState() => (newState()
    ..id = 'toggle_button_' + generateGuid()
    ..isFocused = props.autoFocus
    ..isChecked = props.checked ?? props.defaultChecked ?? false
  );

  @override
  get consumedProps => const [
    const $Props(ToggleButtonProps),
    const $Props(ButtonProps),
    const $Props(AbstractInputPropsMixin),
  ];

  @override
  void componentWillMount() {
    super.componentWillMount();

    _validateProps(props);
  }

  @override
  void componentWillReceiveProps(Map newProps) {
    super.componentWillReceiveProps(newProps);
    var tNewProps = typedPropsFactory(newProps);

    _validateProps(tNewProps);

    if (tNewProps.checked != null && props.checked != tNewProps.checked) {
      setState(newState()..isChecked = tNewProps.checked);
    }
  }

  @override
  render() {
    return renderButton(
      [
        renderInput(),
        props.children
      ]
    );
  }

  ReactElement renderInput() {
    var builder = Dom.input()
      ..type = props.toggleType.typeName
      ..id = id
      ..name = props.name
      ..tabIndex = props.tabIndex
      ..disabled = props.isDisabled
      ..autoFocus = props.autoFocus
      ..onChange = props.onChange
      ..onClick = props.onClick
      ..style = makeInputNodeInvisible
      ..ref = (ref) { inputRef = ref; }
      ..key = 'input';

    // ********************************************************
    //
    //  React JS 15.0 Workarounds
    //
    //  [1] Starting from React 15.0, the checked/defaultChecked
    //      props should not be set with a cascading setter
    //      because it will recognize the null as a "clear input"
    //      rather than a request to make the input controlled
    //      vs uncontrolled.
    //
    //  [2] React 15.0 introduced a bug that warns when setting
    //      value to null on an input even if that input is of
    //      type radio or checkbox. This comes from treating
    //      setting value as a controlled input even when it
    //      should not.
    //
    //      See: https://github.com/facebook/react/issues/6779
    //
    // ********************************************************

    if (props.defaultChecked != null) builder.defaultChecked = state.isChecked; // [1]
    if (props.checked != null) builder.checked = state.isChecked; // [1]
    if (props.value != null) builder.value = props.value; // [2]

    return builder();
  }

  /// Returns a map of inline CSS styles to be applied to the HTML `<input>` node.
  ///
  /// These styles are a workaround to hide the input in an a11y-friendly manner since
  /// the bootstrap styles we are using for the demo components uses an HTML attribute
  /// CSS selector that we do not want to use since we're demoing how to build a stateful
  /// toggle button with OverReact, not with Bootstrap's jQuery plugin data-api hook.
  ///
  /// In an actual implementation, you would want to add a unique class to the root of this
  /// component, and add these styles in your app / component library stylesheet.
  Map<String, dynamic> get makeInputNodeInvisible => {
    'position': 'absolute',
    'clip': 'rect(0,0,0,0)',
    'pointerEvents': 'none'
  };

  /// Checks the `<input>` element to ensure that [ToggleButtonState.isChecked]
  /// matches the value of the [InputElement.checked] attribute.
  ///
  /// Does not refresh the state if [ToggleButtonProps.checked] is not null
  /// (the component is a "controlled" component).
  void _refreshState() {
    if (!_isControlled) setState(newState()..isChecked = inputRef.checked);
  }

  void _validateProps(ToggleButtonProps props) {
    assert(
        (props.toggleType == ToggleBehaviorType.RADIO && props.name != null) ||
        props.toggleType == ToggleBehaviorType.CHECKBOX
    );
  }

  /// Used to check if the `input` element is controlled or not.
  bool get _isControlled => props.checked != null;

  @override
  bool get _isActive => state.isChecked;

  @override
  String get _type => null;

  @override
  BuilderOnlyUiFactory<DomProps> get _buttonDomNodeFactory => Dom.label;

  /// The id to use for a [ToggleButton].
  ///
  /// Attempts to use [AbstractInputPropsMixin.id] _(specified by the consumer)_, falling back to
  /// [AbstractInputStateMixin.id] _(auto-generated)_.
  String get id => props.id ?? state.id;
}
