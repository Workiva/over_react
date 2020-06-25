import 'package:over_react/over_react.dart';

duplicatePropCascade() {
  (Dom.div()
    ..id = '1'
    ..dom.id = 'foo' // Should lint as dupe of `id`
    ..id = '2'
    ..hidden = false
    ..aria.hidden = false // Should not lint as dupe of `hidden`
    ..onClick = (_) {
      final bar = 'baz';
      return false;
    }
    ..dom.onClick = (_) {
      final biz = 'foo';
      return false;
    }
    ..onClick = (_) {
      final foo = 'bar';
      return false;
    }
  )('foo');
}

duplicatePropCascadeWithMoreThanOneDupe() {
  (Dom.div()
    ..id = '1'
    ..id = '2'
    ..id = '3'
    ..id = '4'
    ..title = 'biz'
    ..title = 'baz'
    ..id = 'winner'
    ..title = 'winner'
    ..aria.label = 'chicken dinner'
  )('foo');
}
