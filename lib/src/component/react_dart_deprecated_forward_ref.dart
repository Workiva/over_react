
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/zone.dart';

/// A copy of the `forwardRef` function that was removed from react-dart in 7.0.0,
/// but is still needed by the deprecated `forwardRef` in over_react.
///
/// We'll remove this copy once we remove over_react's forwardRef in the next major.
@internal
ReactJsComponentFactoryProxy forwardRef(
  Function(Map props, Ref ref) wrapperFunction, {
  String displayName = 'Anonymous',
}) {
  // ignore: invalid_use_of_visible_for_testing_member
  final wrappedComponent = allowInterop((JsMap props, ref) => componentZone.run(() {
        final dartProps = JsBackedMap.backedBy(props);
        for (final value in dartProps.values) {
          if (value is Function) {
            // Tag functions that came straight from the JS
            // so that we know to pass them through as-is during prop conversion.
            isRawJsFunctionFromProps[value] = true;
          }
        }

        final dartRef = Ref.fromJs(ref as JsRef);
        return wrapperFunction(dartProps, dartRef);
      }));
  defineProperty(wrappedComponent, 'displayName', JsPropertyDescriptor(value: displayName));

  final hoc = React.forwardRef(wrappedComponent);
  // ignore: invalid_use_of_protected_member
  setProperty(hoc, 'dartComponentVersion', ReactDartComponentVersion.component2);

  return ReactJsComponentFactoryProxy(hoc, alwaysReturnChildrenAsList: true);
}

@JS()
@anonymous
class JsPropertyDescriptor {
  external factory JsPropertyDescriptor({dynamic value});
}

@JS('Object.defineProperty')
external void defineProperty(dynamic object, String propertyName, JsPropertyDescriptor descriptor);
