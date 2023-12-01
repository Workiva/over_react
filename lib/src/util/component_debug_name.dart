// ignore_for_file: deprecated_member_use_from_same_package
@JS()
library over_react.src.component_debug_name;

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:over_react/component_base.dart';

/// __For use in debugging contexts only; not suitable for other use.__
/// If there's another use-case for getting a component name from its mounted
/// instance, we should reevaluate approach here.
///
/// Returns the displayName of the given [component].
///
/// This is preferable to `UiComponent.displayName` since that doesn't include
/// the generated displayName passed to [registerComponent]/
String? getDebugNameForDartComponent(UiComponent component) {
  // We don't have a great way of looking up the display name the component was
  // registered with, so we'll resort to pulling it off the JS component.

  // This should always be non-null for a mounted component,
  // and will throw a LateInitializationError for Dart components
  // that haven't been mounted yet.
  final jsThis = component.jsThis! as Object;
  final jsPrototype = _getPrototypeOf(jsThis);
  final jsComponentType =
      jsPrototype == null ? null : getProperty<Object?>(jsPrototype, 'constructor');
  if (jsComponentType != null) {
    return getProperty<String?>(jsComponentType, 'displayName') ??
        getProperty<String?>(jsComponentType, 'name');
  }

  // Fall back to displayName, which only uses the runtimeType, but only when asserts are enabled in Component2.
  return component.displayName;
}

@JS('Object.getPrototypeOf')
external Object? _getPrototypeOf(Object object);
