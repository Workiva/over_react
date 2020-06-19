import 'package:over_react/over_react.dart';

part 'iterator_key.over_react.g.dart';

ReactElement MissingKeyInList() {
  return (
      Dom.div()(
        // Should not throw key warning, all elems have key
        [(Dom.div()..key='')(), (Dom.div()..key='')()],

        // Raw strings don't need keys, no worries!
        'b',

        ['', Dom.div()()],

        // Should throw key warning, all elements in list should have key
        [Dom.p()(), Dom.p()()],
        [(Dom.div()..key='')(), Dom.div()(), Dom.div()()],
      ));
}

ReactElement MissingKeyInMap() {
  List coolStrings = ['cool', 'cooler', '0deg kelvin'];

  return (
      Dom.div()(
        // Raw strings don't need keys, no worries!
        coolStrings.map((s) => s),

        // Should warn, Dom.div() needs a key!
        coolStrings.map((s) => Dom.div()(s)),
        coolStrings.map((s) => Dom.div()(s)).toList(),
        coolStrings.map((s) => (Dom.div())(
          Dom.p()(s),
        )),

        coolStrings.map((s) => (Dom.div()..key='bruh')( // Should not warn
          [Dom.p()(s), Dom.p()()], // Should warn
        )),
      ));
}
