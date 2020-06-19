import 'package:over_react/over_react.dart';

styleMissingUnit() {
  (Dom.div()..style = {
    'width': '1',
    'height': '1.2',
    // no warning because valid unit
    'top': '1px',
    'left': '1rem',
    // no warning because blacklisted property
    'opacity': '1',
    // no warning because custom property
    '--custom-property': '1',
  })();

  // handles nested maps
  (Dom.div()..style = newStyleFromProps({
    'width': '1',
  }))();

//  const one = '1';

  // Non-SimpleStringLiteral cases detected (but don't have assists)
  (Dom.div()..style = {
    // constant value  // todo uncomment once ConstantEvaluator supports fields
    //'width': one,
    'height': '1' '2',
    'top': '${1}',
    'left': 1,
  })();
}
