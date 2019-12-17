import 'package:over_react/over_react.dart';

import '../../../stores.dart';
import '../../../components/color_block.dart';

part 'random_color.over_react.g.dart';

@Factory()
UiFactory<RandomColorProps> RandomColor = _$RandomColor;

@Props()
class _$RandomColorProps extends FluxUiProps<RandomColorActions, InTransitionTopLevelStore> {
  InTransitionLowLevelStore lowLevelStore;

  InTransitionSecondStore secondStore;
}

@Component2()
class RandomColorComponent extends FluxUiComponent2<RandomColorProps> {
  @override
  redrawOn() => [
        props.store,
        props.lowLevelStore,
        props.secondStore,
      ];

  @override
  render() {
    return (Fragment()((Dom.div()
          ..style = {
            'padding': '50px',
            'backgroundColor': props.store.mainBackgroundColor,
            'color': 'white',
            'display': 'flex',
            'alignItems': 'center',
            'justifyContent': 'space-evenly'
          })(
        (Dom.div()..key = 'c1')('This module uses a flux pattern to change its background color.'),
        (Dom.div()
              ..style = {
                'display': 'flex',
                'flexDirection': 'column',
              }
              ..key = 'c2')(
            (Dom.button()
              ..onClick = (_) {
                props.actions.changeMainBackgroundColor();
              }
              ..style = {'padding': '10px', 'margin': '10px'}
              ..key = 'btn1')('Change Main Background Color'),
            (Dom.button()
              ..onClick = (_) {
                props.actions.changeBlockOneBackgroundColor();
              }
              ..style = {'padding': '10px', 'margin': '10px'}
              ..key = 'btn2')('Change Block 1 Background Color'),
            (Dom.button()
              ..onClick = (_) {
                props.actions.changeBlockTwoBackgroundColor();
              }
              ..style = {'padding': '10px', 'margin': '10px'}
              ..key = 'btn3')('Change Block 2 Background Color'),
            (Dom.button()
              ..onClick = (_) {
                props.actions.changeBlockThreeBackgroundColor();
              }
              ..style = {'padding': '10px', 'margin': '10px'}
              ..key = 'btn4')('Change Block 3 Background Color')),
        (Dom.div()
          ..style = {'display': 'flex', 'flexDirection': 'column'}
          ..key = 'c3')(
          (ColorBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = this.props.store.blockOneBackgroundColor
            ..colorString = this.props.store.blockOneBackgroundColor
            ..key = 'b1')(),
          (ColorBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = this.props.lowLevelStore.backgroundColor
            ..colorString = this.props.lowLevelStore.backgroundColor
            ..key = 'b2')(),
          (ColorBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = this.props.secondStore.backgroundColor
            ..colorString = this.props.secondStore.backgroundColor
            ..key = 'b3')(),
        ))));
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class RandomColorProps extends _$RandomColorProps with _$RandomColorPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForRandomColorProps;
}
