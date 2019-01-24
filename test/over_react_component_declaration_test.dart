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
library over_react_test;

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

import 'over_react/component_declaration/component_base_test.dart' as component_base_test;
import 'over_react/component_declaration/component_type_checking_test.dart' as component_type_checking_test;
import 'over_react/component_declaration/flux_component_test.dart' as flux_component_test;
import 'over_react/component_declaration/redux_component_test.dart' as redux_component_test;
import 'over_react/component_declaration/transformer_helpers_test.dart' as transformer_helpers_test;
import 'over_react/component_declaration/transformer_integration_tests/abstract_accessor_integration_test.dart' as dart2_abstract_accessor_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/accessor_mixin_integration_test.dart' as dart2_accessor_mixin_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/component_integration_test.dart' as dart2_component_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/constant_required_accessor_integration_test.dart' as dart2_constant_required_accessor_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/do_not_generate_accessor_integration_test.dart' as dart2_do_not_generate_accessor_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/namespaced_accessor_integration_test.dart' as dart2_namespaced_accessor_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/required_accessor_integration_test.dart' as dart2_required_accessor_integration_test;
import 'over_react/component_declaration/transformer_integration_tests/stateful_component_integration_test.dart' as dart2_stateful_component_integration_test;

main() {
  setClientConfiguration();

  enableTestMode();

  component_base_test.main();
  component_type_checking_test.main();
  flux_component_test.main();
  redux_component_test.main();

  // TODO: Put this back in/update to dart2 once the build for this file is figured out
  transformer_helpers_test.main();

  dart2_abstract_accessor_integration_test.main();
  dart2_accessor_mixin_integration_test.main();
  dart2_component_integration_test.main();
  dart2_constant_required_accessor_integration_test.main();
  dart2_do_not_generate_accessor_integration_test.main();
  dart2_namespaced_accessor_integration_test.main();
  dart2_required_accessor_integration_test.main();
  dart2_stateful_component_integration_test.main();
}
