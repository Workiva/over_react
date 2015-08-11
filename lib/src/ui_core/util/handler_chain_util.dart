part of w_ui_platform.ui_core;

EventKeyCallback createChainedEventKeyCallback(EventKeyCallback a, EventKeyCallback b) {
  return (react.SyntheticEvent event, dynamic eventKey) {
    var aDidPreventDefault = a != null ? a(event, eventKey) == false : false;
    var bDidPreventDefault = b != null ? b(event, eventKey) == false : false;

    if (aDidPreventDefault || bDidPreventDefault)
      return false;
  };
}
