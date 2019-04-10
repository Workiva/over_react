import 'package:over_react/over_react.dart';

singleChildKey() {
  (Dom.div()
    ..key = '1'
    ..id = '2'
    ..onClick = (_) {
      final bar = 'baz';
      return false;
    }
  )('foo');
}
