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

@TestOn('content-shell || dartium')
library over_react.integrate.test_runtime_import;

import 'package:react/react_client.dart' show setClientConfiguration;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

/// Entry point into tests
main() {
  setClientConfiguration();

  test('consumes over_react\'s transformed code as expected', () {
    var props = domProps();
    props.className = 'test-class';
    expect(props, containsPair('className', 'test-class'),
        reason: 'className setter should have proxied the correct key-value pair');
  });

  test('renders without breaking', () {
    var well = react_test_utils.renderIntoDocument(Dom.div()('Hello World!'));
    expect(well, isNotNull);
  });
}
