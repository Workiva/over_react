import 'dart:async';

@TestOn('browser')
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:time/time.dart';
import 'package:todo_client/src/actions.dart';

import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/components/todo_list_item.dart';
import 'package:todo_client/src/models/todo.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('ConnectedTodoListItem', () {
    Ref<TodoAppComponent> appRef;
    TodoListItemComponent component;
    Todo model;

    setUp(() {
      initializeTestStore();
      appRef = createRef();
      mount((ReduxProvider()..store = testStore)(
        (ConnectedTodoApp()..ref = appRef)(),
      ));
      final appComponent = appRef.current;
      model = testStore.state.todos.first;
      component = getComponentByTestId(appComponent, 'todo_client.TodoListItem.${model.id}');
      expect(component, isA<TodoListItemComponent>(), reason: 'test setup sanity check');
    });

    tearDown(() {
      appRef = null;
      component = null;
      model = null;
    });

    bool todoShouldAppearSelected() => testStore.state.selectedTodoIds.contains(model.id);
    bool todoShouldAppearHighlighted() => testStore.state.highlightedTodoIds.contains(model.id);
    bool todoShouldBeEditable() => testStore.state.editableTodoIds.contains(model.id);

    group('renders a TodoListItem', () {
      group('with prop callbacks mapped to the expected Redux action', () {
        group('involving selection:', () {
          Future<Null> selectTodo() async {
            expect(component.props.isSelected, isFalse, reason: 'test setup sanity check');
            component.props.onSelect(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isSelected, isTrue);
          }

          test('props.onSelect => SelectTodoAction', selectTodo);

          test('props.onDeselect => DeselectTodoAction', () async {
            await selectTodo();
            component.redrawCount = 0;

            component.props.onDeselect(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isSelected, isFalse);
          });
        });

        group('involving editability:', () {
          Future<Null> makeTodoEditable() async {
            expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
            component.props.onBeginEdit(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isEditable, isTrue);
          }

          test('props.onBeginEdit => BeginEditTodoAction', makeTodoEditable);

          test('props.onFinishEdit => FinishEditTodoAction', () async {
            await makeTodoEditable();
            component.redrawCount = 0;

            component.props.onFinishEdit(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isEditable, isFalse);
          });
        });

        group('involving model CRUD:', () {
          test('props.onModelUpdate => UpdateTodoAction', () async {
            const newDescription = 'this was not the original description';
            component.props.onModelUpdate(Todo.from(model)..description = newDescription);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.model.description, newDescription);
          });

          test('props.onRemove => RemoveTodoAction', () async {
            final todoRemovedCompleter = Completer<Null>();
            testStore.onChange.listen((newState) {
              todoRemovedCompleter.complete();
            });
            component.props.onRemove(model.id);
            await todoRemovedCompleter.future.timeout(10.milliseconds);
            expect(getByTestId(appRef.current, 'todo_client.TodoListItem.${model.id}'), isNull);
          });
        });
      });

      group('with props.isSelected mapped to AppState.selectedTodoIds', () {
        test('initially', () {
          expect(component.props.isSelected, todoShouldAppearSelected());
        });

        test('when AppState.selectedTodoIds is updated', () async {
          final wasSelected = todoShouldAppearSelected();
          if (!wasSelected) {
            testStore.dispatch(SelectTodoAction(model.id));
          } else {
            testStore.dispatch(DeselectTodoAction(model.id));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasSelected, !todoShouldAppearSelected());
          expect(component.props.isSelected, todoShouldAppearSelected());
        });
      });

      group('with props.isEditable mapped to AppState.editableTodoIds', () {
        test('initially', () {
          expect(component.props.isEditable, todoShouldBeEditable());
        });

        test('when AppState.selectedTodoIds is updated', () async {
          final wasEditable = todoShouldBeEditable();
          if (!wasEditable) {
            testStore.dispatch(BeginEditTodoAction(model.id));
          } else {
            testStore.dispatch(FinishEditTodoAction(model.id));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasEditable, !todoShouldBeEditable());
          expect(component.props.isEditable, todoShouldBeEditable());
        });
      });

      group('with props.isHighlighted mapped to AppState.editableTodoIds', () {
        test('initially', () {
          expect(component.props.isHighlighted, todoShouldAppearHighlighted());
        });

        test('when AppState.selectedTodoIds is updated', () async {
          final wasHighlighted = todoShouldAppearHighlighted();
          if (!wasHighlighted) {
            testStore.dispatch(HighlightTodosAction([model.id]));
          } else {
            testStore.dispatch(UnHighlightTodosAction([model.id]));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasHighlighted, !todoShouldAppearHighlighted());
          expect(component.props.isHighlighted, todoShouldAppearHighlighted());
        });
      });
    });
  });
}
