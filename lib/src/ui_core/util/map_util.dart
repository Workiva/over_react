part of web_skin_dart.ui_core;

/// Returns a copy of the specified props map, omitting reserved React props by default,
/// in addition to any specified keys.
///
/// Useful for prop forwarding.
Map getPropsToForward(Map props, {bool omitReactProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
  Map propsToForward = new Map.from(props);

  if (omitReactProps) {
    propsToForward
      ..remove(ReactProps.Z_$KEY__KEY)
      ..remove(ReactProps.Z_$KEY__REF)
      ..remove(ReactProps.Z_$KEY__CHILDREN);
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
