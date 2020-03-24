import 'package:over_react/over_react.dart';

import '../store.dart';

part 'big_block.over_react.g.dart';

UiFactory<BigBlockProps> BigBlock = _$BigBlock;

class BigBlockProps = UiProps with FluxUiPropsMixin<RandomColorActions, RandomColorStore>;

class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  render() {
    return (Fragment()(
      (Dom.div()..style = {'padding': '50px', 'backgroundColor': props.store.backgroundColor, 'color': 'white'})(
        'This module uses a flux pattern to change its background color.',
        (Dom.button()
          ..onClick = (_) {
            props.actions.changeBackgroundColor();
          }
          ..style = {'padding': '10px', 'margin': '10px'}
        )('Change Background Color'),
      ),
    ));
  }
}
