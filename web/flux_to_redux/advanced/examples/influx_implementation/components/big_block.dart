import 'package:over_react/over_react.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'big_block.over_react.g.dart';

@Factory()
UiFactory<BigBlockProps> BigBlock = _$BigBlock;

@Props()
class _$BigBlockProps extends FluxUiProps<RandomColorActions, RandomColorStore> {
  LowLevelStore lowLevelStore;

  AnotherColorStore secondStore;
}

@Component2()
class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  redrawOn() => [
        props.store,
        props.lowLevelStore,
        props.secondStore,
      ];

  @override
  render() {
    return (Fragment()(
      (Dom.div()
        ..style = {
          'padding': '50px',
          'backgroundColor': props.store.mainBackgroundColor,
          'color': 'white',
          'display': 'flex',
          'alignItems': 'center',
          'justifyContent': 'space-evenly'
        }
      )(
        Dom.div()('This module uses a flux pattern to change its background color.'),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeMainBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockOneBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockTwoBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockThreeBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = this.props.store.blockOneBackgroundColor
            ..colorString = this.props.store.blockOneBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = this.props.lowLevelStore.backgroundColor
            ..colorString = this.props.lowLevelStore.backgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = this.props.secondStore.backgroundColor
            ..colorString = this.props.secondStore.backgroundColor
          )(),
        ),
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
