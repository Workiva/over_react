part of w_ui_platform.ui_core;

enum _SelectablePropsKey {
  IS_SELECTED,
  ON_SELECT,
}

abstract class SelectableProps {
  Map get props;

  bool get isSelected => props[_SelectablePropsKey.IS_SELECTED];
  set isSelected(bool value) => props[_SelectablePropsKey.IS_SELECTED] = value;

  Function get onSelect => props[_SelectablePropsKey.ON_SELECT];
  set onSelect(Function value) => props[_SelectablePropsKey.ON_SELECT] = value;

  /// Returns defaults for the props
  static Map getDefaults() {
    var props = {};

    props[_SelectablePropsKey.IS_SELECTED] = false;

    return props;
  }
}

abstract class SelectableMixin {



//  /**
//   * @param event
//   */
//  handleClick: function (event) {
//    if (this.props.onSelect) {
//      event.preventDefault();
//
//      if (!this.props.disabled) {
//        this.props.onSelect(this.props.eventKey, this.props.href, this.props.target);
//      }
//    }
//  },

}