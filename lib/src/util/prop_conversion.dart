import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart' show Ref;
import 'package:over_react/src/util/weak_map.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart' show JsRef;

// Export JsMap since props that utilize jsifyMapProp/unjsifyMapProp
// via custom getters/setters will need JsMap to avoid implicit cast errors.
export 'package:react/react_client/js_backed_map.dart' show JsMap;

/// Returns a JS-deep-converted version of [value] for storage in the props map, or null if [value] is null.
///
/// For use in JS component prop setters where the component expects a JS object, but typing the getter/setter
/// as a Dart Map is more convenient to the consumer reading/writing the props.
///
/// Should be used alongside [unjsifyMapProp].
///
/// For more information on why this conversion is done in the getter/setter,
/// see documentation around Dart wrapper component prop conversion issues.
/// FIXME CPLAT-15060 add reference/link to documentation
JsMap jsifyMapProp(Map value) {
  if (value == null) return null;
  // Use generateJsProps so that, in addition to deeply converting props, we also properly convert the `ref` prop.
  // Dart props get deep converted (just like they would when invoking the ReactJsComponentFactoryProxy anyways),
  // but that's a tradeoff we're willing to make, given that there's no perfect solution,
  // and shouldn't happen often since we shouldn't be passing Dart values to JS components.
  // As a workaround, consumers can wrap any Dart values in an opaque Dart object (similar to DartValueWrapper).
  return generateJsProps(value);
}

/// Returns [value] converted to a Dart map and [Map.cast]ed to the provided generics, or null if [value] is null.
///
/// For use in JS component prop getters where the component expects a JS object, but typing the getter/setter
/// as a Dart Map is more convenient to the consumer reading/writing the props.
///
/// Should be used alongside [jsifyMapProp].
///
/// For more information on why this conversion is done in the getter/setter,
/// see documentation around Dart wrapper component prop conversion issues.
/// FIXME CPLAT-15060 add reference/link to documentation
Map<K, V> unjsifyMapProp<K, V>(JsMap value) {
  if (value == null) return null;
  // Don't deep unconvert so that JS values don't get converted incorrectly to Maps. See jsifyMapProp for more information.
  return JsBackedMap.backedBy(value).cast();
}

/// Returns [value] converted to its JS ref representation for storage in a props map, or null of the [value] is null.
///
/// For use in JS component prop getters where the component expects a JS ref, but accepting Dart refs
/// is more convenient to the consumer reading/writing the props.
///
/// Should be used alongside [unjsifyRefProp].
///
/// Normally ref props get converted in [ReactJsComponentFactoryProxy.build] and [jsifyMapProp],
/// but that same conversion for props not under the default `'ref'` key doesn't occur automatically,
/// which is where this function comes in.
dynamic jsifyRefProp(dynamic value) {
  // Case 1: null
  if (value == null) return null;

  // Case 2a: Dart callback refs
  // Case 2b: JS callback refs
  // allowInterop is technically redundant, since that will get done in ReactJsComponentFactoryProxy.build
  // (or jsifyMapProp for props that accept props maps, like ButtonProps.TouchRippleProps),
  // but we'll do it here anyways since we know it'll be needed.
  if (value is Function) return allowInterop(value);

  // Case 2: Dart ref objects
  if (value is Ref) {
    // Store the original Dart ref so we can retrieve it later in unjsifyRefProp.
    // See _dartRefForJsRef comment for more info.
    _dartRefForJsRef.set(value.jsRef, value);
    return value.jsRef;
  }

  // Case 3: JS ref objects
  return value;
}

/// Returns a [JsRef] object converted back into its Dart [Ref] object (if it was converted via [jsifyRefProp],
/// or if [value] is not a [JsRef], passes through [value] (including null).
///
/// For use in JS component prop getters where the component expects a JS ref, but accepting Dart refs
/// is more convenient to the consumer reading/writing the props.
///
/// Should be used alongside [unjsifyRefProp].
///
/// Note that Dart refs currently lose their reified types when jsified/unjsified.
dynamic unjsifyRefProp(dynamic value,
    {@visibleForTesting bool throwOnUnhandled = false}) {
  // Case 1: null
  if (value == null) return null;

  // Case 2: JS callback refs
  if (value is Function) return value;

  // Case 2: JS ref objects
  if (value is! Ref && value is JsRef && hasProperty(value, 'current')) {
    // Return the original Dart ref is there is one, otherwise return the JsRef itself.
    // See _dartRefForJsRef comment for more info.
    return _dartRefForJsRef.get(value) ?? value;
  }

  // Case 3: unreachable?
  // We shouldn't ever get here, but just pass through the value in case there's
  // a case we didn't handle properly above (or throw for testing purposes).
  if (throwOnUnhandled) {
    throw ArgumentError.value(value, 'value', 'Unhandled case');
  }
  return value;
}

/// A weak mapping from JsRef objects to the original Dart Refs they back.
///
/// Useful for
/// 1. Preserving the reified type of the Dart ref when it gets jsified/unjsified
/// 2. Telling whether the ref was originally a Dart or JS ref
///
/// We're using WeakMap here so that we don't have a global object strongly referencing and thus retaining refs,
/// and not because strong references from the JS ref to the Dart ref would be problematic.
///
/// We also have to use a WeakMap instead of a JS property (or an Expando, whose DDC implementation uses JS properties),
/// since those can't be used  with sealed JS objects (like React.createRef() objects in development builds, and potentially other cases).
final _dartRefForJsRef = WeakMap();
