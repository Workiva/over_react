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
          [
            (Dom.div()
              ..key = 'n2-sibbling-1'
              ..id = '2'
              ..onClick = (_) {
                final bar = 'baz';
                return false;
              }
            )(
              "Hello",
            )
          ]
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

@Props()
class TestComponentProps extends UiProps {

}

@Component()
class TestComponent extends UiComponent<TestComponentProps> {

  @override
  render(){
    final children = [ _renderDivs()];
    return Dom.div()(children);
  }

  _renderDivs() => (Dom.div()..key = 'button')(
    (Dom.div()
      ..key = 'n-sibbling-1'
      ..id = '2'
      ..onClick = (_) {
        final bar = 'baz';
        return false;
      }
    )(
      [
        (Dom.div()
          ..key = 'n2-sibbling-1'
          ..id = '2'
          ..onClick = (_) {
            final bar = 'baz';
            return false;
          }
        )(
          "Hello",
        )
      ]
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

