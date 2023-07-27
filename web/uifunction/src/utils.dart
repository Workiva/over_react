import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';
import 'package:react/react_client/js_interop_helpers.dart';

import 'component_wrapper.dart';

const undefined = Undefined();
class Undefined {
  const Undefined();
}

log([c1 = undefined, c2 = undefined, c3 = undefined, c4 = undefined, c5 = undefined, c6 = undefined, c7 = undefined, c8 = undefined, c9 = undefined, c10 = undefined, c11 = undefined, c12 = undefined, c13 = undefined, c14 = undefined, c15 = undefined, c16 = undefined, c17 = undefined, c18 = undefined, c19 = undefined, c20 = undefined, c21 = undefined, c22 = undefined, c23 = undefined, c24 = undefined, c25 = undefined, c26 = undefined, c27 = undefined, c28 = undefined, c29 = undefined, c30 = undefined, c31 = undefined, c32 = undefined, c33 = undefined, c34 = undefined, c35 = undefined, c36 = undefined, c37 = undefined, c38 = undefined, c39 = undefined, c40 = undefined]) {
  final arguments = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]
        .takeWhile((child) => !identical(child, undefined))
        .toList()
        ..map((element) {
          try { return jsifyAndAllowInterop(element); } catch (e){}
          return element;
        });
  return callMethod(getProperty(window,'console'), 'log', [...arguments]);
}

group(String groupName) => window.console.group(groupName);

groupEnd() => window.console.groupEnd();

final DomDivDemo = createVisualComponent(Dom.div, domOnly: true);
