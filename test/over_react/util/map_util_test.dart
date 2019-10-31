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

library map_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entrypoint for map_util testing
main() {
  group('map_util part', () {
    group('getPropsToForward() returns a copy of the specified props', () {
      group('with React props', () {
        test('omitted out by default', () {
          var actual = getPropsToForward({
            'key': 'my key',
            'ref': 'my ref',
            'other prop': 'my other prop'
          });

          var expected = {'other prop': 'my other prop'};

          expect(actual, equals(expected));
        });

        test('not omitted when specified', () {
          var actual = getPropsToForward(
              {'key': 'my key', 'ref': 'my ref', 'other prop': 'my other prop'},
              omitReactProps: false);

          var expected = {
            'key': 'my key',
            'ref': 'my ref',
            'other prop': 'my other prop'
          };

          expect(actual, equals(expected));
        });
      });

      test('with the specified keys omitted', () {
        var actual = getPropsToForward({
          'prop 1': 'my prop #1',
          'prop 2': 'my prop #2',
          'prop 3': 'my prop #3',
          'prop 4': 'my prop #4',
        }, keysToOmit: [
          'prop 2',
          'prop 4'
        ]);

        var expected = {
          'prop 1': 'my prop #1',
          'prop 3': 'my prop #3',
        };

        expect(actual, equals(expected));
      });

      test('with the specified sets of keys omitted', () {
        var actual = getPropsToForward({
          'prop 1': 'my prop #1',
          'prop 2': 'my prop #2',
          'prop 3': 'my prop #3',
          'prop 4': 'my prop #4',
          'prop 5': 'my prop #5',
          'prop 6': 'my prop #6',
        }, keySetsToOmit: [
          ['prop 1', 'prop 3'],
          ['prop 4', 'prop 5'],
        ]);

        var expected = {
          'prop 2': 'my prop #2',
          'prop 6': 'my prop #6',
        };

        expect(actual, equals(expected));
      });

      test('with only valid DOM/SVG props', () {
        var actual = getPropsToForward({
          'tabIndex': '0',
          'className': 'my classname',
          'cx': '0',
          'stroke': 'red',
          'data-test-prop': 'my data attr',
          'aria-test-prop': 'my aria attr',
          'classNameBlacklist': 'my classname blacklist',
          'custom prop': 'my custom prop',
        }, onlyCopyDomProps: true);

        var expected = {
          'tabIndex': '0',
          'className': 'my classname',
          'cx': '0',
          'stroke': 'red',
          'data-test-prop': 'my data attr',
          'aria-test-prop': 'my aria attr',
        };

        expect(actual, equals(expected));
      });
    });

    group('newStyleFromProps() returns', () {
      test('a copy of the style map found in the specified props', () {
        var styles = {'color': 'red', 'width': '10rem'};
        var props = domProps()..style = styles;

        expect(newStyleFromProps(props), equals(styles));
      });

      test('an empty map when the specified props are null', () {
        expect(newStyleFromProps(null), equals({}));
      });

      test('an empty map when the specified props have a null style map', () {
        expect(newStyleFromProps(domProps()), equals({}));
      });
    });
  });
}
