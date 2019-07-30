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
import 'over_react/component_declaration/redux_component_test.dart' as redux_component_test;

import 'over_react/component_declaration/flux_component_test/flux_component_test.dart' as flux_component_test;
import 'over_react/component_declaration/flux_component_test/component2/flux_component_test.dart' as component2_flux_component_test;

import 'over_react/component_declaration/builder_helpers_test.dart' as builder_helpers_test;
import 'over_react/component_declaration/builder_integration_tests/abstract_accessor_integration_test.dart' as abstract_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/accessor_mixin_integration_test.dart' as accessor_mixin_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component_integration_test.dart' as component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/constant_required_accessor_integration_test.dart' as constant_required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/do_not_generate_accessor_integration_test.dart' as do_not_generate_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/namespaced_accessor_integration_test.dart' as namespaced_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/private_props_ddc_bug.dart' as private_props_ddc_bug;
import 'over_react/component_declaration/builder_integration_tests/required_accessor_integration_test.dart' as required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/stateful_component_integration_test.dart' as stateful_component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/unassigned_prop_integration_test.dart' as unassigned_prop_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/abstract_accessor_integration_test.dart' as backwards_compat_abstract_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/accessor_mixin_integration_test.dart' as backwards_compat_accessor_mixin_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/component_integration_test.dart' as backwards_compat_component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/constant_required_accessor_integration_test.dart' as backwards_compat_constant_required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/do_not_generate_accessor_integration_test.dart' as backwards_compat_do_not_generate_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/namespaced_accessor_integration_test.dart' as backwards_compat_namespaced_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/private_props_ddc_bug.dart' as backwards_compat_private_props_ddc_bug;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/required_accessor_integration_test.dart' as backwards_compat_required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/stateful_component_integration_test.dart' as backwards_compat_stateful_component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/backwards_compatible/unassigned_prop_integration_test.dart' as backwards_compat_unassigned_prop_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/abstract_accessor_integration_test.dart' as component2_abstract_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/accessor_mixin_integration_test.dart' as component2_accessor_mixin_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/annotation_error_integration_test.dart' as annotation_error_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/component_integration_test.dart' as component2_component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/constant_required_accessor_integration_test.dart' as component2_constant_required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/do_not_generate_accessor_integration_test.dart' as component2_do_not_generate_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/namespaced_accessor_integration_test.dart' as component2_namespaced_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/private_props_ddc_bug.dart' as component2_private_props_ddc_bug;
import 'over_react/component_declaration/builder_integration_tests/component2/required_accessor_integration_test.dart' as component2_required_accessor_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/stateful_component_integration_test.dart' as component2_stateful_component_integration_test;
import 'over_react/component_declaration/builder_integration_tests/component2/unassigned_prop_integration_test.dart' as component2_unassigned_prop_integration_test;

main() {
  setClientConfiguration();

  enableTestMode();

  component_base_test.main();
  component_type_checking_test.main();
  redux_component_test.main();

  flux_component_test.main();
  component2_flux_component_test.main();


  builder_helpers_test.main();

  abstract_accessor_integration_test.main();
  accessor_mixin_integration_test.main();
  component_integration_test.main();
  constant_required_accessor_integration_test.main();
  do_not_generate_accessor_integration_test.main();
  namespaced_accessor_integration_test.main();
  private_props_ddc_bug.main();
  required_accessor_integration_test.main();
  stateful_component_integration_test.main();
  unassigned_prop_integration_test.main();

  backwards_compat_abstract_accessor_integration_test.main();
  backwards_compat_accessor_mixin_integration_test.main();
  backwards_compat_do_not_generate_accessor_integration_test.main();
  backwards_compat_component_integration_test.main();
  backwards_compat_constant_required_accessor_integration_test.main();
  backwards_compat_private_props_ddc_bug.main();
  backwards_compat_namespaced_accessor_integration_test.main();
  backwards_compat_required_accessor_integration_test.main();
  backwards_compat_stateful_component_integration_test.main();
  backwards_compat_unassigned_prop_integration_test.main();

  component2_abstract_accessor_integration_test.main();
  component2_accessor_mixin_integration_test.main();
  annotation_error_integration_test.main();
  component2_do_not_generate_accessor_integration_test.main();
  component2_component_integration_test.main();
  component2_constant_required_accessor_integration_test.main();
  component2_private_props_ddc_bug.main();
  component2_namespaced_accessor_integration_test.main();
  component2_required_accessor_integration_test.main();
  component2_stateful_component_integration_test.main();
  component2_unassigned_prop_integration_test.main();
}
