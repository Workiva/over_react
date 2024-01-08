// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

part 'no_need_for_generated_part.over_react.g.dart';

ReactElement renderTheFoo() {
  return Dom.div()(
    'oh hai',
    Dom.span()('again'),
    Dom.em()(' wow this is a lot we should extract it into a component!'),
  );
}
