import 'package:over_react/over_react.dart';

duplicatePropCascade() {
  (Dom.div()
    ..id = '1'
    ..id = '2'
    ..onClick = (_) {
      final bar = 'baz';
      return false;
    }
    ..onClick = (_) {
      final foo = 'bar';
      return false;
    }
  )('foo');
}
