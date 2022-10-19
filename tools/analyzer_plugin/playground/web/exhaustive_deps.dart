import 'dart:html';

import 'package:over_react/over_react.dart';

part 'exhaustive_deps.over_react.g.dart';

mixin FooProps on UiProps {}

final Foo1 = uiFunction<FooProps>((props) {
  final id = props.id;
  final count = useState(0);

  final callback = useCallback(() {
    print('Count for $id: ${count.value}');
    props.onChange(null);
  }, []);
}, null);

void useSomething(String something) {
  useEffect(() {
    print(something);
  }, []);
}

final Foo2 = uiFunction<FooProps>((_) {
  final count = useState(0);
  useEffect(() {
    count.set(1);
  }, [count]);
}, null);

final Foo3 = uiFunction<FooProps>((_) {
  final count = useState(0);
  useEffect(() {
    count.set(1 + count.value);
  }, []);
}, null);

final Foo4 = uiFunction<FooProps>((_) {
  final ref = useRef();
  useEffect(() {
    ref.current;
  }, [ref.current]);
}, null);

final Foo5 = uiFunction<FooProps>((_) {
  useEffect(() {
    window.console.log('foo');
  }, [window]);
}, null);

final Foo6 = uiFunction<FooProps>((props) {
  final id = props.id;
  useEffect(() {
    print('I don\'t even use id');
  }, [id]);
}, null);

useSomething2() {
  final a = {};
  useEffect(() {
    a['something'] = 'something else';
  }, [a]);
}

final Foo7 = uiFunction<FooProps>((props) {
  final id = props.id;
  useEffect(() {
    print('I don\'t even use id');
  }, [id]);
}, null);

useSomethingElse() {
  const a = {};
  final b = 1;
  useEffect(() {
    print(a);
    print(b);
  }, []);
}

final Foo7 = uiFunction<FooProps>((props) {
  final count = useState(0);
  foo() {
    print('something');
    // count.value;
  }

  final callback = useCallback(() {
    foo();
  }, []);

  // foo();
}, null);

// FIXME(greg) - make these warn, add regression tests

final Foo333 = uiFunction<FooProps>((_) {
  final count = useState(0);
  useEffect(() {
    count.set(1);
    // This will actually cause rerenders since it's a tearoff, so we need to make sure we have an error for this case.
  }, [count.set]);
}, null);

final Foo4444 = uiFunction<FooProps>((_) {
  final setCount = useState(0).set;
  useEffect(() {
    setCount(1);
    // This will actually cause rerenders since it's a tearoff, so we need to make sure we have an error for this case.
  }, [setCount]);
}, null);
