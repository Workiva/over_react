import 'package:over_react/over_react.dart';

// https://github.com/dart-lang/language/issues/45


mixin DProps on UiProps {
  int d;
}

mixin CProps on UiProps
  // Adding this is a breakage, just like other interfaces
//  , DProps
{
  int c;
}

mixin BProps on UiProps, CProps {
  int b;
}

@Props()
mixin AProps on UiProps, BProps {
  // getset int a;
  int a;
}


// Need to use an actual class and not a mixin to ensure all the correct mixins are actually mixed in
class APropss = UiProps with CProps, BProps, AProps;

// Yells if you're missing one of the mixins
//class APropssBad = UiProps with CProps, AProps;

class BPropss = UiProps with CProps, BProps;

@Component2()
class AComponent extends UiComponent2<APropss> {
  @override
  render() => [props.a, props.b, props.c];
}

//
// Generated code
//
class $APropsImpl extends UiProps with
    CProps,
    // Relies on generated code as public API, but only within generated code
    $CProps,
    BProps,
    $BProps,
    AProps,
    $AProps
{}


mixin $CProps on CProps {
  @override
  int get c => props['c'];
}

mixin $BProps on BProps {
  @override
  int get b => props['b'];
}

@Props()
mixin $AProps on AProps {
//  getset int a;
  int get a => props['a'];
}

//
//class AProps extends UiProps with AProps {
//
//}

