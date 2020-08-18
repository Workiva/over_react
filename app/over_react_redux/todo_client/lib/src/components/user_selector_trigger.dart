part of todo_client.src.components.user_selector;

UiFactory<UserSelectorTriggerProps> UserSelectorTrigger =
    _$UserSelectorTrigger; // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin UserSelectorTriggerProps on UiProps {
  String selectedUserName;
  bool disabled;
}

class UserSelectorTriggerComponent extends UiComponent2<UserSelectorTriggerProps> {
  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) {
    final tNextProps = typedPropsFactory(nextProps);
    return tNextProps.selectedUserName != props.selectedUserName || tNextProps.disabled != props.disabled;
  }

  @override
  get defaultProps => (newProps()..disabled = false);

  static final _selectedUserNamePropKey = getPropKey((p) => p.selectedUserName, UserSelectorTrigger);

  @override
  Iterable<ConsumedProps> get consumedProps => [
    PropsMeta.forSimpleKey(_selectedUserNamePropKey)
  ];

  @override
  render() {
    return (IconButton()
        ..modifyProps(addUnconsumedProps)
        // Avatar height is 40px, so 4px on top and bottom will make it match the default height of adjacent IconButtons (48px)
        ..style = {'padding': '4px'}
    )(
      (AvatarWithColors()..fullName = props.selectedUserName)(),
    );
  }
}
