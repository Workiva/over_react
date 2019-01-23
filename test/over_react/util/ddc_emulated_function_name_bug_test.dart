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

import 'package:test/test.dart';

import 'package:over_react/src/util/ddc_emulated_function_name_bug.dart';

main() {
  group('ddc_emulated_function_name_bug library:', () {
    group('isBugPresent correctly detects whether the bug is present', () {
      test('in dart2js', () {
        expect(isBugPresent, isFalse);
      }, testOn: 'js');

      test('in content_shell/Dartium', () {
        expect(isBugPresent, isFalse);
      }, testOn: 'dart-vm');

      test('in the DDC', () {
        expect(isBugPresent, isTrue,
            reason: 'if this test fails, then it\'s possible that the bug was fixed in'
                    ' a newer version of the Dart SDK, and this library can be eliminated!'
        );
      }, tags: 'ddc',
          // Tests run in `ddev coverage` don't respect tags and show up as the 'vm' platform
          // so we can use this to disable certain browser tests during coverage.
          // Workaround for https://github.com/Workiva/dart_dev/issues/200
          testOn: '!vm');
    });

    test('patchName fixes instances of a class with the issue in the DDC', () {
      const testValue = 'test value';

      var testObject = new ProblematicClass();

      try {
        testObject.name = testValue;
      } catch(_) {}
      expect(testObject.name, isNot(testValue), reason: 'sanity check that the bug is present');

      patchName(testObject);

      expect(() => testObject.name = testValue, returnsNormally);
      expect(testObject.name, testValue);
    }, tags: 'ddc',
        // Tests run in `ddev coverage` don't respect tags and show up as the 'vm' platform
        // so we can use this to disable certain browser tests during coverage.
        // Workaround for https://github.com/Workiva/dart_dev/issues/200
        testOn: '!vm');
  });
}

class ProblematicClass implements Function {
  void call();

  @override
  noSuchMethod(i) {}

  String _name;

  // ignore: unnecessary_getters_setters
  String get name => _name;
  // ignore: unnecessary_getters_setters
  set name(String value) => _name = value;
}
