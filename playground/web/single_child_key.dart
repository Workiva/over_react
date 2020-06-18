import 'package:over_react/over_react.dart';

part 'single_child_key.over_react.g.dart';

UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier

mixin TestProps on UiProps {}

class TestComponent extends UiComponent2<TestProps> {
  @override
  render(){
    final children = [_renderDivs()];
    return (Dom.div()..key='unnecessary')(children);
  }

  _returnListTest() {
    final arbitrary = true;

    if (arbitrary) {
      return [
        (Dom.div()..key='unnecessary')(),
      ];
    } else {
      return [
        (Dom.div()..key='necessary')(),
        (Dom.div()..key='necessary-1')(),
      ];
    }
  }

  _renderDivs() => (Dom.div()..key = 'c-div')(
    (Dom.div()
      ..key = 'c-n-sibbling-1'
    )(
      (Dom.div()
        ..key = 'c-n2-sibbling-1'
      )(
        // ignore: over_react_variadic_children
        [
          (Dom.div()
          ..key = 'unnecessary'
          )('Test'),
        ]
      )
    ),
    (Dom.div()
      ..key = 'c-sibbling-2'
    )(
      // ignore: over_react_variadic_children
        [
          (Dom.div()
            ..key = 'necessary'
          )('Test'),
          (Dom.div()
            ..key = 'necessary_2'
          )('Test'),
        ]
    ),
  );
}

functionDeclarationTest() {
  return (Dom.div()
    ..key = 'top-layer'
  )(
    (Dom.div()
      ..key = 'sibbling-1'
    )(
      (Dom.div()
        ..key = 'n-sibbling-1'
      )(
          //ignore: over_react_variadic_children
          [
            (Dom.div()
              ..key = 'n2-sibbling-1'
            )(
              "Hello",
            )
          ]
      ),
    ),
    (Dom.div()
      ..key = 'sibbling-2'
    )(
        "Child 2"
    ),
  );
}
