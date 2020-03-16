// Copyright 2019 Workiva Inc.
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

@Timeout(Duration(seconds: 2))
library deprecated_error_boundary_mixin_test;

import 'package:test/test.dart';

import 'fixtures/custom_error_boundary_component.dart';
import 'shared_error_boundary_tests.dart';

void main() {
  group('ErrorBoundaryMixin (deprecated)', () {
    sharedErrorBoundaryTests(() => CustomErrorBoundary());
  });
}
