import 'package:over_react/over_react.dart';

part 'single_child_key.over_react.g.dart';

UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier

mixin TestProps on UiProps {}

class TestComponent extends UiComponent2<TestProps> {
  @override
  render(){
    final children = [_renderDivs(), _renderDivs()];
    return (Dom.div()..key = 'constant' + 'expression')(children);
  }

  _returnListTest() {
    final arbitrary = true;

    if (arbitrary) {
      return [
        (Dom.div()..key='unknown')(),
      ];
    } else {
      return [
        (Dom.div()..key='definitely-necessary')(),
        (Dom.div()..key='definitely-necessary-1')(),
      ];
    }
  }

  _keyGenerator() => 'a_key';

  _renderDivs() => (Dom.div()..key = 'unknown')(
    (Dom.div()
      ..key = 'unnecessary'
    )(
      (Dom.div()
        ..key = _keyGenerator()
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
      ..key = 'unnecessary-1'
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
    ..key = 'unknown'
  )(
    (Dom.div()
      ..key = 'unnecessary'
    )(
      (Dom.div()
        ..key = 'unnecessary'
      )(
          //ignore: over_react_variadic_children
          [
            (Dom.div()
              ..key = 'unnecessary'
            )(
              "Hello",
            )
          ]
      ),
    ),
    (Dom.div()
      ..key = 'unnecessary-1'
    )(
        "Child 2"
    ),
  );
}
