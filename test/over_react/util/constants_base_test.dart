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

@TestOn('browser')
library constants_base_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for DomUtil testing
main() {
  setClientConfiguration();
  enableTestMode();

  group('DebugFriendlyConstant has the correct', () {
    test('toString implementation', () {
      var debugConst = const DebugConstantTest('Name');

      expect(debugConst.debugDescription, 'Debug Description');
      expect(debugConst.toString(), '${debugConst.runtimeType}.Name (Debug Description)');
    });

    test('debugDescription implementation', () {
      var classNameConst = const ClassNameConstantTest('Name', 'ClassName');

      expect(classNameConst.debugDescription, 'className: ClassName');
      expect(classNameConst.toString(), '${classNameConst.runtimeType}.Name (className: ClassName)');
    });
  });
}

class DebugConstantTest extends DebugFriendlyConstant {
  const DebugConstantTest(String name) : super(name);

  @override
  String get debugDescription => 'Debug Description';
}

class ClassNameConstantTest extends ClassNameConstant {
  const ClassNameConstantTest(String name, String className) : super(name, className);
}
