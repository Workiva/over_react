part of web_skin_dart.ui_core;

/// Creates a EventKeyCallback that calls through to the two provided callbacks in order.
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
EventKeyCallback createChainedEventKeyCallback(EventKeyCallback a, EventKeyCallback b) {
  return (react.SyntheticEvent event, dynamic eventKey) {
    var aDidReturnFalse = a != null ? a(event, eventKey) == false : false;
    var bDidReturnFalse = b != null ? b(event, eventKey) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}
