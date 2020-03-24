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

// Currently dart_dev only runs tests on dart files that end with _test.
// So this file's name had to change to match.
// It can be changed back when that issue is taken care of.
// https://github.com/Workiva/dart_dev/issues/74
@TestOn('browser')
library util_test;

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

import 'over_react/util/class_names_test.dart' as class_names_test;
import 'over_react/util/constants_base_test.dart' as constants_base_test;
import 'over_react/util/css_value_util_test.dart' as css_value_util_test;
import 'over_react/util/dom_util_test.dart' as dom_util_test;
import 'over_react/util/event_helpers_test.dart' as event_helpers_test;
import 'over_react/util/guid_util_test.dart' as guid_util_test;
import 'over_react/util/handler_chain_util_test.dart' as handler_chain_util_test;
import 'over_react/util/hoc_test.dart' as hoc_test;
import 'over_react/util/map_util_test.dart' as map_util_test;
import 'over_react/util/pretty_print_test.dart' as pretty_print_test;
import 'over_react/util/prop_key_util_test_dart2.dart' as prop_key_util_test_dart2;
import 'over_react/util/react_util_test.dart' as react_util_test;
import 'over_react/util/react_wrappers_test.dart' as react_wrappers_test;
import 'over_react/util/rem_util_test.dart' as rem_util_test;
import 'over_react/util/safe_render_manager/safe_render_manager_test.dart' as safe_render_manager_test;
import 'over_react/util/safe_render_manager/safe_render_manager_helper_test.dart' as safe_render_manager_helper_test;
import 'over_react/util/string_util_test.dart' as string_util_test;
import 'over_react/util/test_mode_test.dart' as test_mode_test;

void main() {
  enableTestMode();

  class_names_test.main();
  constants_base_test.main();
  css_value_util_test.main();
  dom_util_test.main();
  event_helpers_test.main();
  guid_util_test.main();
  handler_chain_util_test.main();
  hoc_test.main();
  map_util_test.main();
  pretty_print_test.main();
  prop_key_util_test_dart2.main();
  react_util_test.main();
  react_wrappers_test.main();
  rem_util_test.main();
  safe_render_manager_test.main();
  safe_render_manager_helper_test.main();
  string_util_test.main();
  test_mode_test.main();
}
