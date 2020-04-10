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

// ignore_for_file: deprecated_member_use_from_same_package
@TestOn('browser')
@Timeout(Duration(seconds: 2))
library deprecated_error_boundary_test;

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_recoverable.dart';
import 'package:test/test.dart';

import 'shared_error_boundary_tests.dart';

void main() {
  group('RecoverableErrorBoundary (deprecated)', () {
    sharedErrorBoundaryTests(() => RecoverableErrorBoundary());
  });

  group('ErrorBoundary (deprecated)', () {
    sharedErrorBoundaryTests(() => ErrorBoundary(), isWrapper: true);
  });
}
