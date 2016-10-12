library ui_core.js_util;

import 'dart:js';

/// [Global JavaScript Array Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)
JsObject jsArray = context['Array'];

/// Store a helper reference to the global [jsArray]'s [`slice` method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)
JsObject arrayProtoSlice = jsArray['prototype']['slice'];

/// Converts the Array-like [object] to a [JsArray] using [arrayProtoSlice].
JsArray convertToArray(JsObject object) {
  return arrayProtoSlice.callMethod('apply', [object]);
}
