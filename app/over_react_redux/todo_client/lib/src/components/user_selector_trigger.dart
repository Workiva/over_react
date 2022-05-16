part of todo_client.src.components.user_selector;

UiFactory<UserSelectorTriggerProps> UserSelectorTrigger =
    castUiFactory(_$UserSelectorTrigger); // ignore: undefined_identifier

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

  @override
  render() {
    final propsToForward = Map.of(props)..remove('selectedUserName');
    return IconButton({
      ...propsToForward,
      // Avatar height is 40px, so 4px on top and bottom will make it match the default height of adjacent IconButtons (48px)
      'style': {
        'padding': '4px',
      },
    },
      (AvatarWithColors()..fullName = props.selectedUserName)(),
    );
  }
}
