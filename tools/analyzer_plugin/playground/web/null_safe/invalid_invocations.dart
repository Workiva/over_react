import 'package:over_react/over_react.dart';

import 'foo.dart';

missingParens() {
  const foo = 'foo';
  Dom.div()..id = foo(); // invocation_of_non_function
  Dom.div()..id = 'foo'(); // invocation_of_non_function_expression
  Dom.div()..onClick = (_){}(); // not_enough_required_arguments
  Dom.div()..onClick = (_){}(1, 2); // extra_positional_arguments
  Dom.div()..onClick = ({a}){}(1); // extra_positional_arguments_could_be_named
  Dom.div()..onClick = voidHandler(1); // use_of_void_result


  // ambiguous

  // Look for uninvoked builder with invocation of dynamic expression at the end
  Dom.div()..id = dynamicVar();
  Dom.div()..onClick = dynamicHandler(1);
  // look for immediately-invoked function (literal?) with dynamic return value being set to function type prop
  Dom.div()..onClick = (_){}(1);
  Dom.div()..onClick = dynamicHandler(1); // equivalent to above

moreMissingParens() {
  (Foo()
    (Foo()..id = '')()
  );

  (Dom.div()
    (Dom.span()..id = '')()
  );
  (Dom.div()
    (Dom.span())(),
  );

  (Dom.div())
    (Dom.span())(),
  );
  (Dom.div()
    Dom.span()(),
  );
}

//
//missingFactory() {
//  final int a = 1;
//  Dom.div(1);
//  Dom.div(1, 2);
//  (Dom.div..id = 1)(1, 2);
//  (Foo..id = 1)(1, 2);
//
//  // ambiguous
//  Dom.div();
//  Foo(dynamicVar);
//}
//
//noCascade() {
//  (Dom.div().id = 'foo')(1);
//}
//
//badDom() {
//  Dom..div()(1);
//  (Dom..div())(1);
//}


dynamic dynamicVar;
void voidHandler(_) => null;
dynamic dynamicHandler(_) => null;
