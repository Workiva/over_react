part of web_skin_dart.ui_core;

/// Returns a copy of the specified props map, omitting reserved React and test props by default,
/// in addition to any specified keys.
///
/// Useful for prop forwarding.
Map getPropsToForward(Map props, {bool omitReactProps: true, bool omitTestProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
  Map propsToForward = new Map.from(props);

  if (omitReactProps) {
    propsToForward
      ..remove('key')
      ..remove('ref')
      ..remove('children');
  }

  if (omitTestProps) {
    propsToForward
      ..remove('data-test-id');
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

/// Copies the value for [key] in [source] to [destination] if it exists.
void copyValueIfPresent(Map source, Map destination, dynamic key) {
  if (source.containsKey(key)) {
    destination[key] = source[key];
  }
}
