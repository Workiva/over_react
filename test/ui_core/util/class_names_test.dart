library class_names_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

/// Main entrypoint for class_names testing
main() {
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
        });
      });

      group('created with .fromProps() constructor', () {
        test('initializes by adding from the "className" prop', () {
          const addedClass = 'class';
          const Map props = const {
            CssClassProps.Z_$KEY__CLASS_NAME: addedClass
          };

          ClassNameBuilder builder = new ClassNameBuilder.fromProps(props);

          expect(builder.toClassName(), equals(addedClass));
        });

        test('initializes by blacklisting from the "classNameBlacklist" prop', () {
          const blacklistedClass = 'class';
          const Map props = const {
            CssClassProps.Z_$KEY__CLASS_NAME_BLACKLIST: blacklistedClass
          };

          ClassNameBuilder builder = new ClassNameBuilder.fromProps(props);
          builder.add(blacklistedClass);

          expect(builder.toClassName(), isEmpty);
        });
      });
    });

    group('splitClassName() splits a className string properly', () {
      test('when the input is a single class', () {
        expect(splitClassName('class1'), equals(['class1']));
      });

      test('when the input is a multiple classes', () {
        expect(splitClassName('class1 class2'), equals(['class1', 'class2']));
        expect(splitClassName('class1 class2 class3'), equals(['class1', 'class2', 'class3']));
        expect(splitClassName('class1 class2 class3 class4'), equals(['class1', 'class2', 'class3', 'class4']));
      });

      test('when there is extra padding to the left', () {
        expect(splitClassName(' class1 class2'), equals(['class1', 'class2']));
        expect(splitClassName('  class1 class2'), equals(['class1', 'class2']));
        expect(splitClassName('   class1 class2'), equals(['class1', 'class2']));
      });

      test('when there is extra padding to the right', () {
        expect(splitClassName('class1 class2 '), equals(['class1', 'class2']));
        expect(splitClassName('class1 class2  '), equals(['class1', 'class2']));
        expect(splitClassName('class1 class2   '), equals(['class1', 'class2']));
      });

      test('when there is extra padding between classes', () {
        expect(splitClassName('class1 class2'), equals(['class1', 'class2']));
        expect(splitClassName('class1  class2'), equals(['class1', 'class2']));
        expect(splitClassName('class1   class2'), equals(['class1', 'class2']));
      });

      test('when the input is an empty string', () {
        expect(splitClassName(''), equals([]));
      });

      test('when the input is only spaces', () {
        expect(splitClassName(' '), equals([]));
        expect(splitClassName('  '), equals([]));
        expect(splitClassName('   '), equals([]));
      });
    });
  });
}
