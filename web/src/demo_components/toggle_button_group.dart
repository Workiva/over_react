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

  /// The props that should be added when we clone the given [child] using
  /// [cloneElement] via [renderButton].
  @override
  ToggleButtonProps buttonPropsToAdd(dynamic child, int index) {
    var childProps = childFactory(getProps(child));
    var childKey = getInstanceKey(child);

    ButtonProps superPropsToAdd = super.buttonPropsToAdd(child, index);

    return childFactory()
      ..addProps(superPropsToAdd)
      ..name = name
      ..toggleType = props.toggleType
      ..onChange = formEventCallbacks.chain(props.onChange, _handleOnChange)
      ..value = childProps.value ?? index
      ..ref = chainRef(child, (ref) { _toggleButtonRefs[index] = ref; });
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

  /// The factory expected for each child of [ToggleButtonGroup].
  @override
  UiFactory<ToggleButtonProps> get childFactory => ToggleButton;
}
