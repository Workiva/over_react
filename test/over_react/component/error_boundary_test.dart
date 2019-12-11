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

@TestOn('browser')
@Timeout(Duration(seconds: 2))
library error_boundary_test;

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/error_boundary_recoverable.dart';
import 'package:test/test.dart';

import 'shared_error_boundary_tests.dart';

void main() {
  // group('RecoverableErrorBoundary', () {
  //   sharedErrorBoundaryTests(() => RecoverableErrorBoundary());
  // });

  group('ErrorBoundary', () {
    sharedErrorBoundaryTests(() => ErrorBoundary(), isWrapper: true);
  });
}
