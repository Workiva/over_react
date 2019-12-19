part of todo_client.src.components.user_selector;

@Factory()
UiFactory<UserSelectorTriggerProps> UserSelectorTrigger =
    // ignore: undefined_identifier
    _$UserSelectorTrigger;

@Props(keyNamespace: '')
class _$UserSelectorTriggerProps extends UiProps {
  String selectedUserName;
  bool disabled;
}

@Component2()
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

// ignore: mixin_of_non_class, undefined_class
class UserSelectorTriggerProps extends _$UserSelectorTriggerProps with _$UserSelectorTriggerPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForUserSelectorTriggerProps;
}
