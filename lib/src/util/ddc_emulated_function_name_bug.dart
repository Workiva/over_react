/// Provides detection and patching of the bug described in <https://github.com/dart-lang/sdk/issues/27647>,
/// in which getters/setters with the identifier `name` don't work for emulated function classes, like [UiProps].
@JS()
library over_react.src.util.ddc_emulated_function_name_bug;

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';

/// Create a reduced test case of the issue, using an emulated function pattern that is similar to [UiProps].
///
/// We can't use [UiProps] itself, since it uses [isBugPresent], and that would cause a cyclic initialization error.
class _NsmEmulatedFunctionWithNameProperty implements Function {
  void call();

  @override
  noSuchMethod(i) {}

  String _name;

  // ignore: unnecessary_getters_setters
  String get name => _name;
  // ignore: unnecessary_getters_setters
  set name(String value) => _name = value;
}

/// Whether this bug, <https://github.com/dart-lang/sdk/issues/27647>, is present in the current runtime.
///
/// This performs functional detection of the bug, and  will be `true`
/// only in the DDC and only in versions of the DDC where this bug is present.
final bool isBugPresent = (() {
  const testValue = 'test value';

  var testObject = new _NsmEmulatedFunctionWithNameProperty();

  try {
    // In the DDC, this throws:
    //     TypeError: Cannot assign to read only property 'name' of function 'function call(...args) {
    //       return call.call.apply(call, args);
    //     }'
    testObject.name = testValue;
  } catch(_) {
    return true;
  }

  try {
    // We don't expect accessing this to throw, but just in case...
    return testObject.name != testValue;
  } catch(_) {
    return true;
  }
})();


@JS()
@anonymous
class _PropertyDescriptor {}

@JS('Object.getPrototypeOf')
external dynamic _getPrototypeOf(dynamic object);

@JS('Object.getOwnPropertyDescriptor')
external _PropertyDescriptor _getOwnPropertyDescriptor(dynamic object, String propertyName);

@JS('Object.defineProperty')
external void _defineProperty(dynamic object, String propertyName, _PropertyDescriptor descriptor);

/// Patches the `name` property on the given [object] to have the expected behavior
/// by copying the property descriptor for `name` from the appropriate prototype.
///
/// This is a noop if `name` is not a property on the given object.
///
/// __This functionality is unstable, and should not be used when [isBugPresent] is `false`.__
///
/// This method also had undefined behavior on non-[UiProps] instances.
void patchName(dynamic object) {
  var current = object;
  while ((current = _getPrototypeOf(current)) != null) {
    var nameDescriptor = _getOwnPropertyDescriptor(current, 'name');

    if (nameDescriptor != null) {
      _defineProperty(object, 'name', nameDescriptor);
      return;
    }
  }
}
