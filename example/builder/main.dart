// Copyright 2020 Workiva Inc.
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
import 'package:redux/redux.dart';

import './src/abstract_inheritance.dart';
import './src/basic.dart';
import './src/basic_library.dart';
import './src/generic_inheritance_sub.dart';
import './src/generic_inheritance_super.dart';
import './src/function_component.dart' as function;
import 'src/functional_consumed_props.dart';
import 'src/new_class_consumed_props.dart';
import 'src/unstable.dart';

class ExampleState {
  final String testValue;

  ExampleState(this.testValue);
}

Store store = Store<ExampleState>((_, __) => ExampleState('foo'), initialState: ExampleState('foo'));

main() {
  react_dom.render(
      (ReduxProvider()..store = store)(
      Dom.div()(
        Dom.h3()('Components'),
        (UnstableTest().unstable
          ..legitProp = true
          ..fakeProp = 'the id of this component'
        )('this is a child of UnstableTest'),
        (Sub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
        (GenericSub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
        (GenericSuper()
          ..superProp = '<superProp>'
        )(),
        (BasicPartOfLib()
          ..basicProp = 'basic part of lib'
          ..propMixin1 = 'mixin to basic part of lib'
        )(),
        (SubPartOfLib()
          ..subProp = 'sub prop part of lib'
          ..superProp = 'super prop part of lib'
        )(),
        Dom.h3()('Function component:'),
        function.functionComponentContent(),
        Dom.h3()('getDefaultProps via component factories'),
        componentConstructorsByName.keys.map((name) => Dom.div()(
          'new $name()',
          ' - ',
          componentConstructorsByName[name]().toString(),
        )).toList(),
        (SomeParent()
          ..aParentProp = 'parent'
          ..aPropToBePassed = 'passed'
        )(),
        (SomeClassParent()
          ..aParentProp = 'classParent'
          ..aPropToBePassed = 'passed'
        )(),
      )
      ), querySelector('#content')
  );
}

final componentConstructorsByName = <String, Map Function()>{
  'BasicComponent': () => typedDefaultPropsFor(Basic),
  'SubComponent': () => typedDefaultPropsFor(Sub),
  'GenericSuperComponent': () => typedDefaultPropsFor(GenericSuper),
  'GenericSubComponent': () => typedDefaultPropsFor(GenericSub),
};
