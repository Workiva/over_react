// ignore_for_file: deprecated_member_use_from_same_package
@JS()
library over_react.src.component_debug_name;

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:over_react/component_base.dart';

/// Returns the displayName of the given [component].
///
/// __For use in debugging contexts only; not suitable for other use.__
///
// Need to ignore this just for Dart 2.7.2
// ignore: comment_references
/// This is preferable to [UiComponent.displayName] since that doesn't include
/// the generated displayName passed to [registerComponent]/
String getDebugNameForDartComponent(UiComponent component) {
  // We don't have a great way of looking up the display name the component was
  // registered with, so we'll resort to pulling it off the JS component.

  // Don't assume the component is mounted.
  final jsThis = component.jsThis;
  if (jsThis != null) {
    final jsPrototype = _getPrototypeOf(jsThis);
    final jsComponentType =
        jsPrototype == null ? null : getProperty(jsPrototype, 'constructor');
    if (jsComponentType != null) {
      return (getProperty(jsComponentType, 'displayName') as String) ??
          (getProperty(jsComponentType, 'name') as String);
    }
  }

  // Fall back to displayName, which only uses the runtimeType, but only when asserts are enabled in Component2.
  return component.displayName;
}

@JS('Object.getPrototypeOf')
external dynamic _getPrototypeOf(dynamic object);
