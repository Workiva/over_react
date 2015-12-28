part of web_skin_dart.ui_core;

/// Returns a copy of the specified props map, omitting reserved React and test props by default,
/// in addition to any specified keys.
///
/// Useful for prop forwarding.
Map getPropsToForward(Map props, {bool omitReactProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
  Map propsToForward = new Map.from(props);

  if (omitReactProps) {
    propsToForward
      ..remove('key')
      ..remove('ref')
      ..remove('children');
  }

  if (keysToOmit != null) {
    keysToOmit.forEach((key) {
      propsToForward.remove(key);
    });
  }

  if (keySetsToOmit != null) {
    keySetsToOmit.forEach((Iterable keySet) {
      keySet.forEach((key) {
        propsToForward.remove(key);
      });
    });
  }

  return propsToForward;
}
