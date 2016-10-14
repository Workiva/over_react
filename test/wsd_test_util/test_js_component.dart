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

library test_util.test_js_component;

import 'package:js/js.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';

/// A factory for a JS composite component.
final Function testJsComponentFactory = (() {
  var componentClass = React.createClass(new ReactClassConfig(
    displayName: 'testJsComponent',
    render: allowInterop(() => react.div({}, 'test js component'))
  ));

  var reactFactory = React.createFactory(componentClass);

  return ([props = const {}, children]) {
    return reactFactory(jsify(props), listifyChildren(children));
  };
})();
