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
library class_names_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entrypoint for class_names testing
main() {
  setClientConfiguration();
  enableTestMode();

  group('class_names part', () {
    group('ClassNameBuilder', () {
      group('created with default constructor', () {
        ClassNameBuilder builder;

        setUp(() {
          builder = new ClassNameBuilder();
        });

        test('returns an empty className when nothing is added', () {
          expect(builder.toClassName(), isEmpty);
        });

        test('returns null from classNameBlacklist when nothing is blacklisted', () {
          expect(builder.toClassNameBlacklist(), isNull);
        });

        test('returns a className with the added single classes', () {
          builder
            ..add('class1')
            ..add('class2')
            ..add('class3');

          expect(builder.toClassName(), equals('class1 class2 class3'));
        });

        test('returns a className with the added classNames', () {
          builder
            ..add('classname1-class1 classname1-class2')
            ..add('classname2-class1 classname2-class2')
            ..add('classname3-single-class');

          expect(builder.toClassName(), equals([
            'classname1-class1 classname1-class2',
            'classname2-class1 classname2-class2',
            'classname3-single-class'
          ].join(' ')));
        });

        test('returns a classNameBlacklist with the blacklisted single classes', () {
          builder
            ..blacklist('class1')
            ..blacklist('class2')
            ..blacklist('class3');

          expect(builder.toClassNameBlacklist(), equals('class1 class2 class3'));
        });

        test('returns a classNameBlacklist with the blacklisted classes', () {
          builder
            ..blacklist('classname1-class1 classname1-class2')
            ..blacklist('classname2-class1 classname2-class2')
            ..blacklist('classname3-single-class');

          expect(builder.toClassNameBlacklist(), equals(
            'classname1-class1 classname1-class2 '
            'classname2-class1 classname2-class2 '
            'classname3-single-class'
          ));
        });

        test('doesn\'t trim spaces on inputs', () {
          builder
            ..add('   classname1-class1 classname1-class2    ')
            ..add(' classname2-single-class ')
            ..add('  ');

          expect(builder.toClassName(), equals([
            '   classname1-class1 classname1-class2    ',
            ' classname2-single-class ',
            '  '
          ].join(' ')));
        });

        test('blacklists classes', () {
          const String
            classToKeep1 = 'class-to-keep-1',
            classToKeep2 = 'class-to-keep-2',
            classToKeep3 = 'class-to-keep-3',
            classToKeep4 = 'class-to-keep-4';

          const String
            classToOmit1 = 'class-to-omit-1',
            classToOmit2 = 'class-to-omit-2',
            classToOmit3 = 'class-to-omit-3',
            classToOmitNeverAdded = 'class-to-omit-never-added';

          builder
            ..add('   $classToKeep1 $classToOmit1    ')
            ..add(classToKeep2)
            ..add(classToOmit2)
            ..add(' $classToOmit3  $classToKeep3')
            ..add(classToKeep4);

          builder
            ..blacklist(' $classToOmit3  ')
            ..blacklist(classToOmit1)
            ..blacklist(classToOmitNeverAdded)
            ..blacklist('$classToOmit2  ');

          expect(builder.toClassName(), equals([
            classToKeep1,
            classToKeep2,
            classToKeep3,
            classToKeep4
          ].join(' ')));
        });

        test('returns an empty className when only a blacklist is added', () {
          builder.blacklist('class');
          expect(builder.toClassName(), isEmpty);
        });

        test('does nothing when null is blacklisted', () {
          builder.blacklist(null);
          builder
            ..add('class1')
            ..add('null');
          expect(builder.toClassName(), equals('class1 null'));
          expect(builder.toClassNameBlacklist(), isNull);
        });

        test('does nothing when the empty string is blacklisted', () {
          builder.blacklist('');
          builder.add('class1');
          expect(builder.toClassName(), equals('class1'));
          expect(builder.toClassNameBlacklist(), isNull);
        });

        test('only adds classes if the [should] argument is true or unspecified', () {
          builder
            ..add('class1')
            ..add('class2', true)
            ..add('class3', false);
          expect(builder.toClassName(), equals('class1 class2'));
        });

        test('only adds blacklists if the [should] argument is true or unspecified', () {
          builder
            ..blacklist('class1')
            ..blacklist('class2', true)
            ..blacklist('class3', false);

          builder.add('class1 class2 class3');

          expect(builder.toClassName(), equals('class3'));
          expect(builder.toClassNameBlacklist(), equals('class1 class2'));
        });

        test('does not add classes when className is null', () {
          builder
            ..add('class1')
            ..add(null);
          expect(builder.toClassName(), equals('class1'));
        });

        test('does not add classes when className is an empty string', () {
          builder
            ..add('class1')
            ..add('');
          expect(builder.toClassName(), equals('class1'));
        });

        group('addFromProps()', () {
          test('adds to the className from the "className" prop in the specified Map', () {
            const addedClass = 'class';
            const Map props = const {
              'className': addedClass
            };

            ClassNameBuilder builder = new ClassNameBuilder()
              ..addFromProps(props);

            expect(builder.toClassName(), equals(addedClass));
          });

          test('adds to the blacklist from the "classNameBlacklist" prop in the specified Map', () {
            const blacklistedClass = 'class';
            const Map props = const {
              'classNameBlacklist': blacklistedClass
            };

            ClassNameBuilder builder = new ClassNameBuilder()
              ..addFromProps(props);
            builder.add(blacklistedClass);

            expect(builder.toClassName(), isEmpty);
          });

          test('accepts null input', () {
            expect(() {
              new ClassNameBuilder()
                ..addFromProps(null);
            }, returnsNormally);
          });
        });

        group('toProps() returns a Map with the builder\'s className and blacklist', () {
          test('', () {
            ClassNameBuilder builder = new ClassNameBuilder()
              ..add('class1')
              ..add('class2')
              ..blacklist('blacklist1')
              ..blacklist('blacklist2');

            expect(builder.toProps(), equals({
              'className': 'class1 class2',
              'classNameBlacklist': 'blacklist1 blacklist2',
            }));
          });

          test('when empty', () {
            ClassNameBuilder builder = new ClassNameBuilder();

            expect(builder.toProps(), equals({
              'className': '',
              'classNameBlacklist': null,
            }));
          });
        });

        group('merge', () {
          test('merges the className from the provided builder instance', () {
            var otherBuilder = new ClassNameBuilder();

            builder.add('a');
            otherBuilder.add('b');
  
            builder.merge(otherBuilder);
            expect(builder.toClassName(), equals('a b'));
          });

          test('returns blacklist merged from second builder instance', () {
            var otherBuilder = new ClassNameBuilder();

            builder.blacklist('a-blacklist');
            otherBuilder.blacklist('b-blacklist');
            
            builder.merge(otherBuilder);
            expect(builder.toClassNameBlacklist(), equals('a-blacklist b-blacklist'));
          });

          test('returns classname and blacklist merged from second builder instance', () {
            var otherBuilder = new ClassNameBuilder();

            builder.add('a');
            otherBuilder.blacklist('b-blacklist');
            
            builder.merge(otherBuilder);
            expect(builder.toClassName(), equals('a'));
            expect(builder.toClassNameBlacklist(), equals('b-blacklist'));
          });
        }); 
      });
      
      group('created with .merged() constructor', () {
        test('', () {
          var a = new ClassNameBuilder()
            ..add('a')
            ..blacklist('a-blacklist');
          var b = new ClassNameBuilder()
            ..add('b')
            ..blacklist('b-blacklist');
          var builder = new ClassNameBuilder.merged(a,b);
          expect(builder.toClassName(), equals('a b'));
          expect(builder.toClassNameBlacklist(), equals('a-blacklist b-blacklist'));
        });
      });

      group('created with .fromProps() constructor', () {
        test('initializes by adding from the "className" prop', () {
          const addedClass = 'class';
          const Map props = const {
            'className': addedClass
          };

          ClassNameBuilder builder = new ClassNameBuilder.fromProps(props);

          expect(builder.toClassName(), equals(addedClass));
        });

        test('initializes by blacklisting from the "classNameBlacklist" prop', () {
          const blacklistedClass = 'class';
          const Map props = const {
            'classNameBlacklist': blacklistedClass
          };

          ClassNameBuilder builder = new ClassNameBuilder.fromProps(props);
          builder.add(blacklistedClass);

          expect(builder.toClassName(), isEmpty);
        });

        test('accepts null input', () {
          expect(() {
            new ClassNameBuilder.fromProps(null);
          }, returnsNormally);
        });
      });
    });

    group('splitSpaceDelimitedString() splits a className string properly', () {
      test('when the input is a single class', () {
        expect(splitSpaceDelimitedString('class1'), equals(['class1']));
      });

      test('when the input is a multiple classes', () {
        expect(splitSpaceDelimitedString('class1 class2'), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('class1 class2 class3'), equals(['class1', 'class2', 'class3']));
        expect(splitSpaceDelimitedString('class1 class2 class3 class4'), equals(['class1', 'class2', 'class3', 'class4']));
      });

      test('when there is extra padding to the left', () {
        expect(splitSpaceDelimitedString(' class1 class2'), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('  class1 class2'), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('   class1 class2'), equals(['class1', 'class2']));
      });

      test('when there is extra padding to the right', () {
        expect(splitSpaceDelimitedString('class1 class2 '), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('class1 class2  '), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('class1 class2   '), equals(['class1', 'class2']));
      });

      test('when there is extra padding between classes', () {
        expect(splitSpaceDelimitedString('class1 class2'), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('class1  class2'), equals(['class1', 'class2']));
        expect(splitSpaceDelimitedString('class1   class2'), equals(['class1', 'class2']));
      });

      test('when the input is an empty string', () {
        expect(splitSpaceDelimitedString(''), equals([]));
      });

      test('when the input is only spaces', () {
        expect(splitSpaceDelimitedString(' '), equals([]));
        expect(splitSpaceDelimitedString('  '), equals([]));
        expect(splitSpaceDelimitedString('   '), equals([]));
      });
    });
  });
}
