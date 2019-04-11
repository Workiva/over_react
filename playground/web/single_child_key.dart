import 'package:over_react/over_react.dart';

singleChildKey() {
  (Dom.div()
    ..key = 'top-layer'
    ..id = '2'
    ..onClick = (_) {
      final bar = 'baz';
      return false;
    }
  )(
    (Dom.div()
      ..key = 'sibbling-1'
      ..id = '2'
      ..onClick = (_) {
        final bar = 'baz';
        return false;
      }
    )(
      (Dom.div()
        ..key = 'n-sibbling-1'
        ..id = '2'
        ..onClick = (_) {
          final bar = 'baz';
          return false;
        }
      )(
          "Child of child 1"
      ),
    ),
    (Dom.div()
      ..key = 'sibbling-2'
      ..id = '2'
      ..onClick = (_) {
        final bar = 'baz';
        return false;
      }
    )(
        "Child 2"
    ),
  );
}
