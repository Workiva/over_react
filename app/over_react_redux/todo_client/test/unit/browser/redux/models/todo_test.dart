@TestOn('browser')
import 'package:test/test.dart';

import 'package:todo_client/src/models/todo.dart';

main() {
  group('Todo', () {
    group('is constructed as expected using the default constructor', () {
      test('when there are no arguments', () {
        final model = Todo();
        expect(model.id, hasLength(36), reason: 'A Uuid().v4() should be used when id is not specified');
        expect(model.description, isEmpty);
        expect(model.notes, isEmpty);
        expect(model.assignedUserId, isEmpty);
        expect(model.isCompleted, isFalse);
        expect(model.isPublic, isFalse);
      });

      test('when id is specified', () {
        final model = Todo(id: 'some-unique-id');
        expect(model.id, 'some-unique-id');
      });

      test('when description is specified', () {
        final model = Todo(description: 'Do this');
        expect(model.description, 'Do this');
      });

      test('when notes is specified', () {
        final model = Todo(notes: 'Something about this');
        expect(model.notes, 'Something about this');
      });

      test('when assignedUserId is specified', () {
        final model = Todo(assignedUserId: 'some-user-id');
        expect(model.assignedUserId, 'some-user-id');
      });

      test('when isCompleted is true', () {
        final model = Todo(isCompleted: true);
        expect(model.isCompleted, isTrue);
      });

      test('when isPublic is true', () {
        final model = Todo(isPublic: true);
        expect(model.isPublic, isTrue);
      });

    });

    test('is constructed as expected using the fromJson() factory constructor', () {
      final model = Todo.fromJson({
        'id': 'some-unique-id',
        'description': 'Do this',
        'notes': 'Something about this',
        'assignedUserId': 'some-user-id',
        'isCompleted': true,
        'isPublic': true,
      });
      expect(model.id, 'some-unique-id');
      expect(model.description, 'Do this');
      expect(model.notes, 'Something about this');
      expect(model.assignedUserId, 'some-user-id');
      expect(model.isCompleted, isTrue);
      expect(model.isPublic, isTrue);
    });

    test('has a toJson() method that returns the expected value', () {
      final model = Todo();
      expect(model.toJson(), {
        'id': model.id,
        'description': model.description,
        'notes': model.notes,
        'assignedUserId': model.assignedUserId,
        'isCompleted': model.isCompleted,
        'isPublic': model.isPublic,
      });
    });
  });
}
