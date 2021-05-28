

// Copyright 2021 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:react/react_dom.dart' as react_dom;

import '../builder/main.dart';
import 'backwards_compatible/basic.dart' as backwards_compatible;
import 'dart2_only/basic_component1.dart' as dart2_only_component1;
import 'dart2_only/basic_component2.dart' as dart2_only_component2;
import 'mixin_based/pre_dart_2_9/basic.dart' as pre_dart_2_9_basic;
import 'mixin_based/pre_dart_2_9/function_component.dart' as pre_dart_2_9_function;
import 'mixin_based/pre_dart_2_9/hoc.dart' as pre_dart_2_9_hoc;
import 'mixin_based/dart_2_9_compatible/basic.dart' as dart_2_9_compatible_basic;
import 'mixin_based/dart_2_9_compatible/function_component.dart' as dart_2_9_compatible_function;
import 'mixin_based/dart_2_9_compatible/hoc.dart' as dart_2_9_compatible_hoc;

main() {
  react_dom.render(
      (ReduxProvider()..store = store)(Dom.div()(
        Dom.h2()('Components'),
        Dom.h3()('Backwards Compatible Boilerplate'),
        (backwards_compatible.Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component')(null, null, ['this is another child']),
        Dom.h3()('Dart 2 Only Boilerplate'),
        Dom.h4()('Component1'),
        (dart2_only_component1.Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component')(null, null, ['this is another child']),
        Dom.h4()('Component2'),
        (dart2_only_component2.Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component')(null, null, ['this is another child']),
        Dom.h3()('Mixin Based Boilerplate'),
        Dom.h4()('Dart <2.9.0 syntax'),
        (pre_dart_2_9_basic.Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component')(null, null, ['this is another child']),
        pre_dart_2_9_function.FunctionComponent()(),
        (pre_dart_2_9_hoc.Hoc()..foo = 'HOC test')(),
        (pre_dart_2_9_hoc.ConnectedHocWithTwoFactories()..foo = 'HOC test')(),
        Dom.h4()('Dart >=2.9.0 syntax'),
        (dart_2_9_compatible_basic.Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component')(null, null, ['this is another child']),
        dart_2_9_compatible_function.FunctionComponent()(),
        (dart_2_9_compatible_hoc.Hoc()..foo = 'HOC test')(),
        (dart_2_9_compatible_hoc.ConnectedHocWithTwoFactories()..foo = 'HOC test')(),
      )),
      querySelector('#content'));
}
