@TestOn('browser')
import 'package:test/test.dart';

import 'package:todo_client/src/models/user.dart';

main() {
  group('User', () {
    group('is constructed as expected using the default constructor', () {
      test('when there are no arguments', () {
        final model = User();
        expect(model.id, hasLength(36), reason: 'A Uuid().v4() should be used when id is not specified');
        expect(model.name, '?');
        expect(model.bio, isEmpty);
      });

      test('when id is specified', () {
        final model = User(id: 'some-unique-id');
        expect(model.id, 'some-unique-id');
      });

      test('when name is specified', () {
        final model = User(name: 'Joe');
        expect(model.name, 'Joe');
      });

      test('when bio is specified', () {
        final model = User(bio: 'Something really interesting');
        expect(model.bio, 'Something really interesting');
      });
    });

    test('is constructed as expected using the fromJson() factory constructor', () {
      final model = User.fromJson({'id': 'some-unique-id', 'name': 'Joe', 'bio': 'Something really interesting'});
      expect(model.name, 'Joe');
      expect(model.id, 'some-unique-id');
      expect(model.bio, 'Something really interesting');
    });

    test('has a toJson() method that returns the expected value', () {
      final model = User();
      expect(model.toJson(), {'id': model.id, 'name': model.name, 'bio': model.bio});
    });
  });
}
