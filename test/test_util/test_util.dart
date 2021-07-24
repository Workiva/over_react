// Copyright 2016 Workiva Inc.
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

library test_util;

import 'dart:js_util';

import 'package:over_react/over_react.dart';

export 'package:over_react_test/over_react_test.dart' hide testJsComponentFactory;

dynamic getJsChildren(instance) => getProperty(instance.props as Object, 'children');

dynamic getDartChildren(var renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}

bool isDDC() {
  bool assertsEnabled = false;
  assert(assertsEnabled = true);
  return assertsEnabled;
}
