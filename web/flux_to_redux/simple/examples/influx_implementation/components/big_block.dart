import 'package:over_react/over_react.dart';

import '../store.dart';

part 'big_block.over_react.g.dart';

@Factory()
UiFactory<BigBlockProps> BigBlock = _$BigBlock;

@Props()
class _$BigBlockProps extends FluxUiProps<RandomColorActions, FluxStore> {}

@Component2()
class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  render() {
    return (Fragment()(
      (Dom.div()..style = {'padding': '50px', 'backgroundColor': props.store.backgroundColor, 'color': 'white'})(
        'This module uses a flux pattern to change its background color.',
        (Dom.button()
          ..onClick = (_) {
            props.actions.changeBackgroundColor('blue');
          }
          ..style = {'padding': '10px', 'margin': '10px'}
        )('Change Background Color'),
      ),
    ));
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class BigBlockProps extends _$BigBlockProps with _$BigBlockPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForBigBlockProps;
}
