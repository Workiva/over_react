// ignore_for_file: implicit_dynamic_map_literal, implicit_dynamic_list_literal, prefer_adjacent_string_concatenation
const tests = {
  'tests': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    final local = {};
    print(local);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  {
    final local2 = {};
    useEffect(() {
      print(local1);
      print(local2);
    });
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(unresolved);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
    print(foo.slice(0));
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {});
  useLayoutEffect(() {});
  useImperativeHandle(props.innerRef, () {});
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.foo, props.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = someFunc();
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props.foo, props.bar, local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
  var color = someFunc();
  useEffect(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz, color]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar?.baz ?? null);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.foo?.bar);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useMemo(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar.toString());
  }, [props?.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props?.foo.bar?.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    // Doesn't use anything
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(global);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final otherThing = () {
    print(local);
  }
  final myEffect = () {
    otherThing()
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var delay = props.delay;

  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
var local = {};
myEffect() {
  print(local);
}
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  });
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useAnotherEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useWithoutEffectSuffix(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  return renderHelperConfusedWithEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
useEffect(() {
  print(local);
}, []);''',
      },
      {
        'code': /*language=dart*/ r'''
final local1 = {};
{
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, []);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;
  var foo = props.foo;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  const [isPending1] = useTransition();
  var isPending2 = useTransition();
  const [isPending3] = over_react.useTransition();
  var isPending4 = over_react.useTransition();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    startTransition1();
    isPending2.set(null);
    startTransition3();
    isPending4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    print(isPending2.value);
    print(isPending4.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    isPending2.value, isPending4.value,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set
    // In this test, we don't specify static deps.
    // That should be okay.
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set,
    // In this test, we specify static deps.
    // That should be okay too!
    definitelyRef1, definitelyRef2, state1.set, state2.set, state3.set, state4.set
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }))
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var obj = someFunc();
  useEffect(() {
    obj.foo = true;
  }, [obj]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
  }, [foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef?.current?.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, [myRef]);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useCallback(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      print(myRef.current)
    };
    window.addEventListener('mousemove', handleMove);
    return () => window.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      return () => window.removeEventListener('mousemove', handleMove);
    };
    window.addEventListener('mousemove', handleMove);
    return () {};
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, [local1, local2, local3]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = props.local;
  useEffect(() {}, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  useEffect(() {
    window.scrollTo(0, 0);
  }, [activeTab]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props]);
  final fn2 = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  final fn3 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  final fn4 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  handleNext1(value) {
    var value2 = value * 100;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(foo(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(value);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useInterval(callback, delay) {
  final savedCallback = useRef();
  useEffect(() {
    savedCallback.current = callback;
  });
  useEffect(() {
    tick() {
      savedCallback.current();
    }
    if (delay != null) {
      var id = setInterval(tick, delay);
      return () => clearInterval(id);
    }
  }, [delay]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((c) => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set((c) => c + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  useEffect(() {
    var id = setInterval(() {
      count.set('inc');
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  final tick = () {
    count.set('inc');
  };
  useEffect(() {
    var id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    podcasts.set([]);
  }, []);
  var podcasts = useState(null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withFetch(fetchPodcasts) {
  return Podcasts({ id }) {
    var podcasts = useState(null);
    useEffect(() {
      fetchPodcasts(id).then(podcasts.set);
    }, [id]);
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    doFetch({ fetchPodcasts }) {
      fetchPodcasts(id).then(podcasts.set);
    }
    doFetch({ fetchPodcasts: API.fetchPodcasts });
  }, [id]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set(increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
import increment from './increment';
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withStuff(increment) {
  return Counter() {
    var count = useState(0);
    useEffect(() {
      var id = setInterval(() {
        count.set((count.value) => count.value + increment);
      }, 1000);
      return () => clearInterval(id);
    }, []);
    return <h1>{count.value}</h1>;
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  var query = useState('react');
  var state = useState(null);
  useEffect(() {
    var ignore = false;
    fetchSomething();
    fetchSomething() async {
      final result = await (await fetch('http://hn.algolia.com/api/v1/search?query.value=' + query.value)).json();
      if (!ignore) state.set(result);
    }
    return () { ignore = true; };
  }, [query.value]);
  return (
    <>
      <input value={query.value} onChange={(e) => query.set(e.target.value)} />
      {jsonEncode(state.value)}
    </>
  );
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    if (prop) {
      foo();
    }
  }, [prop]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    final handleResize = () => state.set(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    arguments
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    final bar = () {
      arguments;
    };
    bar();
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(foo){
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  final foo = "hi!";
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let {foo} = {foo: 1};
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let [foo] = [1];
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo() {
  final foo = "fine";
  if (true) {
    // Shadowed variable with constant construction in a nested scope is fine.
    final foo = {};
  }
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  return useMemo(() => foo, [foo])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final foo = true ? "fine" : "also fine";
  return useMemo(() => foo, [foo]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, [props.foo?.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar?.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar?.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props.foo?.bar?.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo?.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, [props.foo?.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final value = useMemo(() { return 2*2; });
  final fn = useCallback(() { alert('foo'); });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var fn1 = props.fn1;
  var fn2 = props.fn2;

  final value = useMemo(fn1);
  final fn = useCallback(fn2);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect()
  useLayoutEffect()
  useCallback()
  useMemo()
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useLayoutEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useMemo requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, []);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local1\' and \'local2\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1, local2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1, local2]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'local2\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1]);
  }, null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local2\'. Either include it or remove the dependency array. Outer scope values like \'local1\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, [history.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history?.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history?.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, [history?.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {}, ['foo']);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, ['foo', 'bar']);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. Did you mean to include foo in the array instead?',
            'suggestions': null,
          },
          {
            'message':
                'The \'bar\' literal is not a valid dependency because it never changes. Did you mean to include bar in the array instead?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [42, false, null]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The 42 literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The false literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The null literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final dependencies = [];
  useEffect(() {}, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local, ...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [computeCacheKey(local)]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items, props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items, items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, local.id]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local, local.id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local.id\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'color\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [color, props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [color, props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo.bar.baz\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.foo.bar.baz\' and \'props.foo.fizz.bizz\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz, props.foo.fizz.bizz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, [props.foo.bar.baz, props.foo.fizz.bizz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [c, a, g, b, e, d, f]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g, b, e, d, f]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, c, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'a\', \'b\', \'c\', \'d\', \'e\', \'f\', and \'g\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local\', \'props.bar\', and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, [props.foo]);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
        'errors': [
          {
            'message':
                'React Hook useCustomEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a ? local : b]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a && local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props?.attribute.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref, state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref, state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.color\' and \'props.someOtherRefs\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.color, props.someOtherRefs]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.color, props.someOtherRefs]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1.current, ref2.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1?.current, ref2?.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [ref1.current, ref2.current, activeTab]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [activeTab]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [activeTab]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [ref1.current, ref2.current, activeTab, initY]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'activeTab\', \'ref1.current\', and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [initY]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [initY]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current, ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [])
});''',
        'errors': [
          {
            'message':
                'React Hook useImperativeHandle has a missing dependency: \'props.hello\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.hello]',
                'output': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [skillsCount, props.isEditMode, props.toggleEditMode, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props\' and \'skillsCount\'. Either include them or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props, skillsCount]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [props, skillsCount]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var value4;
  var asyncValue;
  useEffect(() {
    if (value4) {
      value = {};
    }
    value2 = 100;
    value = 43;
    value4 = true;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value4\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var asyncValue;
  useEffect(() {
    value = {};
    value2 = 100;
    value = 43;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, [value, value2, value3]);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef?.current?.addEventListener('mousemove', handleMove);
    return () => myRef?.current?.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef, active) {
  useEffect(() {
    final handleMove = () {};
    if (active) {
      myRef.current.addEventListener('mousemove', handleMove);
      return () {
        setTimeout(() {
          myRef.current.removeEventListener('mousemove', handleMove);
        });
      }
    }
  }, [myRef, active]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.'
        ],
        'options': [
          {
            'additionalHooks': 'useLayoutEffect_SAFE_FOR_SSR',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local4\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local1, local3, local4]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3, local4]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, [MutableStore.hello]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'MutableStore.hello\'. Either exclude it or remove the dependency array. Outer scope values like \'MutableStore.hello\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore?.hello?.world, props.foo, x, y, z, global?.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  handleNext(value) {
    state.set(value);
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = useCallback((value) {
    state.set(value);
  });
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 17) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 20) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = useCallback(() {
    print('hello');
  });
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. To fix this, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = useCallback(() {
    print('hello');
  });
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = () {
    print('hello');
  };
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = () {
    print('hello');
  };
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 13) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = useCallback(() {
    print('hello');
  });
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var taint = props.foo;
  handleNext(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [count]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'count\' and \'increment\'. Either include them or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [count, increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value, increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. You can also replace multiple useState variables with useReducer if \'setCount\' needs the current value of \'increment\'.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'The \'increment\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'increment\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. If \'setCount\' needs the current value of \'increment\', you can also switch to useReducer instead of useState and read \'increment\' in the reducer.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'tick\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [tick]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, [tick]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, []);
  var podcasts = useState(null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'podcasts\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [podcasts]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, [podcasts.value]);
  var podcasts = useState(null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'fetchPodcasts\' and \'fetchPodcasts2\'. Either include them or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, fetchPodcasts2, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [fetchPodcasts, fetchPodcasts2, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, [fetchData]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'fetchData\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [country] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [country]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  }, [country]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [prop1, prop2] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [prop1, prop2]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  }, [prop1, prop2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {}, []);
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {});
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [foo]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'prop\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [prop]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [prop]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'otherThing\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [otherThing]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, [otherThing]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(debounce(() {
    print(local);
  }, delay), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect received a function whose dependencies are unknown. Pass an inline function instead.',
            'suggestions': [],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
          }
        ],
        'options': [
          {
            'enableDangerousAutofixThisMayCauseInfiniteLoops': true,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'foo.bar\' and \'props.foo.bar\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [foo.bar, props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, [foo.bar, props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = [];
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' array makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = () {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar(){};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = class {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' class makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = true ? {} : "fine";
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar || {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ?? {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar && {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ? baz ? {} : null : null;
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useCallback(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useCallback Hook (at line 6) change on every render. Move it inside the useCallback callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useImperativeHandle(
    ref,
    () {
       print(foo);
    },
    [foo]
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useImperativeHandle Hook (at line 9) change on every render. Move it inside the useImperativeHandle callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = section.section_components?.edges ?? [];
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = {};
  print(foo);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 7) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <>Hi!</>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX fragment makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <div>Hi!</div>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX element makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = bar = {};
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' assignment expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new String('foo'); // Note 'foo' will be boxed, and thus an object and thus compared by reference.
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new Map([]);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = /reg/;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' regular expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  class Bar {};
  useMemo(() {
    print(new Bar());
  }, [Bar]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'Bar\' class makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'Bar\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 9) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsFlow': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final bar = useEffect(<T>(a: T): (Hello) {
    prop();
  }, [prop]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = ({}: any);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescript': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef() as over_react.MutableRefObject<HTMLDivElement>;
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber);
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  over_react.useEffect(() {
    final bar = {x: 2};
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar]',
                'output': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, [bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'pizza.crust\' and \'pizza?.toppings\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [pizza.crust, pizza?.toppings]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), [pizza.crust, pizza?.toppings]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza?.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza?.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), [pizza?.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props?.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props?.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [state.value])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [state.value])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'state\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {} as any;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescriptEslintParserV4': {
    'valid': [],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, []);
}, null);;''',
        'errors': [
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'Component\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [Component]',
                'output': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, [Component]);
}, null);;''',
              }
            ],
          }
        ],
      }
    ],
  },
};
const testsFlow = {
  'tests': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    final local = {};
    print(local);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  {
    final local2 = {};
    useEffect(() {
      print(local1);
      print(local2);
    });
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(unresolved);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [null, null, null, local, null, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
    print(foo.slice(0));
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {});
  useLayoutEffect(() {});
  useImperativeHandle(props.innerRef, () {});
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.foo, props.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = someFunc();
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props.foo, props.bar, local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
  var color = someFunc();
  useEffect(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz, color]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar?.baz ?? null);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.foo?.bar);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useMemo(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar.toString());
  }, [props?.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props?.foo.bar?.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    // Doesn't use anything
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(global);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var delay = props.delay;

  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
var local = {};
myEffect() {
  print(local);
}
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  });
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useAnotherEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useWithoutEffectSuffix(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  return renderHelperConfusedWithEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
useEffect(() {
  print(local);
}, []);''',
      },
      {
        'code': /*language=dart*/ r'''
final local1 = {};
{
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, []);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;
  var foo = props.foo;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  const [isPending1] = useTransition();
  var isPending2 = useTransition();
  const [isPending3] = over_react.useTransition();
  var isPending4 = over_react.useTransition();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    startTransition1();
    isPending2.set(null);
    startTransition3();
    isPending4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    print(isPending2.value);
    print(isPending4.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    isPending2.value, isPending4.value,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set
    // In this test, we don't specify static deps.
    // That should be okay.
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set,
    // In this test, we specify static deps.
    // That should be okay too!
    definitelyRef1, definitelyRef2, state1.set, state2.set, state3.set, state4.set
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }))
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var obj = someFunc();
  useEffect(() {
    obj.foo = true;
  }, [obj]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
  }, [foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef?.current?.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, [myRef]);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useCallback(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      print(myRef.current)
    };
    window.addEventListener('mousemove', handleMove);
    return () => window.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      return () => window.removeEventListener('mousemove', handleMove);
    };
    window.addEventListener('mousemove', handleMove);
    return () {};
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, [local1, local2, local3]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = props.local;
  useEffect(() {}, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  useEffect(() {
    window.scrollTo(0, 0);
  }, [activeTab]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props]);
  final fn2 = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  final fn3 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  final fn4 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  handleNext1(value) {
    var value2 = value * 100;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(foo(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(value);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useInterval(callback, delay) {
  final savedCallback = useRef();
  useEffect(() {
    savedCallback.current = callback;
  });
  useEffect(() {
    tick() {
      savedCallback.current();
    }
    if (delay != null) {
      var id = setInterval(tick, delay);
      return () => clearInterval(id);
    }
  }, [delay]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((c) => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set((c) => c + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  useEffect(() {
    var id = setInterval(() {
      count.set('inc');
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  final tick = () {
    count.set('inc');
  };
  useEffect(() {
    var id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    podcasts.set([]);
  }, []);
  var podcasts = useState(null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withFetch(fetchPodcasts) {
  return Podcasts({ id }) {
    var podcasts = useState(null);
    useEffect(() {
      fetchPodcasts(id).then(podcasts.set);
    }, [id]);
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    doFetch({ fetchPodcasts }) {
      fetchPodcasts(id).then(podcasts.set);
    }
    doFetch({ fetchPodcasts: API.fetchPodcasts });
  }, [id]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set(increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
import increment from './increment';
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withStuff(increment) {
  return Counter() {
    var count = useState(0);
    useEffect(() {
      var id = setInterval(() {
        count.set((count.value) => count.value + increment);
      }, 1000);
      return () => clearInterval(id);
    }, []);
    return <h1>{count.value}</h1>;
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  var query = useState('react');
  var state = useState(null);
  useEffect(() {
    var ignore = false;
    fetchSomething();
    fetchSomething() async {
      final result = await (await fetch('http://hn.algolia.com/api/v1/search?query.value=' + query.value)).json();
      if (!ignore) state.set(result);
    }
    return () { ignore = true; };
  }, [query.value]);
  return (
    <>
      <input value={query.value} onChange={(e) => query.set(e.target.value)} />
      {jsonEncode(state.value)}
    </>
  );
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    if (prop) {
      foo();
    }
  }, [prop]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    final handleResize = () => state.set(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    arguments
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    final bar = () {
      arguments;
    };
    bar();
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(foo){
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  final foo = "hi!";
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let {foo} = {foo: 1};
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let [foo] = [1];
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo() {
  final foo = "fine";
  if (true) {
    // Shadowed variable with constant construction in a nested scope is fine.
    final foo = {};
  }
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  return useMemo(() => foo, [foo])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final foo = true ? "fine" : "also fine";
  return useMemo(() => foo, [foo]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, [props.foo?.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar?.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar?.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props.foo?.bar?.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo?.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, [props.foo?.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final value = useMemo(() { return 2*2; });
  final fn = useCallback(() { alert('foo'); });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var fn1 = props.fn1;
  var fn2 = props.fn2;

  final value = useMemo(fn1);
  final fn = useCallback(fn2);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect()
  useLayoutEffect()
  useCallback()
  useMemo()
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useLayoutEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useMemo requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, []);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local1\' and \'local2\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1, local2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1, local2]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'local2\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1]);
  }, null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local2\'. Either include it or remove the dependency array. Outer scope values like \'local1\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, [history.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history?.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history?.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, [history?.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {}, ['foo']);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, ['foo', 'bar']);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. Did you mean to include foo in the array instead?',
            'suggestions': null,
          },
          {
            'message':
                'The \'bar\' literal is not a valid dependency because it never changes. Did you mean to include bar in the array instead?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [42, false, null]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The 42 literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The false literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The null literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final dependencies = [];
  useEffect(() {}, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local, ...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [computeCacheKey(local)]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items, props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items, items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, local.id]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local, local.id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local.id\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'color\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [color, props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [color, props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo.bar.baz\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.foo.bar.baz\' and \'props.foo.fizz.bizz\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz, props.foo.fizz.bizz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, [props.foo.bar.baz, props.foo.fizz.bizz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [c, a, g, b, e, d, f]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g, b, e, d, f]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, c, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'a\', \'b\', \'c\', \'d\', \'e\', \'f\', and \'g\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local\', \'props.bar\', and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, [props.foo]);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
        'errors': [
          {
            'message':
                'React Hook useCustomEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a ? local : b]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a && local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props?.attribute.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref, state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref, state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.color\' and \'props.someOtherRefs\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.color, props.someOtherRefs]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.color, props.someOtherRefs]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1.current, ref2.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1?.current, ref2?.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [ref1.current, ref2.current, activeTab]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [activeTab]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [activeTab]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [ref1.current, ref2.current, activeTab, initY]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'activeTab\', \'ref1.current\', and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [initY]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [initY]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current, ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [])
});''',
        'errors': [
          {
            'message':
                'React Hook useImperativeHandle has a missing dependency: \'props.hello\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.hello]',
                'output': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [skillsCount, props.isEditMode, props.toggleEditMode, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props\' and \'skillsCount\'. Either include them or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props, skillsCount]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [props, skillsCount]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var value4;
  var asyncValue;
  useEffect(() {
    if (value4) {
      value = {};
    }
    value2 = 100;
    value = 43;
    value4 = true;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value4\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var asyncValue;
  useEffect(() {
    value = {};
    value2 = 100;
    value = 43;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, [value, value2, value3]);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef?.current?.addEventListener('mousemove', handleMove);
    return () => myRef?.current?.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef, active) {
  useEffect(() {
    final handleMove = () {};
    if (active) {
      myRef.current.addEventListener('mousemove', handleMove);
      return () {
        setTimeout(() {
          myRef.current.removeEventListener('mousemove', handleMove);
        });
      }
    }
  }, [myRef, active]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.'
        ],
        'options': [
          {
            'additionalHooks': 'useLayoutEffect_SAFE_FOR_SSR',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local4\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local1, local3, local4]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3, local4]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, [MutableStore.hello]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'MutableStore.hello\'. Either exclude it or remove the dependency array. Outer scope values like \'MutableStore.hello\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore?.hello?.world, props.foo, x, y, z, global?.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  handleNext(value) {
    state.set(value);
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = useCallback((value) {
    state.set(value);
  });
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 17) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 20) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = useCallback(() {
    print('hello');
  });
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. To fix this, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = useCallback(() {
    print('hello');
  });
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = () {
    print('hello');
  };
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = () {
    print('hello');
  };
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 13) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = useCallback(() {
    print('hello');
  });
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var taint = props.foo;
  handleNext(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [count]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'count\' and \'increment\'. Either include them or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [count, increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value, increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. You can also replace multiple useState variables with useReducer if \'setCount\' needs the current value of \'increment\'.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'The \'increment\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'increment\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. If \'setCount\' needs the current value of \'increment\', you can also switch to useReducer instead of useState and read \'increment\' in the reducer.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'tick\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [tick]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, [tick]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, []);
  var podcasts = useState(null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'podcasts\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [podcasts]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, [podcasts.value]);
  var podcasts = useState(null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'fetchPodcasts\' and \'fetchPodcasts2\'. Either include them or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, fetchPodcasts2, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [fetchPodcasts, fetchPodcasts2, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, [fetchData]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'fetchData\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [country] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [country]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  }, [country]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [prop1, prop2] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [prop1, prop2]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  }, [prop1, prop2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {}, []);
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {});
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [foo]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'prop\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [prop]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [prop]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'otherThing\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [otherThing]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, [otherThing]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(debounce(() {
    print(local);
  }, delay), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect received a function whose dependencies are unknown. Pass an inline function instead.',
            'suggestions': [],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
          }
        ],
        'options': [
          {
            'enableDangerousAutofixThisMayCauseInfiniteLoops': true,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'foo.bar\' and \'props.foo.bar\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [foo.bar, props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, [foo.bar, props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = [];
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' array makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = () {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar(){};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = class {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' class makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = true ? {} : "fine";
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar || {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ?? {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar && {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ? baz ? {} : null : null;
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useCallback(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useCallback Hook (at line 6) change on every render. Move it inside the useCallback callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useImperativeHandle(
    ref,
    () {
       print(foo);
    },
    [foo]
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useImperativeHandle Hook (at line 9) change on every render. Move it inside the useImperativeHandle callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = section.section_components?.edges ?? [];
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = {};
  print(foo);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 7) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <>Hi!</>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX fragment makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <div>Hi!</div>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX element makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = bar = {};
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' assignment expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new String('foo'); // Note 'foo' will be boxed, and thus an object and thus compared by reference.
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new Map([]);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = /reg/;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' regular expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  class Bar {};
  useMemo(() {
    print(new Bar());
  }, [Bar]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'Bar\' class makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'Bar\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 9) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsFlow': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final bar = useEffect(<T>(a: T): (Hello) {
    prop();
  }, [prop]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = ({}: any);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescript': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef() as over_react.MutableRefObject<HTMLDivElement>;
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber);
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  over_react.useEffect(() {
    final bar = {x: 2};
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar]',
                'output': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, [bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'pizza.crust\' and \'pizza?.toppings\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [pizza.crust, pizza?.toppings]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), [pizza.crust, pizza?.toppings]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza?.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza?.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), [pizza?.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props?.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props?.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [state.value])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [state.value])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'state\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {} as any;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescriptEslintParserV4': {
    'valid': [],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, []);
}, null);;''',
        'errors': [
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'Component\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [Component]',
                'output': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, [Component]);
}, null);;''',
              }
            ],
          }
        ],
      }
    ],
  },
};
const testsTypescript = {
  'tests': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    final local = {};
    print(local);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  {
    final local2 = {};
    useEffect(() {
      print(local1);
      print(local2);
    });
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(unresolved);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [null, null, null, local, null, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
    print(foo.slice(0));
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {});
  useLayoutEffect(() {});
  useImperativeHandle(props.innerRef, () {});
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.foo, props.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = someFunc();
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props.foo, props.bar, local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
  var color = someFunc();
  useEffect(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz, color]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar?.baz ?? null);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.foo?.bar);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useMemo(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar.toString());
  }, [props?.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props?.foo.bar?.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    // Doesn't use anything
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(global);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    otherThing()
  }
  final otherThing = () {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var delay = props.delay;

  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
var local = {};
myEffect() {
  print(local);
}
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  });
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useAnotherEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useWithoutEffectSuffix(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  return renderHelperConfusedWithEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
useEffect(() {
  print(local);
}, []);''',
      },
      {
        'code': /*language=dart*/ r'''
final local1 = {};
{
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, []);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;
  var foo = props.foo;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  const [isPending1] = useTransition();
  var isPending2 = useTransition();
  const [isPending3] = over_react.useTransition();
  var isPending4 = over_react.useTransition();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    startTransition1();
    isPending2.set(null);
    startTransition3();
    isPending4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    print(isPending2.value);
    print(isPending4.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    isPending2.value, isPending4.value,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set
    // In this test, we don't specify static deps.
    // That should be okay.
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set,
    // In this test, we specify static deps.
    // That should be okay too!
    definitelyRef1, definitelyRef2, state1.set, state2.set, state3.set, state4.set
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }))
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var obj = someFunc();
  useEffect(() {
    obj.foo = true;
  }, [obj]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
  }, [foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef?.current?.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, [myRef]);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useCallback(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      print(myRef.current)
    };
    window.addEventListener('mousemove', handleMove);
    return () => window.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      return () => window.removeEventListener('mousemove', handleMove);
    };
    window.addEventListener('mousemove', handleMove);
    return () {};
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, [local1, local2, local3]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = props.local;
  useEffect(() {}, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  useEffect(() {
    window.scrollTo(0, 0);
  }, [activeTab]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props]);
  final fn2 = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  final fn3 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  final fn4 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  handleNext1(value) {
    var value2 = value * 100;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(foo(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(value);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useInterval(callback, delay) {
  final savedCallback = useRef();
  useEffect(() {
    savedCallback.current = callback;
  });
  useEffect(() {
    tick() {
      savedCallback.current();
    }
    if (delay != null) {
      var id = setInterval(tick, delay);
      return () => clearInterval(id);
    }
  }, [delay]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((c) => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set((c) => c + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  useEffect(() {
    var id = setInterval(() {
      count.set('inc');
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  final tick = () {
    count.set('inc');
  };
  useEffect(() {
    var id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    podcasts.set([]);
  }, []);
  var podcasts = useState(null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withFetch(fetchPodcasts) {
  return Podcasts({ id }) {
    var podcasts = useState(null);
    useEffect(() {
      fetchPodcasts(id).then(podcasts.set);
    }, [id]);
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    doFetch({ fetchPodcasts }) {
      fetchPodcasts(id).then(podcasts.set);
    }
    doFetch({ fetchPodcasts: API.fetchPodcasts });
  }, [id]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set(increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
import increment from './increment';
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withStuff(increment) {
  return Counter() {
    var count = useState(0);
    useEffect(() {
      var id = setInterval(() {
        count.set((count.value) => count.value + increment);
      }, 1000);
      return () => clearInterval(id);
    }, []);
    return <h1>{count.value}</h1>;
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  var query = useState('react');
  var state = useState(null);
  useEffect(() {
    var ignore = false;
    fetchSomething();
    fetchSomething() async {
      final result = await (await fetch('http://hn.algolia.com/api/v1/search?query.value=' + query.value)).json();
      if (!ignore) state.set(result);
    }
    return () { ignore = true; };
  }, [query.value]);
  return (
    <>
      <input value={query.value} onChange={(e) => query.set(e.target.value)} />
      {jsonEncode(state.value)}
    </>
  );
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    if (prop) {
      foo();
    }
  }, [prop]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    final handleResize = () => state.set(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    arguments
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    final bar = () {
      arguments;
    };
    bar();
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(foo){
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  final foo = "hi!";
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let {foo} = {foo: 1};
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let [foo] = [1];
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo() {
  final foo = "fine";
  if (true) {
    // Shadowed variable with constant construction in a nested scope is fine.
    final foo = {};
  }
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  return useMemo(() => foo, [foo])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final foo = true ? "fine" : "also fine";
  return useMemo(() => foo, [foo]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, [props.foo?.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar?.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar?.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props.foo?.bar?.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo?.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, [props.foo?.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final value = useMemo(() { return 2*2; });
  final fn = useCallback(() { alert('foo'); });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var fn1 = props.fn1;
  var fn2 = props.fn2;

  final value = useMemo(fn1);
  final fn = useCallback(fn2);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect()
  useLayoutEffect()
  useCallback()
  useMemo()
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useLayoutEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useMemo requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, []);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local1\' and \'local2\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1, local2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1, local2]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'local2\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1]);
  }, null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local2\'. Either include it or remove the dependency array. Outer scope values like \'local1\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, [history.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history?.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history?.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, [history?.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {}, ['foo']);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, ['foo', 'bar']);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. Did you mean to include foo in the array instead?',
            'suggestions': null,
          },
          {
            'message':
                'The \'bar\' literal is not a valid dependency because it never changes. Did you mean to include bar in the array instead?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [42, false, null]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The 42 literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The false literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The null literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final dependencies = [];
  useEffect(() {}, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local, ...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [computeCacheKey(local)]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items, props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items, items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, local.id]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local, local.id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local.id\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'color\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [color, props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [color, props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo.bar.baz\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.foo.bar.baz\' and \'props.foo.fizz.bizz\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz, props.foo.fizz.bizz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, [props.foo.bar.baz, props.foo.fizz.bizz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [c, a, g, b, e, d, f]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g, b, e, d, f]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, c, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'a\', \'b\', \'c\', \'d\', \'e\', \'f\', and \'g\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local\', \'props.bar\', and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, [props.foo]);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
        'errors': [
          {
            'message':
                'React Hook useCustomEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a ? local : b]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a && local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props?.attribute.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref, state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref, state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.color\' and \'props.someOtherRefs\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.color, props.someOtherRefs]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.color, props.someOtherRefs]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1.current, ref2.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1?.current, ref2?.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [ref1.current, ref2.current, activeTab]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [activeTab]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [activeTab]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [ref1.current, ref2.current, activeTab, initY]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'activeTab\', \'ref1.current\', and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [initY]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [initY]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current, ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [])
});''',
        'errors': [
          {
            'message':
                'React Hook useImperativeHandle has a missing dependency: \'props.hello\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.hello]',
                'output': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [skillsCount, props.isEditMode, props.toggleEditMode, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props\' and \'skillsCount\'. Either include them or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props, skillsCount]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [props, skillsCount]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var value4;
  var asyncValue;
  useEffect(() {
    if (value4) {
      value = {};
    }
    value2 = 100;
    value = 43;
    value4 = true;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value4\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var asyncValue;
  useEffect(() {
    value = {};
    value2 = 100;
    value = 43;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, [value, value2, value3]);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef?.current?.addEventListener('mousemove', handleMove);
    return () => myRef?.current?.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef, active) {
  useEffect(() {
    final handleMove = () {};
    if (active) {
      myRef.current.addEventListener('mousemove', handleMove);
      return () {
        setTimeout(() {
          myRef.current.removeEventListener('mousemove', handleMove);
        });
      }
    }
  }, [myRef, active]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.'
        ],
        'options': [
          {
            'additionalHooks': 'useLayoutEffect_SAFE_FOR_SSR',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local4\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local1, local3, local4]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3, local4]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, [MutableStore.hello]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'MutableStore.hello\'. Either exclude it or remove the dependency array. Outer scope values like \'MutableStore.hello\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore?.hello?.world, props.foo, x, y, z, global?.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  handleNext(value) {
    state.set(value);
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = useCallback((value) {
    state.set(value);
  });
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 17) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 20) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = useCallback(() {
    print('hello');
  });
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. To fix this, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = useCallback(() {
    print('hello');
  });
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = () {
    print('hello');
  };
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = () {
    print('hello');
  };
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 13) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = useCallback(() {
    print('hello');
  });
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var taint = props.foo;
  handleNext(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [count]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'count\' and \'increment\'. Either include them or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [count, increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value, increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. You can also replace multiple useState variables with useReducer if \'setCount\' needs the current value of \'increment\'.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'The \'increment\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'increment\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. If \'setCount\' needs the current value of \'increment\', you can also switch to useReducer instead of useState and read \'increment\' in the reducer.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'tick\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [tick]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, [tick]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, []);
  var podcasts = useState(null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'podcasts\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [podcasts]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, [podcasts.value]);
  var podcasts = useState(null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'fetchPodcasts\' and \'fetchPodcasts2\'. Either include them or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, fetchPodcasts2, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [fetchPodcasts, fetchPodcasts2, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, [fetchData]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'fetchData\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [country] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [country]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  }, [country]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [prop1, prop2] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [prop1, prop2]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  }, [prop1, prop2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {}, []);
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {});
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [foo]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'prop\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [prop]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [prop]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'otherThing\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [otherThing]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, [otherThing]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(debounce(() {
    print(local);
  }, delay), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect received a function whose dependencies are unknown. Pass an inline function instead.',
            'suggestions': [],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
          }
        ],
        'options': [
          {
            'enableDangerousAutofixThisMayCauseInfiniteLoops': true,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'foo.bar\' and \'props.foo.bar\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [foo.bar, props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, [foo.bar, props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = [];
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' array makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = () {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar(){};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = class {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' class makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = true ? {} : "fine";
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar || {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ?? {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar && {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ? baz ? {} : null : null;
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useCallback(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useCallback Hook (at line 6) change on every render. Move it inside the useCallback callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useImperativeHandle(
    ref,
    () {
       print(foo);
    },
    [foo]
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useImperativeHandle Hook (at line 9) change on every render. Move it inside the useImperativeHandle callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = section.section_components?.edges ?? [];
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = {};
  print(foo);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 7) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <>Hi!</>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX fragment makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <div>Hi!</div>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX element makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = bar = {};
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' assignment expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new String('foo'); // Note 'foo' will be boxed, and thus an object and thus compared by reference.
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new Map([]);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = /reg/;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' regular expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  class Bar {};
  useMemo(() {
    print(new Bar());
  }, [Bar]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'Bar\' class makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'Bar\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 9) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsFlow': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final bar = useEffect(<T>(a: T): (Hello) {
    prop();
  }, [prop]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = ({}: any);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescript': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef() as over_react.MutableRefObject<HTMLDivElement>;
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber);
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  over_react.useEffect(() {
    final bar = {x: 2};
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar]',
                'output': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, [bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'pizza.crust\' and \'pizza?.toppings\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [pizza.crust, pizza?.toppings]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), [pizza.crust, pizza?.toppings]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza?.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza?.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), [pizza?.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props?.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props?.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [state.value])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [state.value])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'state\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {} as any;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescriptEslintParserV4': {
    'valid': [],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, []);
}, null);;''',
        'errors': [
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'Component\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [Component]',
                'output': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, [Component]);
}, null);;''',
              }
            ],
          }
        ],
      }
    ],
  },
};
const testsTypescriptEslintParserV4 = {
  'tests': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    final local = {};
    print(local);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  {
    final local2 = {};
    useEffect(() {
      print(local1);
      print(local2);
    });
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = someFunc();
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(unresolved);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [null, null, null, local, null, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  useEffect(() {
    print(foo.length);
    print(foo.slice(0));
  }, [foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {});
  useLayoutEffect(() {});
  useImperativeHandle(props.innerRef, () {});
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.foo, props.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = someFunc();
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props.foo, props.bar, local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
  var color = someFunc();
  useEffect(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz, color]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar?.baz ?? null);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar);
    print(props.foo?.bar);
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.foo?.bar);
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useMemo(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.toString());
  }, [props.foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo.bar.toString());
  }, [props?.foo?.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props?.foo.bar?.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    // Doesn't use anything
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  myEffect() {
    print(global);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
final MyComponent = uiFunction<TestProps>((_) {
  final myEffect = () {
    otherThing()
  }
  final otherThing = () {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var delay = props.delay;

  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [null, myEffect, null, null]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
var local = {};
myEffect() {
  print(local);
}
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(myEffect, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  });
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useAnotherEffect',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useWithoutEffectSuffix(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  return renderHelperConfusedWithEffect(() {
    print(props.foo);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final local = {};
useEffect(() {
  print(local);
}, []);''',
      },
      {
        'code': /*language=dart*/ r'''
final local1 = {};
{
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, []);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;
  var foo = props.foo;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  const [isPending1] = useTransition();
  var isPending2 = useTransition();
  const [isPending3] = over_react.useTransition();
  var isPending4 = over_react.useTransition();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    startTransition1();
    isPending2.set(null);
    startTransition3();
    isPending4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    print(isPending2.value);
    print(isPending4.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    isPending2.value, isPending4.value,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set
    // In this test, we don't specify static deps.
    // That should be okay.
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var maybeRef2 = props.maybeRef2;

  final definitelyRef1 = useRef();
  final definitelyRef2 = useRef();
  final maybeRef1 = useSomeOtherRefyThing();
  var state1 = useState();
  var state2 = over_react.useState();
  var state3 = useReducer();
  var state4 = over_react.useReducer();
  var state5 = useFunnyState();
  var state6 = useFunnyReducer();
  final mySetState = useCallback(() {}, []);
  var myDispatch = useCallback(() {}, []);
  useEffect(() {
    // Known to be static
    print(definitelyRef1.current);
    print(definitelyRef2.current);
    print(maybeRef1.current);
    print(maybeRef2.current);
    state1.set(null);
    state2.set(null);
    state3.set(null);
    state4.set(null);
    // Dynamic
    print(state1.value);
    print(state2.value);
    print(state3.value);
    print(state4.value);
    print(state5.value);
    print(state6.value);
    mySetState();
    myDispatch();
    // Not sure; assume dynamic
    state5.set(null);
    state6.set(null);
  }, [
    // Dynamic
    state1.value, state2.value, state3.value, state4.value, state5.value, state6.value,
    maybeRef1, maybeRef2,
    // Not sure; assume dynamic
    mySetState, myDispatch,
    state5.set, state6.set,
    // In this test, we specify static deps.
    // That should be okay too!
    definitelyRef1, definitelyRef2, state1.set, state2.set, state3.set, state4.set
  ]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }))
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var obj = someFunc();
  useEffect(() {
    obj.foo = true;
  }, [obj]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
  }, [foo.bar]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef?.current?.toString())
    };
  }, []);
  return <div />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current = {};
    return () {
      print(myRef.current.toString())
    };
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    final node = myRef.current;
    node.addEventListener('mousemove', handleMove);
    return () => node.removeEventListener('mousemove', handleMove);
  }, [myRef]);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useCallback(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      print(myRef.current)
    };
    window.addEventListener('mousemove', handleMove);
    return () => window.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
useMyThing() {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {
      return () => window.removeEventListener('mousemove', handleMove);
    };
    window.addEventListener('mousemove', handleMove);
    return () {};
  }, []);
  return <div ref={myRef} />;
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
  }, [local1, local2, local3]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = props.local;
  useEffect(() {}, [local]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  useEffect(() {
    window.scrollTo(0, 0);
  }, [activeTab]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  useEffect(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props]);
  final fn2 = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
  final fn3 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar]);
  final fn4 = useMemo(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  handleNext1(value) {
    var value2 = value * 100;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(foo(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(value);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useInterval(callback, delay) {
  final savedCallback = useRef();
  useEffect(() {
    savedCallback.current = callback;
  });
  useEffect(() {
    tick() {
      savedCallback.current();
    }
    if (delay != null) {
      var id = setInterval(tick, delay);
      return () => clearInterval(id);
    }
  }, [delay]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((c) => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set((c) => c + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  useEffect(() {
    var id = setInterval(() {
      count.set('inc');
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useReducer((state, action) {
    if (action == 'inc') {
      return state + 1;
    }
  }, 0);
  final tick = () {
    count.set('inc');
  };
  useEffect(() {
    var id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    podcasts.set([]);
  }, []);
  var podcasts = useState(null);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withFetch(fetchPodcasts) {
  return Podcasts({ id }) {
    var podcasts = useState(null);
    useEffect(() {
      fetchPodcasts(id).then(podcasts.set);
    }, [id]);
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    doFetch({ fetchPodcasts }) {
      fetchPodcasts(id).then(podcasts.set);
    }
    doFetch({ fetchPodcasts: API.fetchPodcasts });
  }, [id]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set(increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  increment(x) {
    return x + 1;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
import increment from './increment';
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
withStuff(increment) {
  return Counter() {
    var count = useState(0);
    useEffect(() {
      var id = setInterval(() {
        count.set((count.value) => count.value + increment);
      }, 1000);
      return () => clearInterval(id);
    }, []);
    return <h1>{count.value}</h1>;
  }
}''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  var query = useState('react');
  var state = useState(null);
  useEffect(() {
    var ignore = false;
    fetchSomething();
    fetchSomething() async {
      final result = await (await fetch('http://hn.algolia.com/api/v1/search?query.value=' + query.value)).json();
      if (!ignore) state.set(result);
    }
    return () { ignore = true; };
  }, [query.value]);
  return (
    <>
      <input value={query.value} onChange={(e) => query.set(e.target.value)} />
      {jsonEncode(state.value)}
    </>
  );
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    if (prop) {
      foo();
    }
  }, [prop]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    final handleResize = () => state.set(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  });
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    arguments
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  useEffect(() {
    final bar = () {
      arguments;
    };
    bar();
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props]);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(foo){
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  final foo = "hi!";
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let {foo} = {foo: 1};
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo(){
  let [foo] = [1];
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
useFoo() {
  final foo = "fine";
  if (true) {
    // Shadowed variable with constant construction in a nested scope is fine.
    final foo = {};
  }
  return useMemo(() => foo, [foo]);
}''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;

  return useMemo(() => foo, [foo])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final foo = true ? "fine" : "also fine";
  return useMemo(() => foo, [foo]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.toString());
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.baz);
  }, [props.foo?.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar?.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo?.bar?.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar?.baz);
  }, [props.foo?.bar?.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo?.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo?.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCallback(() {
    print(props.foo?.bar.toString());
  }, [props.foo?.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var local = 42;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = /foo/;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final value = useMemo(() { return 2*2; });
  final fn = useCallback(() { alert('foo'); });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var fn1 = props.fn1;
  var fn2 = props.fn2;

  final value = useMemo(fn1);
  final fn = useCallback(fn2);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback does nothing when called with only one argument. Did you forget to pass an array of dependencies?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect()
  useLayoutEffect()
  useCallback()
  useMemo()
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useLayoutEffect requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useCallback requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useMemo requires an effect callback. Did you forget to pass a callback to the hook?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    if (true) {
      print(local);
    }
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    try {
      print(local);
    } finally {}
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    inner() {
      print(local);
    }
    inner();
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, []);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local1\' and \'local2\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  {
    final local2 = someFunc();
    useEffect(() {
      print(local1);
      print(local2);
    }, [local1, local2]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1, local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useEffect(() {
    print(local1);
    print(local2);
  }, [local1, local2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1, local2]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'local2\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  final local2 = {};
  useMemo(() {
    print(local1);
  }, [local1]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local1]);
  }, null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local2\'. Either include it or remove the dependency array. Outer scope values like \'local1\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = someFunc();
  final MyNestedComponent = uiFunction<TestProps>((_) {
    final local2 = {};
    useCallback(() {
      print(local1);
      print(local2);
    }, [local2]);
  }, null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var local = props.foo;
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return history.listen();
  }, [history]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history.foo.bar[2].dobedo.listen(),
      history.foo.bar().dobedo.listen[2]
    ];
  }, [history.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'history?.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [history?.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var history = props.history;

  useEffect(() {
    return [
      history?.foo
    ];
  }, [history?.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {}, ['foo']);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, ['foo', 'bar']);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'foo\' literal is not a valid dependency because it never changes. Did you mean to include foo in the array instead?',
            'suggestions': null,
          },
          {
            'message':
                'The \'bar\' literal is not a valid dependency because it never changes. Did you mean to include bar in the array instead?',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [42, false, null]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar, baz, foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = props.foo;
  var bar = props.bar;
  var baz = props.baz;

  useEffect(() {
    print(foo, bar, baz);
  }, [bar, baz, foo]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The 42 literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The false literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          },
          {
            'message':
                'The null literal is not a valid dependency because it never changes. You can safely remove it.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final dependencies = [];
  useEffect(() {}, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, dependencies);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect was passed a dependency list that is not an array literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final dependencies = [local];
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = someFunc();
  useEffect(() {
    print(local);
  }, [local, ...dependencies]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a spread element in its dependency array. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [computeCacheKey(local)]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.items[0]);
  }, [props.items, props.items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'items\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [items]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var items = props.items;

  useEffect(() {
    print(items[0]);
  }, [items, items[0]]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useCallback(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, local.id]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  useEffect(() {
    print(local);
  }, [local, local.id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local.id, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local.id\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {id: 42};
  final fn = useCallback(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar.baz\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [props.foo, props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'color\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [color, props.foo.bar.baz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var color = {}
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(color);
  }, [color, props.foo.bar.baz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo.bar.baz, props.foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'props.foo.bar.baz\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has missing dependencies: \'props.foo.bar.baz\' and \'props.foo.fizz.bizz\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo.bar.baz, props.foo.fizz.bizz]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar.baz);
    print(props.foo.fizz.bizz);
  }, [props.foo.bar.baz, props.foo.fizz.bizz]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo.bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props.foo.bar);
  }, [props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props.foo.bar.baz]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final fn = useCallback(() {
    print(props);
    print(props.hello);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local, local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {
    final local1 = {};
    print(local1);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, [local1]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = {};
  useCallback(() {}, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
    print(props.bar);
  }, [props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [c, a, g, b, e, d, f]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [c, a, g, b, e, d, f]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, c, g]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'a\', \'b\', \'c\', \'d\', \'e\', \'f\', and \'g\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [a, b, c, d, e, f, g]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var a, b, c, d, e, f, g;
  useEffect(() {
    print(b, e, d, c, a, g, f);
  }, [a, b, c, d, e, f, g]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'local\', \'props.bar\', and \'props.foo\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local, props.bar, props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props.bar, props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [props]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final local = {};
  useEffect(() {
    print(props.foo);
    print(props.bar);
    print(local);
  }, [local, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, [props.foo]);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useMemo(() {
    print(props.foo);
  }, []);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    print(props.foo);
  }, []);
  useCallback(() {
    print(props.foo);
  }, []);
  useMemo(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCallback(() {
    print(props.foo);
  }, []);
  over_react.useMemo(() {
    print(props.foo);
  }, [props.foo]);
  over_react.notReactiveHook(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
        'options': [
          {
            'additionalHooks': 'useCustomEffect',
          }
        ],
        'errors': [
          {
            'message':
                'React Hook useCustomEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, [props.foo]);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useEffect(() {
    print(props.foo);
  }, []);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useCustomEffect(() {
    print(props.foo);
  }, []);
  useEffect(() {
    print(props.foo);
  }, []);
  over_react.useEffect(() {
    print(props.foo);
  }, [props.foo]);
  over_react.useCustomEffect(() {
    print(props.foo);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a ? local : b]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [a && local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props?.attribute.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {}, [props.method()]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a complex expression in the dependency array. Extract it to a separate variable so it can be statically checked.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref, state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  var state = useState();
  useEffect(() {
    ref.current = {};
    state.set(state.value + 1);
  }, [ref, state.value]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props.color\' and \'props.someOtherRefs\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.color, props.someOtherRefs]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.color, props.someOtherRefs]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1.current, ref2.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.focus();
    print(ref2.current.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [ref1?.current, ref2?.current, props.someOtherRefs, props.color]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.someOtherRefs, props.color]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1?.current?.focus();
    print(ref2?.current?.textContent);
    alert(props.someOtherRefs.current.innerHTML);
    fetch(props.color);
  }, [props.someOtherRefs, props.color]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [ref1.current, ref2.current, activeTab]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [activeTab]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;

  final ref1 = useRef();
  final ref2 = useRef();
  useEffect(() {
    ref1.current.scrollTop = 0;
    ref2.current.scrollTop = 0;
  }, [activeTab]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [ref1.current, ref2.current, activeTab, initY]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'activeTab\', \'ref1.current\', and \'ref2.current\'. Either exclude them or remove the dependency array. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [initY]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var activeTab = props.activeTab;
  var initY = props.initY;

  final ref1 = useRef();
  final ref2 = useRef();
  final fn = useCallback(() {
    ref1.current.scrollTop = initY;
    ref2.current.scrollTop = initY;
  }, [initY]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref.current, ref]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency array. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [ref]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef();
  useEffect(() {
    print(ref.current);
  }, [ref]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [])
});''',
        'errors': [
          {
            'message':
                'React Hook useImperativeHandle has a missing dependency: \'props.hello\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.hello]',
                'output': /*language=dart*/ r'''
final MyComponent = forwardRef((props, ref) {
  useImperativeHandle(ref, () => ({
    focus() {
      alert(props.hello);
    }
  }), [props.hello])
});''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.onChange) {
      props.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props?.onChange) {
      props?.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    play() {
      props.onPlay();
    }
    pause() {
      props.onPause();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props.foo]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props.foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    if (props.foo.onChange) {
      props.foo.onChange();
    }
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [skillsCount, props.isEditMode, props.toggleEditMode, props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [skillsCount, props.isEditMode, props.toggleEditMode, props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'props\' and \'skillsCount\'. Either include them or remove the dependency array. However, \'props\' will change when *any* prop changes, so the preferred fix is to destructure the \'props\' object outside of the useEffect call and refer to those specific props inside useEffect.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props, skillsCount]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  const [skillsCount] = useState();
  useEffect(() {
    if (skillsCount == 0 && !props.isEditMode) {
      props.toggleEditMode();
    }
  }, [props, skillsCount]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    externalCall(props);
    props.onChange();
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [props]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  useEffect(() {
    props.onChange();
    externalCall(props);
  }, [props]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var value4;
  var asyncValue;
  useEffect(() {
    if (value4) {
      value = {};
    }
    value2 = 100;
    value = 43;
    value4 = true;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value4\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var value;
  var value2;
  var value3;
  var asyncValue;
  useEffect(() {
    value = {};
    value2 = 100;
    value = 43;
    print(value2);
    print(value3);
    setTimeout(() {
      asyncValue = 100;
    });
  }, [value, value2, value3]);
}, null);''',
        'errors': [
          {
            'message':
                'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          },
          {
            'message':
                'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef?.current?.addEventListener('mousemove', handleMove);
    return () => myRef?.current?.removeEventListener('mousemove', handleMove);
  }, []);
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef) {
  useEffect(() {
    final handleMouse = () {};
    myRef.current.addEventListener('mousemove', handleMouse);
    myRef.current.addEventListener('mousein', handleMouse);
    return () {
      setTimeout(() {
        myRef.current.removeEventListener('mousemove', handleMouse);
        myRef.current.removeEventListener('mousein', handleMouse);
      });
    }
  }, [myRef]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
useMyThing(myRef, active) {
  useEffect(() {
    final handleMove = () {};
    if (active) {
      myRef.current.addEventListener('mousemove', handleMove);
      return () {
        setTimeout(() {
          myRef.current.removeEventListener('mousemove', handleMove);
        });
      }
    }
  }, [myRef, active]);
}''',
        'errors': [
          {
            'message':
                'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final myRef = useRef();
  useLayoutEffect_SAFE_FOR_SSR(() {
    final handleMove = () {};
    myRef.current.addEventListener('mousemove', handleMove);
    return () => myRef.current.removeEventListener('mousemove', handleMove);
  });
  return <div ref={myRef} />;
}, null);''',
        'errors': [
          'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.'
        ],
        'options': [
          {
            'additionalHooks': 'useLayoutEffect_SAFE_FOR_SSR',
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local4\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [local1, local3, local4]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local1 = 42;
  final local2 = '42';
  final local3 = null;
  final local4 = {};
  useEffect(() {
    print(local1);
    print(local2);
    print(local3);
    print(local4);
  }, [local1, local3, local4]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, [window]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency array. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    window.scrollTo(0, 0);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, [MutableStore.hello]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'MutableStore.hello\'. Either exclude it or remove the dependency array. Outer scope values like \'MutableStore.hello\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
final MyComponent = uiFunction<TestProps>((_) {
  useEffect(() {
    print(MutableStore.hello);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      print(MutableStore.hello.world, props.foo, x, y, z, global.stuff);
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.foo, x, y]',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    useEffect(() {
      // nothing
    }, [props.foo, x, y]);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, [MutableStore?.hello?.world, props.foo, x, y, z, global?.stuff]);
  }
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency array. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
import MutableStore from 'store';
var z = {};
final MyComponent = uiFunction<TestProps>((props) {
  var x = props.foo;
  {
    var y = props.bar;
    final fn = useCallback(() {
      // nothing
    }, []);
  }
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    setTimeout(() => print(taint));
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  handleChange() {}
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext1]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext2]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, []);
}, null);''',
              }
            ],
          },
          {
            'message':
                'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [handleNext3]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var dispatch = over_react.useReducer();
  var taint = props.foo;
  // Shouldn't affect anything
  final handleChange = () {};
  handleNext1(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  final handleNext2 = (value) {
    state.set(taint(value));
    print('hello');
  };
  var handleNext3 = (value) {
    print(taint);
    dispatch.set({ type: 'x', value });
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, []);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, []);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  handleNext(value) {
    state.set(value);
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = (value) {
    state.set(value);
  };
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  final handleNext = useCallback((value) {
    state.set(value);
  });
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
  return <div onClick={handleNext} />;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    return Store.subscribe(handleNext1);
  }, [handleNext1]);
  useLayoutEffect(() {
    return Store.subscribe(handleNext2);
  }, [handleNext2]);
  useMemo(() {
    return Store.subscribe(handleNext3);
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 17) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 20) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 15) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 19) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = useCallback(() {
    print('hello');
  });
  var handleNext3 = () {
    print('hello');
  };
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 23) change on every render. To fix this, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  handleNext1() {
    print('hello');
  }
  final handleNext2 = () {
    print('hello');
  };
  var handleNext3 = useCallback(() {
    print('hello');
  });
  useEffect(() {
    handleNext1();
    return Store.subscribe(() => handleNext1());
  }, [handleNext1]);
  useLayoutEffect(() {
    handleNext2();
    return Store.subscribe(() => handleNext2());
  }, [handleNext2]);
  useMemo(() {
    handleNext3();
    return Store.subscribe(() => handleNext3());
  }, [handleNext3]);
  return (
    <div
      onClick={() {
        handleNext1();
        setTimeout(handleNext2);
        setTimeout(() {
          handleNext3();
        });
      }}
    />
  );
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = () {
    print('hello');
  };
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  final handleNext1 = useCallback(() {
    print('hello');
  });
  handleNext2() {
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
  useEffect(() {
    return Store.subscribe(handleNext1);
    return Store.subscribe(handleNext2);
  }, [handleNext1, handleNext2]);
}, null);''',
              }
            ],
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = () {
    print('hello');
  };
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 13) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': [
              {
                'desc':
                    'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var handleNext = useCallback(() {
    print('hello');
  });
  if (props.foo) {
    handleNext = () {
      print('hello');
    };
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var state = useState();
  var taint = props.foo;
  handleNext(value) {
    var value2 = value * taint;
    state.set(value2);
    print('hello');
  }
  useEffect(() {
    return Store.subscribe(handleNext);
  }, [handleNext]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [count]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + 1);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'count\' and \'increment\'. Either include them or remove the dependency array. You can also do a functional update \'setCount(c => ...)\' if you only need \'count\' in the \'setCount\' call.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [count, increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set(count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [count.value, increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. You can also replace multiple useState variables with useReducer if \'setCount\' needs the current value of \'increment\'.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment.value);
    }, 1000);
    return () => clearInterval(id);
  }, [increment.value]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  var increment = useCustomHook();
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var step = props.step;

  var count = useState(0);
  increment(x) {
    return x + step;
  }
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => increment(count.value));
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'The \'increment\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'increment\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency array. If \'setCount\' needs the current value of \'increment\', you can also switch to useReducer instead of useState and read \'increment\' in the reducer.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [increment]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((props) {
  var increment = props.increment;

  var count = useState(0);
  useEffect(() {
    var id = setInterval(() {
      count.set((count.value) => count.value + increment);
    }, 1000);
    return () => clearInterval(id);
  }, [increment]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>{count.value}</h1>;
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'tick\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [tick]',
                'output': /*language=dart*/ r'''
final Counter = uiFunction<TestProps>((_) {
  var count = useState(0);
  tick() {
    count.set(count.value + 1);
  }
  useEffect(() {
    var id = setInterval(() {
      tick();
    }, 1000);
    return () => clearInterval(id);
  }, [tick]);
  return <h1>{count.value}</h1>;
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, []);
  var podcasts = useState(null);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'podcasts\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [podcasts]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((_) {
  useEffect(() {
    alert(podcasts.value);
  }, [podcasts.value]);
  var podcasts = useState(null);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>(({ api: { fetchPodcasts }, id }) {
  var podcasts = useState(null);
  useEffect(() {
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'fetchPodcasts\' and \'fetchPodcasts2\'. Either include them or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, fetchPodcasts2, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var fetchPodcasts2 = props.fetchPodcasts2;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    setTimeout(() {
      print(id);
      fetchPodcasts(id).then(podcasts.set);
      fetchPodcasts2(id).then(podcasts.set);
    });
  }, [fetchPodcasts, fetchPodcasts2, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [id]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency array. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [fetchPodcasts, id]',
                'output': /*language=dart*/ r'''
final Podcasts = uiFunction<TestProps>((props) {
  var fetchPodcasts = props.fetchPodcasts;
  var id = props.id;

  var podcasts = useState(null);
  useEffect(() {
    print(fetchPodcasts);
    fetchPodcasts?.(id).then(podcasts.set);
  }, [fetchPodcasts, id]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, [fetchData]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has an unnecessary dependency: \'fetchData\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() {
    final fetchData = () async {};
    fetchData();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var state = useState(0);
  useEffect(() {
    state.set({});
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: []',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((_) {
  var data = useState(0);
  useEffect(() {
    fetchData.then(data.set);
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setData\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [country] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [country]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var country = props.country;

  var data = useState(0);
  useEffect(() {
    fetchData(country).then(data.set);
  }, [country]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  });
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect contains a call to \'setState\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [prop1, prop2] as a second argument to the useEffect Hook.',
            'suggestions': [
              {
                'desc': 'Add dependencies array: [prop1, prop2]',
                'output': /*language=dart*/ r'''
final Hello = uiFunction<TestProps>((props) {
  var prop1 = props.prop1;
  var prop2 = props.prop2;

  var state = useState(0);
  useEffect(() {
    if (prop1) {
      state.set(prop2);
    }
  }, [prop1, prop2]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {}, []);
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Thing = uiFunction<TestProps>((_) {
  useEffect(() async {});
}, null);''',
        'errors': [
          {
            'message': /*language=dart*/ r'''
Effect callbacks are synchronous to prevent race conditions. Put the async function inside:

useEffect(() => {
  async function fetchData() {
    // You can await here
    const response = await MyAPI.getData(someId);
    // ...
  }
  fetchData();
}, [someId]); // Or [] if effect doesn't need props or state

Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching''',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has an unnecessary dependency: \'foo\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((_) {
  final foo = useCallback(() {
    foo();
  }, []);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [foo]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useCallback has a missing dependency: \'prop\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [prop]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final foo = useCallback(() {
    prop.hello(foo);
  }, [prop]);
  final bar = useCallback(() {
    foo();
  }, [foo]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  myEffect() {
    print(local);
  }
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = () {
    print(local);
  };
  useEffect(myEffect, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'otherThing\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [otherThing]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final otherThing = () {
    print(local);
  };
  final myEffect = () {
    otherThing();
  };
  useEffect(myEffect, [otherThing]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  final myEffect = debounce(() {
    print(local);
  }, delay);
  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [myEffect]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var myEffect = props.myEffect;

  useEffect(myEffect, [myEffect]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(debounce(() {
    print(local);
  }, delay), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect received a function whose dependencies are unknown. Pass an inline function instead.',
            'suggestions': [],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {};
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
          }
        ],
        'options': [
          {
            'enableDangerousAutofixThisMayCauseInfiniteLoops': true,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'foo.bar\' and \'props.foo.bar\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [foo.bar, props.foo.bar]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((props) {
  var foo = {}
  useEffect(() {
    foo.bar.baz = 43;
    props.foo.bar.baz = 1;
  }, [foo.bar, props.foo.bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = [];
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' array makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = () {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar(){};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' function makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'foo\' in its own useCallback() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = class {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' class makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = true ? {} : "fine";
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar || {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ?? {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar && {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = bar ? baz ? {} : null : null;
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  var foo = {};
  useMemo(() => foo, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useCallback(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useCallback Hook (at line 6) change on every render. Move it inside the useCallback callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Component = uiFunction<TestProps>((_) {
  final foo = {};
  useImperativeHandle(
    ref,
    () {
       print(foo);
    },
    [foo]
  );
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useImperativeHandle Hook (at line 9) change on every render. Move it inside the useImperativeHandle callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = section.section_components?.edges ?? [];
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' logical expression could make the dependencies of useEffect Hook (at line 6) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((section) {
  final foo = {};
  print(foo);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 7) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <>Hi!</>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX fragment makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = <div>Hi!</div>;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' JSX element makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = bar = {};
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' assignment expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new String('foo'); // Note 'foo' will be boxed, and thus an object and thus compared by reference.
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = new Map([]);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object construction makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = /reg/;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' regular expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  class Bar {};
  useMemo(() {
    print(new Bar());
  }, [Bar]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'Bar\' class makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'Bar\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {};
  useLayoutEffect(() {
    print(foo);
  }, [foo]);
  useEffect(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useLayoutEffect Hook (at line 6) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          },
          {
            'message':
                'The \'foo\' object makes the dependencies of useEffect Hook (at line 9) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsFlow': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  var prop = props.prop;

  final bar = useEffect(<T>(a: T): (Hello) {
    prop();
  }, [prop]);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = ({}: any);
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescript': {
    'valid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final ref = useRef() as over_react.MutableRefObject<HTMLDivElement>;
  useEffect(() {
    print(ref.current);
  }, []);
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber);
  }, [])
}, null);''',
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  over_react.useEffect(() {
    final bar = {x: 2};
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
      }
    ],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [local]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final local = {} as string;
  useEffect(() {
    print(local);
  }, [local]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'bar\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [bar]',
                'output': /*language=dart*/ r'''
final App = uiFunction<TestProps>((_) {
  final foo = {x: 1};
  final bar = {x: 2};
  useEffect(() {
    final baz = bar as typeof foo;
    print(baz);
  }, [bar]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has missing dependencies: \'pizza.crust\' and \'pizza?.toppings\'. Either include them or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [pizza.crust, pizza?.toppings]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    toppings: pizza?.toppings,
  }), [pizza.crust, pizza?.toppings]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza.crust,
    density: pizza?.crust.density,
  }), [pizza.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'pizza?.crust\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [pizza?.crust]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  final pizza = {};
  useEffect(() => ({
    crust: pizza?.crust,
    density: pizza?.crust.density,
  }), [pizza?.crust]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props.upperViewHeight;
  }, [props.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, []);
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'props?.upperViewHeight\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc':
                    'Update the dependencies array to be: [props?.upperViewHeight]',
                'output': /*language=dart*/ r'''
final Example = uiFunction<TestProps>((props) {
  useEffect(() {
    var topHeight = 0;
    topHeight = props?.upperViewHeight;
  }, [props?.upperViewHeight]);
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useEffect has a missing dependency: \'state\'. Either include it or remove the dependency array. You can also do a functional update \'setState(s => ...)\' if you only need \'state\' in the \'setState\' call.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [state]',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useEffect(() {
    final someNumber: typeof state.value = 2;
    state.set((prevState) => prevState + someNumber + state.value);
  }, [state.value])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [state.value])
}, null);''',
        'errors': [
          {
            'message':
                'React Hook useMemo has an unnecessary dependency: \'state\'. Either exclude it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: []',
                'output': /*language=dart*/ r'''
final MyComponent = uiFunction<TestProps>((_) {
  var state = over_react.useState<number>(0);
  useMemo(() {
    final someNumber: typeof state.value = 2;
    print(someNumber);
  }, [])
}, null);''',
              }
            ],
          }
        ],
      },
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((_) {
  final foo = {} as any;
  useMemo(() {
    print(foo);
  }, [foo]);
}, null);''',
        'errors': [
          {
            'message':
                'The \'foo\' object makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
            'suggestions': null,
          }
        ],
      }
    ],
  },
  'testsTypescriptEslintParserV4': {
    'valid': [],
    'invalid': [
      {
        'code': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, []);
}, null);;''',
        'errors': [
          {
            'message':
                'React Hook React.useEffect has a missing dependency: \'Component\'. Either include it or remove the dependency array.',
            'suggestions': [
              {
                'desc': 'Update the dependencies array to be: [Component]',
                'output': /*language=dart*/ r'''
final Foo = uiFunction<TestProps>((props) {
  var Component = props.Component;

  over_react.useEffect(() {
    print(<Component />);
  }, [Component]);
}, null);;''',
              }
            ],
          }
        ],
      }
    ],
  },
};
