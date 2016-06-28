library prop_error_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Main entrypoint for PropError testing
main() {
  group('PropError\'s', () {
    test('default constructor throws a PropError with correct message', () {
      expect(() => throw new PropError('Prop Name', 'Custom Message'), throwsPropError('Prop Name', 'Custom Message'));
    });

    test('`required` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.requried('Prop Name', 'Custom Message'),
          throwsPropError_Required('Prop Name', 'Custom Message')
      );
    });

    test('`value` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.value('Invalid Value', 'Prop Name', 'Custom Message'),
          throwsPropError_Value('Invalid Value', 'Prop Name', 'Custom Message')
      );
    });

    test('`combination` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.combination('Prop Name', 'Prop 2 Name', 'Custom Message'),
          throwsPropError_Combination('Prop Name', 'Prop 2 Name', 'Custom Message')
      );
    });
  });
}
