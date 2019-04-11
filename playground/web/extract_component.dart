import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'extract_component.over_react.g.dart';

ReactElement renderTheFoo() {
  return Dom.div()(
    'oh hai',
    Dom.span()('again'),
    Dom.em()(' wow this is a lot we should extract it into a component!'),
  );
}
