@TestOn('browser')
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/shared/empty_view.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('DisplayList', () {
    TestJacket<DisplayListComponent> jacket;

    tearDown(() {
      jacket = null;
    });

    test('renders an EmptyView when props.children is empty', () {
      jacket = mount((DisplayList()..listItemTypeDescription = 'Foo')());

      final emptyListInstance = getByTestId(jacket.getInstance(), 'todo_client.DisplayList.EmptyView');
      expect(emptyListInstance, isNotNull);
      expect(getDartComponent(emptyListInstance), isA<EmptyViewComponent>());

      EmptyViewProps emptyViewProps = getDartComponent(emptyListInstance).props;
      expect(emptyViewProps.type, EmptyViewType.VBLOCK);
      expect(emptyViewProps.header, 'No ${jacket.getDartInstance().props.listItemTypeDescription} to show');
      expect(emptyViewProps.glyph, isNotNull);
      expect(emptyViewProps.children, ['You should totally create one!']);
    });

    test('renders a scrolling Box containing children when props.children is not empty', () {
      jacket = mount((DisplayList()..listItemTypeDescription = 'Foo')('not empty!'));

      final emptyListInstance = getByTestId(jacket.getInstance(), 'todo_client.DisplayList.EmptyView');
      expect(emptyListInstance, isNull);

      Element box = jacket.getDartInstance().scrollingBoxRef.current;
      expect(box.style.overflowY, 'auto');
      expect(box.text, 'not empty!');
    });
  });
}
