part of over_react.web.demo_components;

/// A specialized [ButtonGroup] component that will surround one or more child
/// [ToggleButton] components so that a single shared [ToggleButtonGroupProps.name]
/// value can be applied to the aforementioned children via [cloneElement].
///
/// __Renders HTML Markup:__
///
///     <div class="form-group {props.size.class} {props.formGroupProps.className}">
///       <label class="control-label {props.groupLabelWidth.class}" for="{state.name}">
///         {props.groupLabel}
///       </label>
///       <div class="{props.wrapperClassName} {props.groupControlsWidth.class}">
///         <div class="btn-group {props.buttonSize.class}" data-toggle="buttons" role="group">
///           {props.children}
///         </div>
///       </div>
///     </div>
///
/// See: <http://v4-alpha.getbootstrap.com/components/buttons/#checkbox-and-radio-buttons>
@Factory()
UiFactory <ToggleButtonGroupProps> ToggleButtonGroup;

@Props()
class ToggleButtonGroupProps extends ButtonGroupProps with AbstractInputPropsMixin {}

@State()
class ToggleButtonGroupState extends ButtonGroupState with AbstractInputStateMixin {}

@Component(subtypeOf: ButtonGroupComponent)
class ToggleButtonGroupComponent extends ButtonGroupComponent<ToggleButtonGroupProps, ToggleButtonGroupState> {
  // Refs

  Map<int, dynamic> _toggleButtonRefs = <int, dynamic>{};

  /// The name to use for all children of a [ToggleButtonGroup].
  ///
  /// Attempts to use [ToggleButtonGroupProps.name] _(specified by the consumer)_, falling back to
  /// [ToggleButtonGroupState.name] _(auto-generated)_.
  String get name => props.name ?? state.name;

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(super.getDefaultProps())
    ..toggleType = ToggleBehaviorType.CHECKBOX
  );

  @override
  Map getInitialState() => (newState()
    ..addAll(super.getInitialState())
    ..name = 'toggle_button_group_' + generateGuid()
  );

  @override
  get consumedProps => const [
    const $Props(ToggleButtonGroupProps),
  ];

  @override
  render() {
    var toggleButtons = [];

    for (int index = 0; index < props.children.length; index++) {
      toggleButtons.add(renderToggleButton(props.children[index], index));
    }

    return renderButtonGroup(toggleButtons);
  }

  /// Render an individual child [ToggleButton], cloned to apply the shared [name] value.
  renderToggleButton(child, int index) {
    if (_isValidToggleButtonChild(child)) {
      var childProps = ToggleButton(getProps(child));
      var childKey = getInstanceKey(child);

      var propsToAdd = ToggleButton()
        ..name = name
        ..toggleType = props.toggleType
        ..skin = props.skin ?? childProps.skin
        ..onChange = formEventCallbacks.chain(props.onChange, _handleOnChange)
        ..value = childProps.value ?? index
        ..key = childKey ?? index
        ..ref = chainRef(child, (ref) { _toggleButtonRefs[index] = ref; });

      return cloneElement(child, propsToAdd);
    }

    return child;
  }

  @override
  ClassNameBuilder getButtonGroupClasses() {
    return super.getButtonGroupClasses()
      ..add('btn-toggle-group');
  }

  /// The handler for when one of the children of the [ToggleButtonGroup] is changed or unchecked
  void _handleOnChange(_) {
    _toggleButtonRefs.values.forEach((childComponent) {
      if (childComponent is ToggleButtonComponent) childComponent._refreshState();
    });
  }

  bool _isValidToggleButtonChild(child) {
    var isCloneable = false;
    if (isValidElement(child)) {
      if (!isComponentOfType(child, ToggleButton)) {
        assert(ValidationUtil.warn(
            'Children of ToggleButtonGroup should be ToggleButton instances.'
        ));
      }

      isCloneable = true;
    } else if (child != null) {
      assert(ValidationUtil.warn(
          'You are not using a valid ReactElement.'
      ));
    }

    return isCloneable;
  }
}
