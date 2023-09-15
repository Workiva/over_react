// Adapted from https://github.com/facebook/react/blob/cae635054e17a6f107a39d328649137b83f25972/packages/eslint-plugin-react-hooks/__tests__/ESLintRuleExhaustiveDeps-test.js
//
// MIT License
//
// Copyright (c) Facebook, Inc. and its affiliates.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// ignore_for_file: implicit_dynamic_map_literal, implicit_dynamic_list_literal

/// Tests that are valid/invalid across all parsers
final Map<String, List<Map<String, Object>>> tests = {
  'valid': [
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            print(local);
          });
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {
            final local = {};
            print(local);
          }, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          useEffect(() {
            print(local);
          }, [local]);
        }, null);
      ''',
    },
    {
      // OK because '''props''' wasn't defined.
      // We don't technically know if '''props''' is supposed
      // to be an import that hasn't been added yet, or
      // a component-level variable. Ignore it until it
      //  gets defined (a different rule would flag it anyway).
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {
            // ignore: undefined_identifier
            print(props.foo);
          }, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = {};
          {
            final local2 = {};
            useEffect(() {
              print(local1);
              print(local2);
            });
          }
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = someFunc();
          {
            final local2 = someFunc();
            useCallback(() {
              print(local1);
              print(local2);
            }, [local1, local2]);
          }
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = someFunc();
          final MyNestedComponent = uiFunction<TestProps>((_) {
            final local2 = someFunc();
            useCallback(() {
              print(local1);
              print(local2);
            }, [local2]);
          }, null);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          useEffect(() {
            print(local);
            print(local);
          }, [local]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {
            print(unresolved);
          }, []);
        }, null);
      ''',
    },
    /* (1 case previously here involving holes in arrays (e.g., `[,,'value']`) was removed, since there is no equivalent in Dart) */
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var foo = props.foo;

          useEffect(() {
            print(foo.length);
          }, [foo]);
        }, null);
      ''',
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var foo = props.foo;

          useEffect(() {
            print(foo.length);
            print(foo.slice(0));
          }, [foo]);
        }, null);
      ''',
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var history = props.history;

          useEffect(() {
            return history.listen();
          }, [history]);
        }, null);
      ''',
    },
    {
      // Valid because they have meaning without deps.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {});
          useLayoutEffect(() {});
          useImperativeHandle(props.innerRef, () {});
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
            print(props.bar);
          }, [props.bar, props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
            print(props.bar);
          }, [props.foo, props.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = someFunc();
          useEffect(() {
            print(props.foo);
            print(props.bar);
            print(local);
          }, [props.foo, props.bar, local]);
        }, null);
      ''',
    },
    {
      // [props, props.foo] is technically unnecessary ('props' covers 'props.foo').
      // However, it's valid for effects to over-specify their deps.
      // So we don't warn about this. We *would* warn about useMemo/useCallback.
      'code': r'''
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
        }, null);
      ''',
    },
    // Nullish coalescing and optional chaining
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo?.bar?.baz ?? null);
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo?.bar);
          }, [props.foo?.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo?.bar);
          }, [props.foo.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo.bar);
          }, [props.foo?.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo.bar);
            print(props.foo?.bar);
          }, [props.foo?.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo.bar);
            print(props.foo?.bar);
          }, [props.foo.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
            print(props.foo?.bar);
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo?.toString());
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useMemo(() {
            print(props.foo?.toString());
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.toString());
          }, [props.foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo.bar?.toString());
          }, [props.foo.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.bar?.toString());
          }, [props.foo.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo.bar.toString());
          }, [props?.foo?.bar]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.bar?.baz);
          }, [props?.foo.bar?.baz]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myEffect = () {
            // Doesn't use anything
          };
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final local = {};
        final MyComponent = uiFunction<TestProps>((_) {
          final myEffect = () {
            print(local);
          };
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final local = {};
        final MyComponent = uiFunction<TestProps>((_) {
          myEffect() {
            print(local);
          }
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          myEffect() {
            print(local);
          }
          useEffect(myEffect, [local]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          myEffect() {
            print(global);
          }
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final local = {};
        final MyComponent = uiFunction<TestProps>((_) {
          final otherThing = () {
            print(local);
          };
          final myEffect = () {
            otherThing();
          };
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      // Valid because even though we don't inspect the function itself,
      // at least it's passed as a dependency.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var delay = props.delay;

          final local = {};
          final myEffect = debounce(() {
            print(local);
          }, delay);
          useEffect(myEffect, [myEffect]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var myEffect = props.myEffect;

          useEffect(myEffect, [null, myEffect]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var myEffect = props.myEffect;

          useEffect(myEffect, [null, myEffect, null, null]);
        }, null);
      ''',
    },
    {
      'code': r'''
        var local = {};
        myEffect() {
          print(local);
        }
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(myEffect, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var myEffect = props.myEffect;

          useEffect(myEffect, [myEffect]);
        }, null);
      ''',
    },
    {
      // Valid because has no deps.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var myEffect = props.myEffect;

          useEffect(myEffect);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCustomEffect(() {
            print(props.foo);
          });
        }, null);
      ''',
      'options': [
        {'additionalHooks': 'useCustomEffect'}
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCustomEffect(() {
            print(props.foo);
          }, [props.foo]);
        }, null);
      ''',
      'options': [
        {'additionalHooks': 'useCustomEffect'}
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCustomEffect(() {
            print(props.foo);
          }, []);
        }, null);
      ''',
      'options': [
        {'additionalHooks': 'useAnotherEffect'}
      ],
    },
    {
      'code': r'''
        void useWithoutEffectSuffix(Function callback, [List dependencies]) {}
        final MyComponent = uiFunction<TestProps>((props) {
          useWithoutEffectSuffix(() {
            print(props.foo);
          }, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        dynamic renderHelperConfusedWithEffect(Function callback, dynamic secondArg) => null;
        final MyComponent = uiFunction<TestProps>((props) {
          return renderHelperConfusedWithEffect(() {
            print(props.foo);
          }, []);
        }, null);
      ''',
    },
    {
      // Valid because we don't care about hooks outside of components.
      'code': r'''
        nonHookFunction() {
          final local = {};
          // ignore: over_react_rules_of_hooks
          useEffect(() {
            print(local);
          }, []);
        }
      ''',
    },
    {
      // Valid because we don't care about hooks outside of components.
      'code': r'''
        nonHookFunction() {
          final local1 = {};
          {
            final local2 = {};
            // ignore: over_react_rules_of_hooks
            useEffect(() {
              print(local1);
              print(local2);
            }, []);
          }
        }
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          useEffect(() {
            print(ref.current);
          }, [ref]);
        }, null);
      ''',
    },
    {
      'name': 'Ref from useRef',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          useEffect(() {
            print(ref.current);
          }, []);
        }, null);
      ''',
    },
    {
      'name': 'Ref from useRef (namespaced)',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = over_react.useRef();
          useEffect(() {
            print(ref.current);
          }, []);
        }, null);
      ''',
    },
    {
      'code': r'''
        StateHook<T> useFunnyState<T>(T initialState) => useState(initialState);
        ReducerHook<T, dynamic, dynamic> useFunnyReducer<T>(dynamic reducer, T initialState) => useReducer(reducer, initialState);
        dynamic useSomeOtherRefyThing() => null;
        final MyComponent = uiFunction<TestProps>((props) {
          var maybeRef2 = props.maybeRef2;
          var foo = props.foo;

          final definitelyRef1 = useRef();
          final definitelyRef2 = useRef();
          final maybeRef1 = useSomeOtherRefyThing();
          var state1 = useState<dynamic>(null);
          var state2 = over_react.useState<dynamic>(null);
          var state3 = useReducer(null, null);
          var state4 = over_react.useReducer(null, null);
          var state5 = useFunnyState(null);
          var state6 = useFunnyReducer(null, null);
          // TODO uncomment once useTransition is implemented.
          // const [isPending1] = useTransition();
          // var isPending2 = useTransition();
          // const [isPending3] = over_react.useTransition();
          // var isPending4 = over_react.useTransition();
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
            state3.dispatch(null);
            state4.dispatch(null);
            // startTransition1();
            // isPending2.set(null);
            // startTransition3();
            // isPending4.set(null);
            // Dynamic
            print(state1.value);
            print(state2.value);
            print(state3.state);
            print(state4.state);
            print(state5.value);
            print(state6.state);
            // print(isPending2.value);
            // print(isPending4.value);
            mySetState();
            myDispatch();
            // Not sure; assume dynamic
            state5.set(null);
            state6.dispatch(null);
          }, [
            // Dynamic
            state1.value, state2.value, state3.state, state4.state, state5.value, state6.state,
            maybeRef1, maybeRef2,
            // isPending2.value, isPending4.value,
            // Not sure; assume dynamic
            mySetState, myDispatch,
            state5.set, state6.dispatch
            // In this test, we don't specify static deps.
            // That should be okay.
          ]);
        }, null);
      ''',
    },
    {
      'code': r'''
        StateHook<T> useFunnyState<T>(T initialState) => useState(initialState);
        ReducerHook<T, dynamic, dynamic> useFunnyReducer<T>(dynamic reducer, T initialState) => useReducer(reducer, initialState);
        dynamic useSomeOtherRefyThing() => null;
        final MyComponent = uiFunction<TestProps>((props) {
          var maybeRef2 = props.maybeRef2;

          final definitelyRef1 = useRef();
          final definitelyRef2 = useRef();
          final maybeRef1 = useSomeOtherRefyThing();
          var state1 = useState<dynamic>(null);
          var state2 = over_react.useState<dynamic>(null);
          var state3 = useReducer(null, null);
          var state4 = over_react.useReducer(null, null);
          var state5 = useFunnyState(null);
          var state6 = useFunnyReducer(null, null);
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
            state3.dispatch(null);
            state4.dispatch(null);
            // Dynamic
            print(state1.value);
            print(state2.value);
            print(state3.state);
            print(state4.state);
            print(state5.value);
            print(state6.state);
            mySetState();
            myDispatch();
            // Not sure; assume dynamic
            state5.set(null);
            state6.dispatch(null);
          }, [
            // Dynamic
            state1.value, state2.value, state3.state, state4.state, state5.value, state6.state,
            maybeRef1, maybeRef2,
            // Not sure; assume dynamic
            mySetState, myDispatch,
            state5.set, state6.dispatch,
            // In this test, we specify static deps.
            // That should be okay too!
            definitelyRef1, definitelyRef2, state1.set, state2.set, state3.dispatch, state4.dispatch
          ]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiForwardRef<TestProps>((props, ref) {
          useImperativeHandle(ref, () => ({
            'focus': () {
              window.alert(props.hello);
            }
          }));
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiForwardRef<TestProps>((props, ref) {
          useImperativeHandle(ref, () => ({
            'focus': () {
              window.alert(props.hello);
            }
          }), [props.hello]);
        }, null);
      ''',
    },
    {
      // This is not ideal but warning would likely create
      // too many false positives. We do, however, prevent
      // direct assignments.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var obj = someFunc();
          useEffect(() {
            obj.foo = true;
          }, [obj]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          dynamic foo;
          useEffect(() {
            foo.bar.baz = 43;
          }, [foo.bar]);
        }, null);
      ''',
    },
    {
      // Valid because we assign ref.current
      // ourselves. Therefore it's likely not
      // a ref managed by React.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            myRef.current = {};
            return () {
              print(myRef.current.toString());
            };
          }, []);
          return Dom.div()();
        }, null);
      ''',
    },
    {
      // Valid because we assign ref.current
      // ourselves. Therefore it's likely not
      // a ref managed by React.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            myRef.current = {};
            return () {
              print(myRef?.current?.toString());
            };
          }, []);
          return Dom.div()();
        }, null);
      ''',
    },
    {
      // Valid because we assign ref.current
      // ourselves. Therefore it's likely not
      // a ref managed by React.
      'code': r'''
        useMyThing(myRef) {
          useEffect(() {
            final handleMove = () {};
            myRef.current = {};
            return () {
              print(myRef.current.toString());
            };
          }, [myRef]);
        }
      ''',
    },
    {
      // Valid because the ref is captured.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            final node = myRef.current;
            node.addEventListener('mousemove', handleMove);
            return () => node.removeEventListener('mousemove', handleMove);
          }, []);
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
    },
    {
      // Valid because the ref is captured.
      'code': r'''
        useMyThing(myRef) {
          useEffect(() {
            final handleMove = () {};
            final node = myRef.current;
            node.addEventListener('mousemove', handleMove);
            return () => node.removeEventListener('mousemove', handleMove);
          }, [myRef]);
          return (Dom.div()..ref = myRef)();
        }
      ''',
    },
    {
      // Valid because it's not an effect.
      'code': r'''
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
            };
          }, [myRef]);
        }
      ''',
    },
    {
      // Valid because we read ref.current in a function that isn't cleanup.
      'code': r'''
        useMyThing() {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {
              print(myRef.current);
            };
            window.addEventListener('mousemove', handleMove);
            return () => window.removeEventListener('mousemove', handleMove);
          }, []);
          return (Dom.div()..ref = myRef)();
        }
      ''',
    },
    {
      // Valid because we read ref.current in a function that isn't cleanup.
      'code': r'''
        useMyThing() {
          final myRef = useRef();
          useEffect(() {
            Function handleMove;
            handleMove = () {
              return () => window.removeEventListener('mousemove', handleMove);
            };
            window.addEventListener('mousemove', handleMove);
            return () {};
          }, []);
          return (Dom.div()..ref = myRef)();
        }
      ''',
    },
    {
      // Valid because it's a primitive constant.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = 42;
          final local2 = '42';
          final local3 = null;
          useEffect(() {
            print(local1);
            print(local2);
            print(local3);
          }, []);
        }, null);
      ''',
    },
    {
      // It's not a mistake to specify constant values though.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = 42;
          final local2 = '42';
          final local3 = null;
          useEffect(() {
            print(local1);
            print(local2);
            print(local3);
          }, [local1, local2, local3]);
        }, null);
      ''',
    },
    {
      // It is valid for effects to over-specify their deps.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = props.local;
          useEffect(() {}, [local]);
        }, null);
      ''',
    },
    {
      // Valid even though activeTab is "unused".
      // We allow over-specifying deps for effects, but not callbacks or memo.
      'code': r'''
        final Foo = uiFunction<TestProps>((props) {
          var activeTab = props.activeTab;

          useEffect(() {
            window.scrollTo(0, 0);
          }, [activeTab]);
        }, null);
      ''',
    },
    {
      // It is valid to specify broader effect deps than strictly necessary.
      // Don't warn for this.
      'code': r'''
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
        }, null);
      ''',
    },
    {
      // It is *also* valid to specify broader memo/callback deps than strictly necessary.
      // Don't warn for this either.
      'code': r'''
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
        }, null);
      ''',
    },
    {
      // Declaring handleNext is optional because
      // it doesn't use anything in the function scope.
      'code': r'''
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
        }, null);
      ''',
    },
    {
      // Declaring handleNext is optional because
      // it doesn't use anything in the function scope.
      'code': r'''
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
        }, null);
      ''',
    },
    {
      // Declaring handleNext is optional because
      // everything they use is fully static.
      'code': r'''
        Function foo;
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          var dispatch = over_react.useReducer(null, null).dispatch;
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
            dispatch({ 'type': 'x', 'value': value });
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
        }, null);
      ''',
    },
    {
      'code': r'''
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
        }
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((c) => c + 1);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          tick() {
            count.setWithUpdater((c) => c + 1);
          }
          useEffect(() {
            var id = setInterval(() {
              tick();
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useReducer((state, action) {
            if (action == 'inc') {
              return state + 1;
            }
          }, 0);
          useEffect(() {
            var id = setInterval(() {
              count.dispatch('inc');
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.state);
        }, null);
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useReducer((state, action) {
            if (action == 'inc') {
              return state + 1;
            }
          }, 0);
          final tick = () {
            count.dispatch('inc');
          };
          useEffect(() {
            var id = setInterval(tick, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.state);
        }, null);
      ''',
    },
    /* ("Regression test for a crash" previously here was removed since the original cause of the crash is not applicable
        in the Dart logic, and the test case involving variables declared after they're referenced is not valid in Dart.) */
    {
      'code': r'''
        withFetch(fetchPodcasts) {
          return uiFunction((props) {
            final id = props.id;
            var podcasts = useState<dynamic>(null);
            useEffect(() {
              fetchPodcasts(id).then(podcasts.set);
            }, [id]);
          }, null);
        }
      ''',
    },
    {
      'code': r'''
        abstract class API {
          static dynamic fetchPodcasts() => null;
        }
        final Podcasts = uiFunction<TestProps>((props) {
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            doFetch({ fetchPodcasts }) {
              fetchPodcasts(id).then(podcasts.set);
            }
            doFetch(fetchPodcasts: API.fetchPodcasts);
          }, [id]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          int increment(int x) {
            return x + 1;
          }
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater(increment);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          int increment(int x) {
            return x + 1;
          }
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => increment(value));
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
    },
    {
      'code': r'''
        var globalIncrementValue;
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => value + globalIncrementValue);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
    },
    {
      'code': r'''
        withStuff(increment) {
          return uiFunction((_) {
            var count = useState(0);
            useEffect(() {
              var id = setInterval(() {
                count.setWithUpdater((value) => value + increment);
              }, 1000);
              return () => clearInterval(id);
            }, []);
            return Dom.h1()(count.value);
          }, null);
        }
      ''',
    },
    {
      'code': r'''
        final App = uiFunction<TestProps>((_) {
          var query = useState('react');
          var state = useState<dynamic>(null);
          useEffect(() {
            var ignore = false;
            fetchSomething() async {
              final result = await (await fetch('http://hn.algolia.com/api/v1/search?query.value=' + query.value)).json();
              if (!ignore) state.set(result);
            }
            fetchSomething();
            return () { ignore = true; };
          }, [query.value]);
          return (
            Fragment()(
              (Dom.input()..value = query.value ..onChange=(e) => query.set(e.target.value))(),
              jsonEncode(state.value)
            )
          );
        }, null);
      ''',
    },
    /* (2 cases previously here involving referencing functions inside their declarations were removed, since that's not valid in Dart) */
    {
      'code': r'''
        final Hello = uiFunction<TestProps>((_) {
          var state = useState(0);
          useEffect(() {
            final handleResize = () => state.set(window.innerWidth);
            window.addEventListener('resize', handleResize);
            return () => window.removeEventListener('resize', handleResize);
          });
        }, null);
      ''',
    },
    /* (2 cases previously here involving `arguments` keyword were removed) */
    // Regression test.
    {
      'code': r'''
        final Example = uiFunction<TestProps>((props) {
          useEffect(() {
            var topHeight = 0;
            topHeight = props.upperViewHeight;
          }, [props.upperViewHeight]);
        }, null);
      ''',
    },
    // Regression test.
    {
      'code': r'''
        final Example = uiFunction<TestProps>((props) {
          useEffect(() {
            var topHeight = 0;
            topHeight = props?.upperViewHeight;
          }, [props?.upperViewHeight]);
        }, null);
      ''',
    },
    // Regression test.
    {
      'code': r'''
        final Example = uiFunction<TestProps>((props) {
          useEffect(() {
            var topHeight = 0;
            topHeight = props?.upperViewHeight;
          }, [props]);
        }, null);
      ''',
    },
    {
      'code': r'''
        useFoo(foo){
          return useMemo(() => foo, [foo]);
        }
      ''',
    },
    {
      'code': r'''
        useFoo(){
          final foo = "hi!";
          return useMemo(() => foo, [foo]);
        }
      ''',
    },
    /* (Cases previously here involving destructuring keyword were removed) */
    {
      'code': r'''
        useFoo() {
          final foo = "fine";
          if (true) {
            // Shadowed variable with constant construction in a nested scope is fine.
            dynamic foo;
          }
          return useMemo(() => foo, [foo]);
        }
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var foo = props.foo;

          return useMemo(() => foo, [foo]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final foo = props.isEditMode ? "fine" : "also fine";
          return useMemo(() => foo, [foo]);
        }, null);
      ''',
    },
    // This previously-invalid test case is valid for the Dart implementation.
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final skillsCount = useState<dynamic>(null);
          useEffect(() {
            if (skillsCount.value == 0 && !props.isEditMode) {
              props.toggleEditMode();
            }
          }, [skillsCount.value, props.isEditMode, props.toggleEditMode]);
        }, null);
      ''',
    },
    {
      'name': 'Calling function props in a cascade with props as dependency',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props
              ..onClick(null)
              ..onChange(null);
          }, [props]);
        }, null);
      ''',
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final _button = useMemo(() => Dom.button()('Click me'), []);
          final _controls = useMemo(() {
            return Dom.div()(_button);
          }, [_button]);
        }, null);
      '''
    },
    {
      'name': 'Generic type parameter referenced inside callback from outer scope',
      'code': r'''
        UiFactory createComponent<T>() {
          return uiFunction<TestProps>((_) {
            useEffect(() {
              final items = <T>[];
            }, []);
          }, null);
        }
      ''',
    },
    {
      'name': 'Dependency with cascade in initializer',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final items = props.items..forEach((_) {});
          useEffect(() {
            print(items);
          }, [items]);
        }, null);
      ''',
    },
    {
      'name': 'Cascade on dependency inside callback',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final items = props.items;
          useEffect(() {
            print(items..forEach((_) {}));
          }, [items]);
        }, null);
      ''',
    },
    {
      'name': 'Cascaded assignment on dependency inside callback',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final object = useMemo(() => ObjectWithWritableField(), []);
          useEffect(() {
            object..field = 'something';
          }, [object]);
        }, null);
      ''',
    },
  ],
  'invalid': [
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.toString());
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCallback(() {
                    print(props.foo?.toString());
                  }, [props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.bar.baz);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo?.bar.baz\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo?.bar.baz]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCallback(() {
                    print(props.foo?.bar.baz);
                  }, [props.foo?.bar.baz]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.bar?.baz);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo?.bar?.baz\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo?.bar?.baz]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCallback(() {
                    print(props.foo?.bar?.baz);
                  }, [props.foo?.bar?.baz]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCallback(() {
            print(props.foo?.bar.toString());
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo?.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo?.bar]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCallback(() {
                    print(props.foo?.bar.toString());
                  }, [props.foo?.bar]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          useEffect(() {
            print(local);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = someFunc();
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Note: we *could* detect it's a primitive and never assigned
      // even though it's not a constant -- but we currently don't.
      // So this is an error.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          var local = 42;
          useEffect(() {
            print(local);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  var local = 42;
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* (1 cases previously here involving regex literals was removed) */
    {
      // Invalid because they don't have a meaning without deps.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final value = useMemo(() { return 2*2; });
          // In JS, dependencies are optional for both functions. In Dart, they're required for only useCallback (this is likely an oversight).
          // ignore: not_enough_positional_arguments
          final fn = useCallback(() { window.alert('foo'); });
        }, null);
      ''',
      // We don't know what you meant.
      'errors': [
        {
          'message':
              'React Hook useMemo does nothing when called with only one argument. Did you forget to pass a list of dependencies?',
          'suggestions': null,
        },
        {
          'message':
              'React Hook useCallback does nothing when called with only one argument. Did you forget to pass a list of dependencies?',
          'suggestions': null,
        },
      ],
    },
    {
      // Invalid because they don't have a meaning without deps.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var fn1 = props.fn1;
          var fn2 = props.fn2;

          final value = useMemo(fn1);
          // In JS, dependencies are optional for both functions. In Dart, they're required for only useCallback (this is likely an oversight).
          // ignore: not_enough_positional_arguments
          final fn = useCallback(fn2);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useMemo does nothing when called with only one argument. Did you forget to pass a list of dependencies?',
          'suggestions': null,
        },
        {
          'message':
              'React Hook useCallback does nothing when called with only one argument. Did you forget to pass a list of dependencies?',
          'suggestions': null,
        },
      ],
    },
    /* (Cases previously here involving missing effect callback arguments were removed) */
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          useEffect(() {
            if (true) {
              print(local);
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = someFunc();
                  useEffect(() {
                    if (true) {
                      print(local);
                    }
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            try {
              print(local);
            } finally {}
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    try {
                      print(local);
                    } finally {}
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            inner() {
              print(local);
            }
            inner();
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    inner() {
                      print(local);
                    }
                    inner();
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = someFunc();
          {
            final local2 = someFunc();
            useEffect(() {
              print(local1);
              print(local2);
            }, []);
          }
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'local1\' and \'local2\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local1, local2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = someFunc();
                  {
                    final local2 = someFunc();
                    useEffect(() {
                      print(local1);
                      print(local2);
                    }, [local1, local2]);
                  }
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = {};
          final local2 = {};
          useEffect(() {
            print(local1);
            print(local2);
          }, [local1]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local2\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local1, local2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = {};
                  final local2 = {};
                  useEffect(() {
                    print(local1);
                    print(local2);
                  }, [local1, local2]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = {};
          final local2 = {};
          useMemo(() {
            print(local1);
          }, [local1, local2]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useMemo has an unnecessary dependency: \'local2\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local1]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = {};
                  final local2 = {};
                  useMemo(() {
                    print(local1);
                  }, [local1]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = someFunc();
          final MyNestedComponent = uiFunction<TestProps>((_) {
            final local2 = {};
            useCallback(() {
              print(local1);
              print(local2);
            }, [local1]);
          }, null);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'local2\'. Either include it or remove the dependency list. Outer scope values like \'local1\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = someFunc();
                  final MyNestedComponent = uiFunction<TestProps>((_) {
                    final local2 = {};
                    useCallback(() {
                      print(local1);
                      print(local2);
                    }, [local2]);
                  }, null);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            print(local);
            print(local);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    print(local);
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            print(local);
            print(local);
          }, [local, local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    print(local);
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useCallback(() {}, [window]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency list. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  useCallback(() {}, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // It is not valid for useCallback to specify extraneous deps
      // because it doesn't serve as a side effect trigger unlike useEffect.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var local = props.foo;
          useCallback(() {}, [local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'local\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var local = props.foo;
                  useCallback(() {}, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var history = props.history;

          useEffect(() {
            return history.listen();
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'history\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [history]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var history = props.history;

                  useEffect(() {
                    return history.listen();
                  }, [history]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var history = props.history;

          useEffect(() {
            return [
              history.foo.bar[2].dobedo.listen(),
              history.foo.bar().dobedo.listen[2]
            ];
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'history.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [history.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var history = props.history;

                  useEffect(() {
                    return [
                      history.foo.bar[2].dobedo.listen(),
                      history.foo.bar().dobedo.listen[2]
                    ];
                  }, [history.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var history = props.history;

          useEffect(() {
            return [
              history?.foo
            ];
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'history?.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [history?.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var history = props.history;

                  useEffect(() {
                    return [
                      history?.foo
                    ];
                  }, [history?.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {}, ['foo']);
        }, null);
      ''',
      'errors': [
        {
          'message':
              // Don't assume user meant '''foo''' because it's not used in the effect.
              'The \'foo\' literal is not a valid dependency because it never changes. You can safely remove it.',
          // TODO(ported):provide suggestion.
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var foo = props.foo;
          var bar = props.bar;
          var baz = props.baz;

          useEffect(() {
            print([foo, bar, baz]);
          }, ['foo', 'bar']);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [bar, baz, foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var foo = props.foo;
                  var bar = props.bar;
                  var baz = props.baz;

                  useEffect(() {
                    print([foo, bar, baz]);
                  }, [bar, baz, foo]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'The \'foo\' literal is not a valid dependency because it never changes. Did you mean to include foo in the list instead?',
          'suggestions': null,
        },
        {
          'message':
              'The \'bar\' literal is not a valid dependency because it never changes. Did you mean to include bar in the list instead?',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var foo = props.foo;
          var bar = props.bar;
          var baz = props.baz;

          useEffect(() {
            print([foo, bar, baz]);
          }, [42, false, null]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'bar\', \'baz\', and \'foo\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [bar, baz, foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var foo = props.foo;
                  var bar = props.bar;
                  var baz = props.baz;

                  useEffect(() {
                    print([foo, bar, baz]);
                  }, [bar, baz, foo]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message': 'The 42 literal is not a valid dependency because it never changes. You can safely remove it.',
          'suggestions': null,
        },
        {
          'message': 'The false literal is not a valid dependency because it never changes. You can safely remove it.',
          'suggestions': null,
        },
        {
          'message': 'The null literal is not a valid dependency because it never changes. You can safely remove it.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final dependencies = [];
          useEffect(() {}, dependencies);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect was passed a dependency list that is not a list literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final dependencies = [local];
          useEffect(() {
            print(local);
          }, dependencies);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect was passed a dependency list that is not a list literal. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
          // TODO(ported):should this autofix or bail out?
          'suggestions': null,
        },
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final dependencies = [local];
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final dependencies = [local];
          useEffect(() {
            print(local);
          }, [...dependencies]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final dependencies = [local];
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a spread element in its dependency list. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
          // TODO(ported):should this autofix or bail out?
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = someFunc();
          useEffect(() {
            print(local);
            // ignore: undefined_identifier, not_iterable_spread
          }, [local, ...dependencies]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a spread element in its dependency list. This means we can\'t statically verify whether you\'ve passed the correct dependencies.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        String computeCacheKey(dynamic object) => null;
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            print(local);
          }, [computeCacheKey(local)]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          // TODO(ported):I'm not sure this is a good idea.
          //  Maybe bail out?
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                String computeCacheKey(dynamic object) => null;
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.items[0]);
          }, [props.items[0]]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.items\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.items]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    print(props.items[0]);
                  }, [props.items]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.items[0]);
          }, [props.items, props.items[0]]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          // TODO(ported):ideally suggestion would remove the bad expression?
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var items = props.items;

          useEffect(() {
            print(items[0]);
          }, [items[0]]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'items\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [items]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var items = props.items;

                  useEffect(() {
                    print(items[0]);
                  }, [items]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var items = props.items;

          useEffect(() {
            print(items[0]);
          }, [items, items[0]]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          // TODO(ported):ideally suggeston would remove the bad expression?
          'suggestions': null,
        },
      ],
    },
    {
      // It is not valid for useCallback to specify extraneous deps
      // because it doesn't serve as a side effect trigger unlike useEffect.
      // However, we generally allow specifying *broader* deps as escape hatch.
      // So while [props, props.foo] is unnecessary, 'props' wins here as the
      // broader one, and this is why 'props.foo' is reported as unnecessary.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = {};
          useCallback(() {
            print(props.foo);
            print(props.bar);
          }, [props, props.foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'props.foo\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final local = {};
                  useCallback(() {
                    print(props.foo);
                    print(props.bar);
                  }, [props]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Since we don't have 'props' in the list, we'll suggest narrow dependencies.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = {};
          useCallback(() {
            print(props.foo);
            print(props.bar);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar, props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final local = {};
                  useCallback(() {
                    print(props.foo);
                    print(props.bar);
                  }, [props.bar, props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Effects are allowed to over-specify deps. We'll complain about missing
      // 'local', but we won't remove the already-specified 'local.id' from your list.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = SomeObject(id: 42);
          useEffect(() {
            print(local);
          }, [local.id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local, local.id]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = SomeObject(id: 42);
                  useEffect(() {
                    print(local);
                  }, [local, local.id]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Callbacks are not allowed to over-specify deps. So we'll complain about missing
      // 'local' and we will also *remove* 'local.id' from your list.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = SomeObject(id: 42);
          final fn = useCallback(() {
            print(local);
          }, [local.id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = SomeObject(id: 42);
                  final fn = useCallback(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Callbacks are not allowed to over-specify deps. So we'll complain about
      // the unnecessary 'local.id'.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = SomeObject(id: 42);
          final fn = useCallback(() {
            print(local);
          }, [local.id, local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'local.id\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = SomeObject(id: 42);
                  final fn = useCallback(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final fn = useCallback(() {
            print(props.foo.bar.baz);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo.bar.baz\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo.bar.baz]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final fn = useCallback(() {
                    print(props.foo.bar.baz);
                  }, [props.foo.bar.baz]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var color = {};
          final fn = useCallback(() {
            print(props.foo.bar.baz);
            print(color);
          }, [props.foo, props.foo.bar.baz]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'color\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [color, props.foo.bar.baz]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var color = {};
                  final fn = useCallback(() {
                    print(props.foo.bar.baz);
                    print(color);
                  }, [color, props.foo.bar.baz]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Callbacks are not allowed to over-specify deps. So one of these is extra.
      // However, it *is* allowed to specify broader deps then strictly necessary.
      // So in this case we ask you to remove 'props.foo.bar.baz' because 'props.foo'
      // already covers it, and having both is unnecessary.
      // TODO(ported):maybe consider suggesting a narrower one by default in these cases.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final fn = useCallback(() {
            print(props.foo.bar.baz);
          }, [props.foo.bar.baz, props.foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'props.foo.bar.baz\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final fn = useCallback(() {
                    print(props.foo.bar.baz);
                  }, [props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final fn = useCallback(() {
            print(props.foo.bar.baz);
            print(props.foo.fizz.bizz);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has missing dependencies: \'props.foo.bar.baz\' and \'props.foo.fizz.bizz\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo.bar.baz, props.foo.fizz.bizz]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final fn = useCallback(() {
                    print(props.foo.bar.baz);
                    print(props.foo.fizz.bizz);
                  }, [props.foo.bar.baz, props.foo.fizz.bizz]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Normally we allow specifying deps too broadly.
      // So we'd be okay if 'props.foo.bar' was there rather than 'props.foo.bar.baz'.
      // However, 'props.foo.bar.baz' is missing. So we know there is a mistake.
      // When we're sure there is a mistake, for callbacks we will rebuild the list
      // from scratch. This will set the user on a better path by default.
      // This is why we end up with just 'props.foo.bar', and not them both.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final fn = useCallback(() {
            print(props.foo.bar);
          }, [props.foo.bar.baz]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo.bar]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final fn = useCallback(() {
                    print(props.foo.bar);
                  }, [props.foo.bar]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final fn = useCallback(() {
            print(props);
            print(props.hello);
          }, [props.foo.bar.baz]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final fn = useCallback(() {
                    print(props);
                    print(props.hello);
                  }, [props]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(() {
            print(local);
          }, [local, local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a duplicate dependency: \'local\'. Either omit it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = {};
          useCallback(() {
            final local1 = {};
            print(local1);
          }, [local1]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = {};
                  useCallback(() {
                    final local1 = {};
                    print(local1);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local1 = {};
          useCallback(() {}, [local1]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has an unnecessary dependency: \'local1\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local1 = {};
                  useCallback(() {}, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    print(props.foo);
                  }, [props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            print(props.foo);
            print(props.bar);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'props.bar\' and \'props.foo\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar, props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    print(props.foo);
                    print(props.bar);
                  }, [props.bar, props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var a, b, c, d, e, f, g;
          useEffect(() {
            print([b, e, d, c, a, g, f]);
          }, [c, a, g]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency list.',
          // Don't alphabetize if it wasn't alphabetized in the first place.
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [c, a, g, b, e, d, f]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var a, b, c, d, e, f, g;
                  useEffect(() {
                    print([b, e, d, c, a, g, f]);
                  }, [c, a, g, b, e, d, f]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var a, b, c, d, e, f, g;
          useEffect(() {
            print([b, e, d, c, a, g, f]);
          }, [a, c, g]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'b\', \'d\', \'e\', and \'f\'. Either include them or remove the dependency list.',
          // Alphabetize if it was alphabetized.
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [a, b, c, d, e, f, g]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var a, b, c, d, e, f, g;
                  useEffect(() {
                    print([b, e, d, c, a, g, f]);
                  }, [a, b, c, d, e, f, g]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Formats dependencies in fix with newlines if old dependencies had newlines',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var a, b, c, d;
          useEffect(() {
            print([a, b, c, d]);
          }, [
            a,
            b
          ]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'c\' and \'d\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [a, b, c, d]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var a, b, c, d;
                  useEffect(() {
                    print([a, b, c, d]);
                  }, [
                    a,
                    b,
                    c,
                    d
                  ]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Formats dependencies in fix with trailing commas if old dependencies had trailing commas',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var a, b, c, d;
          useEffect(() {
            print([a, b, c, d]);
          }, [
            a,
            b,
          ]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'c\' and \'d\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [a, b, c, d]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var a, b, c, d;
                  useEffect(() {
                    print([a, b, c, d]);
                  }, [
                    a,
                    b,
                    c,
                    d,
                  ]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var a, b, c, d, e, f, g;
          useEffect(() {
            print([b, e, d, c, a, g, f]);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'a\', \'b\', \'c\', \'d\', \'e\', \'f\', and \'g\'. Either include them or remove the dependency list.',
          // Alphabetize if it was empty.
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [a, b, c, d, e, f, g]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var a, b, c, d, e, f, g;
                  useEffect(() {
                    print([b, e, d, c, a, g, f]);
                  }, [a, b, c, d, e, f, g]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = {};
          useEffect(() {
            print(props.foo);
            print(props.bar);
            print(local);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'local\', \'props.bar\', and \'props.foo\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local, props.bar, props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final local = {};
                  useEffect(() {
                    print(props.foo);
                    print(props.bar);
                    print(local);
                  }, [local, props.bar, props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final local = {};
          useEffect(() {
            print(props.foo);
            print(props.bar);
            print(local);
          }, [props]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local, props]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final local = {};
                  useEffect(() {
                    print(props.foo);
                    print(props.bar);
                    print(local);
                  }, [local, props]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
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
            print(props.bar);
          }, []);
          over_react.useCallback(() {
            print(props.bar);
          }, []);
          over_react.useMemo(() {
            print(props.bar);
          }, []);
          // ignore: undefined_function
          over_react.notReactiveHook(() {
            print(props.bar);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
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
                    print(props.bar);
                  }, []);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, []);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
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
                    print(props.bar);
                  }, []);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, []);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useMemo has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
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
                    print(props.bar);
                  }, []);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, []);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar]',
              'output': r'''
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
                    print(props.bar);
                  }, [props.bar]);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, []);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useCallback has a missing dependency: \'props.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar]',
              'output': r'''
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
                    print(props.bar);
                  }, []);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, [props.bar]);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useMemo has a missing dependency: \'props.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar]',
              'output': r'''
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
                    print(props.bar);
                  }, []);
                  over_react.useCallback(() {
                    print(props.bar);
                  }, []);
                  over_react.useMemo(() {
                    print(props.bar);
                  }, [props.bar]);
                  // ignore: undefined_function
                  over_react.notReactiveHook(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useCustomEffect(() {
            print(props.foo);
          }, []);
          useEffect(() {
            print(props.foo);
          }, []);
          over_react.useEffect(() {
            print(props.bar);
          }, []);
          // ignore: undefined_function
          over_react.useCustomEffect(() {
            print(props.bar);
          }, []);
        }, null);
      ''',
      'options': [
        {'additionalHooks': 'useCustomEffect'}
      ],
      'errors': [
        {
          'message':
              'React Hook useCustomEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCustomEffect(() {
                    print(props.foo);
                  }, [props.foo]);
                  useEffect(() {
                    print(props.foo);
                  }, []);
                  over_react.useEffect(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.useCustomEffect(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCustomEffect(() {
                    print(props.foo);
                  }, []);
                  useEffect(() {
                    print(props.foo);
                  }, [props.foo]);
                  over_react.useEffect(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.useCustomEffect(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCustomEffect(() {
                    print(props.foo);
                  }, []);
                  useEffect(() {
                    print(props.foo);
                  }, []);
                  over_react.useEffect(() {
                    print(props.bar);
                  }, [props.bar]);
                  // ignore: undefined_function
                  over_react.useCustomEffect(() {
                    print(props.bar);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useCustomEffect has a missing dependency: \'props.bar\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.bar]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useCustomEffect(() {
                    print(props.foo);
                  }, []);
                  useEffect(() {
                    print(props.foo);
                  }, []);
                  over_react.useEffect(() {
                    print(props.bar);
                  }, []);
                  // ignore: undefined_function
                  over_react.useCustomEffect(() {
                    print(props.bar);
                  }, [props.bar]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          var a, b;
          final local = {};
          useEffect(() {
            print(local);
          }, [a ? local : b]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          // TODO(ported):should we bail out instead?
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  var a, b;
                  final local = {};
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          var a;
          final local = {};
          useEffect(() {
            print(local);
          }, [a ?? local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          // TODO(ported):should we bail out instead?
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  var a;
                  final local = {};
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {}, [props?.attribute.method()]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {}, [props.function()]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'name': 'Cascade in dependencies list',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {}, [props..function()]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a complex expression in the dependency list. Extract it to a separate variable so it can be statically checked.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          var state = useState(0);
          useEffect(() {
            ref.current = {};
            state.set(state.value + 1);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'state.value\'. Either include it or remove the dependency list. You can also do a functional update \'state.setWithUpdater((s) => ...)\' if you only need \'state.value\' in the \'state.set\' call.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [state.value]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final ref = useRef();
                  var state = useState(0);
                  useEffect(() {
                    ref.current = {};
                    state.set(state.value + 1);
                  }, [state.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          var state = useState<dynamic>(null);
          useEffect(() {
            ref.current = {};
            state.set(state.value + 1);
          }, [ref]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'state.value\'. Either include it or remove the dependency list. You can also do a functional update \'state.setWithUpdater((s) => ...)\' if you only need \'state.value\' in the \'state.set\' call.',
          // We don't ask to remove static deps but don't add them either.
          // Don't suggest removing "ref" (it's fine either way)
          // but *do* add "state". *Don't* add "setState" ourselves.
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [ref, state.value]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final ref = useRef();
                  var state = useState<dynamic>(null);
                  useEffect(() {
                    ref.current = {};
                    state.set(state.value + 1);
                  }, [ref, state.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final ref1 = useRef();
          final ref2 = useRef();
          useEffect(() {
            ref1.current.focus();
            print(ref2.current.textContent);
            window.alert(props.someOtherRefs.current.innerHTML);
            fetch(props.color);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'props.color\' and \'props.someOtherRefs\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.color, props.someOtherRefs]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final ref1 = useRef();
                  final ref2 = useRef();
                  useEffect(() {
                    ref1.current.focus();
                    print(ref2.current.textContent);
                    window.alert(props.someOtherRefs.current.innerHTML);
                    fetch(props.color);
                  }, [props.color, props.someOtherRefs]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final ref1 = useRef();
          final ref2 = useRef();
          useEffect(() {
            ref1.current.focus();
            print(ref2.current.textContent);
            window.alert(props.someOtherRefs.current.innerHTML);
            fetch(props.color);
          }, [ref1.current, ref2.current, props.someOtherRefs, props.color]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency list. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.someOtherRefs, props.color]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final ref1 = useRef();
                  final ref2 = useRef();
                  useEffect(() {
                    ref1.current.focus();
                    print(ref2.current.textContent);
                    window.alert(props.someOtherRefs.current.innerHTML);
                    fetch(props.color);
                  }, [props.someOtherRefs, props.color]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final ref1 = useRef();
          final ref2 = useRef();
          useEffect(() {
            ref1?.current?.focus();
            print(ref2?.current?.textContent);
            window.alert(props.someOtherRefs.current.innerHTML);
            fetch(props.color);
          }, [ref1?.current, ref2?.current, props.someOtherRefs, props.color]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency list. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.someOtherRefs, props.color]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final ref1 = useRef();
                  final ref2 = useRef();
                  useEffect(() {
                    ref1?.current?.focus();
                    print(ref2?.current?.textContent);
                    window.alert(props.someOtherRefs.current.innerHTML);
                    fetch(props.color);
                  }, [props.someOtherRefs, props.color]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          useEffect(() {
            print(ref.current);
          }, [ref.current]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency list. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final ref = useRef();
                  useEffect(() {
                    print(ref.current);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var activeTab = props.activeTab;

          final ref1 = useRef();
          final ref2 = useRef();
          useEffect(() {
            ref1.current.scrollTop = 0;
            ref2.current.scrollTop = 0;
          }, [ref1.current, ref2.current, activeTab]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has unnecessary dependencies: \'ref1.current\' and \'ref2.current\'. Either exclude them or remove the dependency list. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [activeTab]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var activeTab = props.activeTab;

                  final ref1 = useRef();
                  final ref2 = useRef();
                  useEffect(() {
                    ref1.current.scrollTop = 0;
                    ref2.current.scrollTop = 0;
                  }, [activeTab]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var activeTab = props.activeTab;
          var initY = props.initY;

          final ref1 = useRef();
          final ref2 = useRef();
          final fn = useCallback(() {
            ref1.current.scrollTop = initY;
            ref2.current.scrollTop = initY;
          }, [ref1.current, ref2.current, activeTab, initY]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has unnecessary dependencies: \'activeTab\', \'ref1.current\', and \'ref2.current\'. Either exclude them or remove the dependency list. Mutable values like \'ref1.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [initY]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var activeTab = props.activeTab;
                  var initY = props.initY;

                  final ref1 = useRef();
                  final ref2 = useRef();
                  final fn = useCallback(() {
                    ref1.current.scrollTop = initY;
                    ref2.current.scrollTop = initY;
                  }, [initY]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef();
          useEffect(() {
            print(ref.current);
          }, [ref.current, ref]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has an unnecessary dependency: \'ref.current\'. Either exclude it or remove the dependency list. Mutable values like \'ref.current\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [ref]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final ref = useRef();
                  useEffect(() {
                    print(ref.current);
                  }, [ref]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiForwardRef<TestProps>((props, ref) {
          useImperativeHandle(ref, () => ({
            'focus': () {
              window.alert(props.hello);
            }
          }), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useImperativeHandle has a missing dependency: \'props.hello\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.hello]',
              'output': r'''
                final MyComponent = uiForwardRef<TestProps>((props, ref) {
                  useImperativeHandle(ref, () => ({
                    'focus': () {
                      window.alert(props.hello);
                    }
                  }), [props.hello]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // In this case it's important that the call is the only reference to the prop
      'name': 'Calling a function prop',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props.onChange(null);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.onChange\'. Either include it or remove the dependency list. If \'props.onChange\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.onChange]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props.onChange(null);
                  }, [props.onChange]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Calling a function prop with another non-call reference present',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            if (props.onChange != null) {
              props.onChange(null);
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.onChange\'. Either include it or remove the dependency list. If \'props.onChange\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.onChange]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    if (props.onChange != null) {
                      props.onChange(null);
                    }
                  }, [props.onChange]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Calling a function prop with a null-aware on props',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props?.onChange(null);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props?.onChange\'. Either include it or remove the dependency list. If \'props?.onChange\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props?.onChange]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props?.onChange(null);
                  }, [props?.onChange]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Calling a function prop with a null-aware on the call',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props.onChange?.call(null);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.onChange\'. Either include it or remove the dependency list. If \'props.onChange\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.onChange]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props.onChange?.call(null);
                  }, [props.onChange]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Calling function props in a cascade',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props
              ..onClick(null)
              ..onChange(null);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect most likely has issues in its dependencies list, but the exact problems and recommended fixes could not be be computed since the dependency \'props\' is the target of a cascade. Try refactoring to not cascade on that dependency in the callback to get more helpful instructions and potentially a suggested fix.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            play() {
              props.onPlay();
            }
            pause() {
              props.onPause();
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'props.onPause\' and \'props.onPlay\'. Either include them or remove the dependency list. If any of \'props.onPause\' or \'props.onPlay\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.onPause, props.onPlay]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    play() {
                      props.onPlay();
                    }
                    pause() {
                      props.onPause();
                    }
                  }, [props.onPause, props.onPlay]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            if (props.foo.onChange != null) {
              props.foo.onChange();
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    if (props.foo.onChange != null) {
                      props.foo.onChange();
                    }
                  }, [props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Calling a function property of an object without any dependencies',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props.foo.onChange();
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.foo\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props.foo.onChange();
                  }, [props.foo]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props.onChange(null);
            if (props.foo.onChange) {
              props.foo.onChange();
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'props.foo\' and \'props.onChange\'. Either include them or remove the dependency list. If \'props.onChange\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo, props.onChange]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props.onChange(null);
                    if (props.foo.onChange) {
                      props.foo.onChange();
                    }
                  }, [props.foo, props.onChange]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* 1 test case previously here was moved to be a valid test case, since it involved a function prop call declared as a dependency, which is now allowed */
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final skillsCount = useState<dynamic>(null);
          useEffect(() {
            if (skillsCount.value == 0 && !props.isEditMode) {
              props.toggleEditMode();
            }
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'props.isEditMode\', \'props.toggleEditMode\', and \'skillsCount.value\'. Either include them or remove the dependency list. If \'props.toggleEditMode\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.isEditMode, props.toggleEditMode, skillsCount.value]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final skillsCount = useState<dynamic>(null);
                  useEffect(() {
                    if (skillsCount.value == 0 && !props.isEditMode) {
                      props.toggleEditMode();
                    }
                  }, [props.isEditMode, props.toggleEditMode, skillsCount.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        void externalCall(dynamic arg) {}
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            externalCall(props);
            props.onChange(null);
          }, []);
        }, null);
      ''',
      // Don't suggest to destructure props here since you can't.
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props]',
              'output': r'''
                void externalCall(dynamic arg) {}
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    externalCall(props);
                    props.onChange(null);
                  }, [props]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        void externalCall(dynamic arg) {}
        final MyComponent = uiFunction<TestProps>((props) {
          useEffect(() {
            props.onChange(null);
            externalCall(props);
          }, []);
        }, null);
      ''',
      // Don't suggest to destructure props here since you can't.
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props]',
              'output': r'''
                void externalCall(dynamic arg) {}
                final MyComponent = uiFunction<TestProps>((props) {
                  useEffect(() {
                    props.onChange(null);
                    externalCall(props);
                  }, [props]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
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
        }, null);
      ''',
      // This is a separate warning unrelated to others.
      // We could've made a separate rule for it but it's rare enough to name it.
      // No suggestions because the intent isn't clear.
      'errors': [
        {
          'message':
              // value2
              'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
        {
          'message':
              // value
              'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
        {
          'message':
              // value4
              'Assignments to the \'value4\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
        {
          'message':
              // asyncValue
              'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
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
        }, null);
      ''',
      // This is a separate warning unrelated to others.
      // We could've made a separate rule for it but it's rare enough to name it.
      // No suggestions because the intent isn't clear.
      'errors': [
        {
          'message':
              // value
              'Assignments to the \'value\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
        {
          'message':
              // value2
              'Assignments to the \'value2\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
        {
          'message':
              // asyncValue
              'Assignments to the \'asyncValue\' variable from inside React Hook useEffect will be lost after each render. To preserve the value over time, store it in a useRef Hook and keep the mutable value in the \'.current\' property. Otherwise, you can move this variable directly inside useEffect.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            myRef.current.addEventListener('mousemove', handleMove);
            return () => myRef.current.removeEventListener('mousemove', handleMove);
          }, []);
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            myRef?.current?.addEventListener('mousemove', handleMove);
            return () => myRef?.current?.removeEventListener('mousemove', handleMove);
          }, []);
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useEffect(() {
            final handleMove = () {};
            myRef.current.addEventListener('mousemove', handleMove);
            return () => myRef.current.removeEventListener('mousemove', handleMove);
          });
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        useMyThing(myRef) {
          useEffect(() {
            final handleMove = () {};
            myRef.current.addEventListener('mousemove', handleMove);
            return () => myRef.current.removeEventListener('mousemove', handleMove);
          }, [myRef]);
        }
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
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
            };
          }, [myRef]);
        }
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        useMyThing(myRef, active) {
          useEffect(() {
            final handleMove = () {};
            if (active) {
              myRef.current.addEventListener('mousemove', handleMove);
              return () {
                setTimeout(() {
                  myRef.current.removeEventListener('mousemove', handleMove);
                });
              };
            }
          }, [myRef, active]);
        }
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        void useLayoutEffect_SAFE_FOR_SSR(dynamic Function() callback, [List<dynamic> dependencies]) {}
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useLayoutEffect_SAFE_FOR_SSR(() {
            final handleMove = () {};
            myRef.current.addEventListener('mousemove', handleMove);
            return () => myRef.current.removeEventListener('mousemove', handleMove);
          });
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
      'output': r'''
        void useLayoutEffect_SAFE_FOR_SSR(dynamic Function() callback, [List<dynamic> dependencies]) {}
        final MyComponent = uiFunction<TestProps>((_) {
          final myRef = useRef();
          useLayoutEffect_SAFE_FOR_SSR(() {
            final handleMove = () {};
            myRef.current.addEventListener('mousemove', handleMove);
            return () => myRef.current.removeEventListener('mousemove', handleMove);
          });
          return (Dom.div()..ref = myRef)();
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The ref value \'myRef.current\' will likely have changed by the time this effect cleanup function runs. If this ref points to a node rendered by React, copy \'myRef.current\' to a variable inside the effect, and use that variable in the cleanup function.',
          'suggestions': null,
        }
      ],
      'options': [
        {'additionalHooks': 'useLayoutEffect_SAFE_FOR_SSR'}
      ],
    },
    {
      // Autofix ignores constant primitives (leaving the ones that are there).
      'code': r'''
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local4\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local1, local3, local4]',
              'output': r'''
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
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {
            window.scrollTo(0, 0);
          }, [window]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has an unnecessary dependency: \'window\'. Either exclude it or remove the dependency list. Outer scope values like \'window\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  useEffect(() {
                    window.scrollTo(0, 0);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          useEffect(() {
            print(MutableStore.hello);
          }, [MutableStore.hello]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has an unnecessary dependency: \'MutableStore.hello\'. Either exclude it or remove the dependency list. Outer scope values like \'MutableStore.hello\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  useEffect(() {
                    print(MutableStore.hello);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        var z = {};
        final MyComponent = uiFunction<TestProps>((props) {
          var x = props.foo;
          {
            var y = props.bar;
            useEffect(() {
              print([MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
            }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
          }
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency list. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo, x, y]',
              'output': r'''
                var z = {};
                final MyComponent = uiFunction<TestProps>((props) {
                  var x = props.foo;
                  {
                    var y = props.bar;
                    useEffect(() {
                      print([MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
                    }, [props.foo, x, y]);
                  }
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        var z = {};
        final MyComponent = uiFunction<TestProps>((props) {
          var x = props.foo;
          {
            var y = props.bar;
            useEffect(() {
              // nothing
            }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
          }
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', and \'z\'. Either exclude them or remove the dependency list. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          // The output should contain the ones that are inside a component
          // since there are legit reasons to over-specify them for effects.
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.foo, x, y]',
              'output': r'''
                var z = {};
                final MyComponent = uiFunction<TestProps>((props) {
                  var x = props.foo;
                  {
                    var y = props.bar;
                    useEffect(() {
                      // nothing
                    }, [props.foo, x, y]);
                  }
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        var z = {};
        final MyComponent = uiFunction<TestProps>((props) {
          var x = props.foo;
          {
            var y = props.bar;
            final fn = useCallback(() {
              // nothing
            }, [MutableStore.hello.world, props.foo, x, y, z, global.stuff]);
          }
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency list. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                var z = {};
                final MyComponent = uiFunction<TestProps>((props) {
                  var x = props.foo;
                  {
                    var y = props.bar;
                    final fn = useCallback(() {
                      // nothing
                    }, []);
                  }
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        var z = {};
        final MyComponent = uiFunction<TestProps>((props) {
          var x = props.foo;
          {
            var y = props.bar;
            final fn = useCallback(() {
              // nothing
            }, [MutableStore?.hello?.world, props.foo, x, y, z, global?.stuff]);
          }
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useCallback has unnecessary dependencies: \'MutableStore.hello.world\', \'global.stuff\', \'props.foo\', \'x\', \'y\', and \'z\'. Either exclude them or remove the dependency list. Outer scope values like \'MutableStore.hello.world\' aren\'t valid dependencies because mutating them doesn\'t re-render the component.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                var z = {};
                final MyComponent = uiFunction<TestProps>((props) {
                  var x = props.foo;
                  {
                    var y = props.bar;
                    final fn = useCallback(() {
                      // nothing
                    }, []);
                  }
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Every almost-static function is tainted by a dynamic value.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          var dispatch = over_react.useReducer(null, null).dispatch;
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
            dispatch({ 'type': 'x', 'value': value });
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext1]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext3]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          var dispatch = over_react.useReducer(null, null).dispatch;
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
            dispatch({ 'type': 'x', 'value': value });
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext1]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext3]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Regression test
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          var dispatch = over_react.useReducer(null, null).dispatch;
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
            dispatch({ 'type': 'x', 'value': value });
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'handleNext1\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext1]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useLayoutEffect has a missing dependency: \'handleNext2\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext2]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'React Hook useMemo has a missing dependency: \'handleNext3\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [handleNext3]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  var dispatch = over_react.useReducer(null, null).dispatch;
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
                    dispatch({ 'type': 'x', 'value': value });
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
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          handleNext(value) {
            state.set(value);
          }
          useEffect(() {
            return Store.subscribe(handleNext);
          }, [handleNext]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 8) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
          // Not gonna fix a function definition
          // because it's not always safe due to hoisting.
          'suggestions': null,
        },
      ],
    },
    {
      // Even if the function only references static values,
      // once you specify it in deps, it will invalidate them.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          final handleNext = (value) {
            state.set(value);
          };
          useEffect(() {
            return Store.subscribe(handleNext);
          }, [handleNext]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 8) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
          // We don't fix moving (too invasive). But that's the suggested fix
          // when only effect uses this function. Otherwise, we'd useCallback.
          'suggestions': null,
        },
      ],
    },
    {
      // Even if the function only references static values,
      // once you specify it in deps, it will invalidate them.
      // However, we can't suggest moving handleNext into the
      // effect because it is *also* used outside of it.
      // So our suggestion is useCallback().
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          final handleNext = (value) {
            state.set(value);
          };
          useEffect(() {
            return Store.subscribe(handleNext);
          }, [handleNext]);
          return (Dom.div()..onClick = handleNext)();
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 8) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
          // We fix this one with useCallback since it's
          // the easy fix and you can't just move it into effect.
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var state = useState<dynamic>(null);
                  final handleNext = useCallback((value) {
                    state.set(value);
                  }, [/* FIXME add dependencies */]);
                  useEffect(() {
                    return Store.subscribe(handleNext);
                  }, [handleNext]);
                  return (Dom.div()..onClick = handleNext)();
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 13) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
          'suggestions': null,
        },
        {
          'message':
              'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 16) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
          'suggestions': null,
        },
        {
          'message':
              'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 19) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
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
        }, null);
      ''',
      // Suggestions don't wrap into useCallback here
      // because they are only referenced by effect itself.
      'errors': [
        {
          'message':
              'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
          'suggestions': null,
        },
        {
          'message':
              'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 18) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
          'suggestions': null,
        },
        {
          'message':
              'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 22) change on every render. Move it inside the useMemo callback. Alternatively, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
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
            (Dom.div()
              ..onClick = (_) {
                handleNext1();
                setTimeout(handleNext2);
                setTimeout(() {
                  handleNext3();
                });
              }
            )()
          );
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 14) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
          // Suggestion wraps into useCallback where possible
          // because they are also referenced outside the effect.
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final handleNext1 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
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
                    (Dom.div()
                      ..onClick = (_) {
                        handleNext1();
                        setTimeout(handleNext2);
                        setTimeout(() {
                          handleNext3();
                        });
                      }
                    )()
                  );
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'The \'handleNext2\' function makes the dependencies of useLayoutEffect Hook (at line 18) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
          // Suggestion wraps into useCallback where possible
          // because they are also referenced outside the effect.
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  handleNext1() {
                    print('hello');
                  }
                  final handleNext2 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
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
                    (Dom.div()
                      ..onClick = (_) {
                        handleNext1();
                        setTimeout(handleNext2);
                        setTimeout(() {
                          handleNext3();
                        });
                      }
                    )()
                  );
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'The \'handleNext3\' function makes the dependencies of useMemo Hook (at line 22) change on every render. To fix this, wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
          // Autofix wraps into useCallback where possible
          // because they are also referenced outside the effect.
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext3\' in its own useCallback() Hook.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  handleNext1() {
                    print('hello');
                  }
                  final handleNext2 = () {
                    print('hello');
                  };
                  var handleNext3 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
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
                    (Dom.div()
                      ..onClick = (_) {
                        handleNext1();
                        setTimeout(handleNext2);
                        setTimeout(() {
                          handleNext3();
                        });
                      }
                    )()
                  );
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        // ignore_for_file: dead_code
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
        }, null);
      ''',
      // Normally we'd suggest moving handleNext inside an
      // effect. But it's used by more than one. So we
      // suggest useCallback() and use it for the autofix
      // where possible.
      // TODO(ported):we could coalesce messages for the same function if it affects multiple Hooks.
      'errors': [
        {
          'message':
              'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
              'output': r'''
                // ignore_for_file: dead_code
                final MyComponent = uiFunction<TestProps>((props) {
                  final handleNext1 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'The \'handleNext1\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext1\' in its own useCallback() Hook.',
              'output': r'''
                // ignore_for_file: dead_code
                final MyComponent = uiFunction<TestProps>((props) {
                  final handleNext1 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
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
                }, null);
              ''',
            },
          ],
        },
        {
          'message':
              'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
              'output': r'''
                // ignore_for_file: dead_code
                final MyComponent = uiFunction<TestProps>((props) {
                  final handleNext1 = () {
                    print('hello');
                  };
                  final handleNext2 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
                  useEffect(() {
                    return Store.subscribe(handleNext1);
                    return Store.subscribe(handleNext2);
                  }, [handleNext1, handleNext2]);
                  useEffect(() {
                    return Store.subscribe(handleNext1);
                    return Store.subscribe(handleNext2);
                  }, [handleNext1, handleNext2]);
                }, null);
              ''',
            },
          ]
        },
        {
          'message':
              'The \'handleNext2\' function makes the dependencies of useEffect Hook (at line 16) change on every render. To fix this, wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext2\' in its own useCallback() Hook.',
              'output': r'''
                // ignore_for_file: dead_code
                final MyComponent = uiFunction<TestProps>((props) {
                  final handleNext1 = () {
                    print('hello');
                  };
                  final handleNext2 = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
                  useEffect(() {
                    return Store.subscribe(handleNext1);
                    return Store.subscribe(handleNext2);
                  }, [handleNext1, handleNext2]);
                  useEffect(() {
                    return Store.subscribe(handleNext1);
                    return Store.subscribe(handleNext2);
                  }, [handleNext1, handleNext2]);
                }, null);
              ''',
            },
          ]
        },
      ],
    },
    {
      'code': r'''
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
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 12) change on every render. To fix this, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
          // Normally we'd suggest moving handleNext inside an
          // effect. But it's used more than once.
          // TODO(ported):our autofix here isn't quite sufficient because
          //  it only wraps the first definition. But seems ok.
          'suggestions': [
            {
              'desc': 'Wrap the definition of \'handleNext\' in its own useCallback() Hook.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var handleNext = useCallback(() {
                    print('hello');
                  }, [/* FIXME add dependencies */]);
                  if (props.foo) {
                    handleNext = () {
                      print('hello');
                    };
                  }
                  useEffect(() {
                    return Store.subscribe(handleNext);
                  }, [handleNext]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var state = useState<dynamic>(null);
          var taint = props.foo;
          handleNext(value) {
            var value2 = value * taint;
            state.set(value2);
            print('hello');
          }
          useEffect(() {
            return Store.subscribe(handleNext);
          }, [handleNext]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'handleNext\' function makes the dependencies of useEffect Hook (at line 11) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'handleNext\' in its own useCallback() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.set(count.value + 1);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count.value\'. Either include it or remove the dependency list. You can also do a functional update \'count.setWithUpdater((c) => ...)\' if you only need \'count.value\' in the \'count.set\' call.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count.value]',
              'output': r'''
                final Counter = uiFunction<TestProps>((_) {
                  var count = useState(0);
                  useEffect(() {
                    var id = setInterval(() {
                      count.set(count.value + 1);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [count.value]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          var increment = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.set(count.value + increment.value);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'count.value\' and \'increment.value\'. Either include them or remove the dependency list. You can also do a functional update \'count.setWithUpdater((c) => ...)\' if you only need \'count.value\' in the \'count.set\' call.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count.value, increment.value]',
              'output': r'''
                final Counter = uiFunction<TestProps>((_) {
                  var count = useState(0);
                  var increment = useState(0);
                  useEffect(() {
                    var id = setInterval(() {
                      count.set(count.value + increment.value);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [count.value, increment.value]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          var increment = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => value + increment.value);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'increment.value\'. Either include it or remove the dependency list. You can also replace multiple useState variables with useReducer if \'count.setWithUpdater\' needs \'increment.value\'.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [increment.value]',
              'output': r'''
                final Counter = uiFunction<TestProps>((_) {
                  var count = useState(0);
                  var increment = useState(0);
                  useEffect(() {
                    var id = setInterval(() {
                      count.setWithUpdater((value) => value + increment.value);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [increment.value]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        dynamic useCustomHook() => null;
        final Counter = uiFunction<TestProps>((_) {
          var count = useState(0);
          var increment = useCustomHook();
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => value + increment);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      // This intentionally doesn't show the reducer message
      // because we don't know if it's safe for it to close over a value.
      // We only show it for state variables (and possibly props).
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [increment]',
              'output': r'''
                dynamic useCustomHook() => null;
                final Counter = uiFunction<TestProps>((_) {
                  var count = useState(0);
                  var increment = useCustomHook();
                  useEffect(() {
                    var id = setInterval(() {
                      count.setWithUpdater((value) => value + increment);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [increment]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((props) {
          var step = props.step;

          var count = useState(0);
          int increment(int x) {
            return x + step;
          }
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => increment(value));
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      // This intentionally doesn't show the reducer message
      // because we don't know if it's safe for it to close over a value.
      // We only show it for state variables (and possibly props).
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [increment]',
              'output': r'''
                final Counter = uiFunction<TestProps>((props) {
                  var step = props.step;

                  var count = useState(0);
                  int increment(int x) {
                    return x + step;
                  }
                  useEffect(() {
                    var id = setInterval(() {
                      count.setWithUpdater((value) => increment(value));
                    }, 1000);
                    return () => clearInterval(id);
                  }, [increment]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Counter = uiFunction<TestProps>((props) {
          var step = props.step;

          var count = useState(0);
          int increment(int x) {
            return x + step;
          }
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => increment(value));
            }, 1000);
            return () => clearInterval(id);
          }, [increment]);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'increment\' function makes the dependencies of useEffect Hook (at line 13) change on every render. Move it inside the useEffect callback. Alternatively, wrap the definition of \'increment\' in its own useCallback() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'name': 'Missing prop dependency used in state setter (prop variable)',
      'code': r'''
        final Counter = uiFunction<TestProps>((props) {
          final increment = props.increment;

          var count = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => value + increment);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'increment\'. Either include it or remove the dependency list. If \'count.setWithUpdater\' needs the current value of \'increment\', you can also switch to useReducer instead of useState and read \'increment\' in the reducer.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [increment]',
              'output': r'''
                final Counter = uiFunction<TestProps>((props) {
                  final increment = props.increment;

                  var count = useState(0);
                  useEffect(() {
                    var id = setInterval(() {
                      count.setWithUpdater((value) => value + increment);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [increment]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'Missing prop dependency used in state setter (accessed via `props.`)',
      'code': r'''
        final Counter = uiFunction<TestProps>((props) {
          var count = useState(0);
          useEffect(() {
            var id = setInterval(() {
              count.setWithUpdater((value) => value + props.increment);
            }, 1000);
            return () => clearInterval(id);
          }, []);
          return Dom.h1()(count.value);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.increment\'. Either include it or remove the dependency list. If \'count.setWithUpdater\' needs the current value of \'props.increment\', you can also switch to useReducer instead of useState and read \'props.increment\' in the reducer.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.increment]',
              'output': r'''
                final Counter = uiFunction<TestProps>((props) {
                  var count = useState(0);
                  useEffect(() {
                    var id = setInterval(() {
                      count.setWithUpdater((value) => value + props.increment);
                    }, 1000);
                    return () => clearInterval(id);
                  }, [props.increment]);
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
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
          return Dom.h1()(count.value);
        }, null);
      ''',
      // TODO(ported):ideally this should suggest useState updater form
      //  since this code doesn't actually work. The autofix could
      //  at least avoid suggesting 'tick' since it's obviously
      //  always different, and thus useless.
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'tick\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [tick]',
              'output': r'''
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
                  return Dom.h1()(count.value);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* ("Regression test for a crash" previously here was removed since the original cause of the crash is not applicable
       in the Dart logic, and the test case involving variables declared after they're referenced is not valid in Dart.) */
    {
      'code': r'''
        final Podcasts = uiFunction<TestProps>((props) {
          var fetchPodcasts = props.fetchPodcasts;
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            fetchPodcasts(id).then(podcasts.set);
          }, [id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency list. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [fetchPodcasts, id]',
              'output': r'''
                final Podcasts = uiFunction<TestProps>((props) {
                  var fetchPodcasts = props.fetchPodcasts;
                  var id = props.id;

                  var podcasts = useState<dynamic>(null);
                  useEffect(() {
                    fetchPodcasts(id).then(podcasts.set);
                  }, [fetchPodcasts, id]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    // This test case was added to verify the same behavior for direct invocations of function props,
    // since they're treated differently in the Dart implementation of this lint.
    {
      'code': r'''
        final Podcasts = uiFunction<TestProps>((props) {
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            props.fetchPodcasts(id).then(podcasts.set);
          }, [id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.fetchPodcasts\'. Either include it or remove the dependency list. If \'props.fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [id, props.fetchPodcasts]',
              'output': r'''
                final Podcasts = uiFunction<TestProps>((props) {
                  var id = props.id;

                  var podcasts = useState<dynamic>(null);
                  useEffect(() {
                    props.fetchPodcasts(id).then(podcasts.set);
                  }, [id, props.fetchPodcasts]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* (1 case previously here was removed, since it was the same as the above test, only props were destructured in the argument list) */
    {
      'code': r'''
        final Podcasts = uiFunction<TestProps>((props) {
          var fetchPodcasts = props.fetchPodcasts;
          var fetchPodcasts2 = props.fetchPodcasts2;
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            setTimeout(() {
              print(id);
              fetchPodcasts(id).then(podcasts.set);
              fetchPodcasts2(id).then(podcasts.set);
            });
          }, [id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'fetchPodcasts\' and \'fetchPodcasts2\'. Either include them or remove the dependency list. If any of \'fetchPodcasts\' or \'fetchPodcasts2\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [fetchPodcasts, fetchPodcasts2, id]',
              'output': r'''
                final Podcasts = uiFunction<TestProps>((props) {
                  var fetchPodcasts = props.fetchPodcasts;
                  var fetchPodcasts2 = props.fetchPodcasts2;
                  var id = props.id;

                  var podcasts = useState<dynamic>(null);
                  useEffect(() {
                    setTimeout(() {
                      print(id);
                      fetchPodcasts(id).then(podcasts.set);
                      fetchPodcasts2(id).then(podcasts.set);
                    });
                  }, [fetchPodcasts, fetchPodcasts2, id]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Podcasts = uiFunction<TestProps>((props) {
          var fetchPodcasts = props.fetchPodcasts;
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            print(fetchPodcasts);
            fetchPodcasts(id).then(podcasts.set);
          }, [id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency list. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [fetchPodcasts, id]',
              'output': r'''
                final Podcasts = uiFunction<TestProps>((props) {
                  var fetchPodcasts = props.fetchPodcasts;
                  var id = props.id;

                  var podcasts = useState<dynamic>(null);
                  useEffect(() {
                    print(fetchPodcasts);
                    fetchPodcasts(id).then(podcasts.set);
                  }, [fetchPodcasts, id]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Podcasts = uiFunction<TestProps>((props) {
          var fetchPodcasts = props.fetchPodcasts;
          var id = props.id;

          var podcasts = useState<dynamic>(null);
          useEffect(() {
            print(fetchPodcasts);
            fetchPodcasts?.call(id).then(podcasts.set);
          }, [id]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'fetchPodcasts\'. Either include it or remove the dependency list. If \'fetchPodcasts\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [fetchPodcasts, id]',
              'output': r'''
                final Podcasts = uiFunction<TestProps>((props) {
                  var fetchPodcasts = props.fetchPodcasts;
                  var id = props.id;

                  var podcasts = useState<dynamic>(null);
                  useEffect(() {
                    print(fetchPodcasts);
                    fetchPodcasts?.call(id).then(podcasts.set);
                  }, [fetchPodcasts, id]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // The mistake here is that it was moved inside the effect
      // so it can't be referenced in the deps array.
      'code': r'''
        final Thing = uiFunction<TestProps>((_) {
          useEffect(() {
            final fetchData = () async {};
            fetchData();
            // This case specifically involves an undefined name as a result of
            // moving a function (fetchData) into callback.
            // ignore: undefined_identifier
          }, [fetchData]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has an unnecessary dependency: \'fetchData\'. Either exclude it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: []',
              'output': r'''
                final Thing = uiFunction<TestProps>((_) {
                  useEffect(() {
                    final fetchData = () async {};
                    fetchData();
                    // This case specifically involves an undefined name as a result of
                    // moving a function (fetchData) into callback.
                    // ignore: undefined_identifier
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Hello = uiFunction<TestProps>((_) {
          var state = useState(0);
          // In JS, dependencies are optional. In Dart, they're required for only useCallback (this is likely an oversight).
          // ignore: not_enough_positional_arguments
          useEffect(() {
            state.set(1);
          });
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect contains a call to \'state.set\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
          'suggestions': [
            {
              'desc': 'Add dependencies list: []',
              'output': r'''
                final Hello = uiFunction<TestProps>((_) {
                  var state = useState(0);
                  // In JS, dependencies are optional. In Dart, they're required for only useCallback (this is likely an oversight).
                  // ignore: not_enough_positional_arguments
                  useEffect(() {
                    state.set(1);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        Future<dynamic> fetchDataFuture;
        final Hello = uiFunction<TestProps>((_) {
          var data = useState(0);
          useEffect(() {
            fetchDataFuture.then(data.set);
          });
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect contains a call to \'data.set\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [] as a second argument to the useEffect Hook.',
          'suggestions': [
            {
              'desc': 'Add dependencies list: []',
              'output': r'''
                Future<dynamic> fetchDataFuture;
                final Hello = uiFunction<TestProps>((_) {
                  var data = useState(0);
                  useEffect(() {
                    fetchDataFuture.then(data.set);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        Function fetchData;
        final Hello = uiFunction<TestProps>((props) {
          var country = props.country;
          var data = useState(0);
          // In JS, dependencies are optional. In Dart, they're required for only useCallback (this is likely an oversight).
          // ignore: not_enough_positional_arguments
          useEffect(() {
            fetchData(country).then(data.set);
          });
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect contains a call to \'data.set\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [country] as a second argument to the useEffect Hook.',
          'suggestions': [
            {
              'desc': 'Add dependencies list: [country]',
              'output': r'''
                Function fetchData;
                final Hello = uiFunction<TestProps>((props) {
                  var country = props.country;
                  var data = useState(0);
                  // In JS, dependencies are optional. In Dart, they're required for only useCallback (this is likely an oversight).
                  // ignore: not_enough_positional_arguments
                  useEffect(() {
                    fetchData(country).then(data.set);
                  }, [country]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Hello = uiFunction<TestProps>((props) {
          var prop1 = props.prop1;
          var prop2 = props.prop2;

          var state = useState(0);
          useEffect(() {
            if (prop1) {
              state.set(prop2);
            }
          });
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect contains a call to \'state.set\'. Without a list of dependencies, this can lead to an infinite chain of updates. To fix this, pass [prop1, prop2] as a second argument to the useEffect Hook.',
          'suggestions': [
            {
              'desc': 'Add dependencies list: [prop1, prop2]',
              'output': r'''
                final Hello = uiFunction<TestProps>((props) {
                  var prop1 = props.prop1;
                  var prop2 = props.prop2;

                  var state = useState(0);
                  useEffect(() {
                    if (prop1) {
                      state.set(prop2);
                    }
                  }, [prop1, prop2]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Thing = uiFunction<TestProps>((_) {
          useEffect(() async {}, []);
        }, null);
      ''',
      'errors': [
        {
          'message': ""
              "Effect callbacks are synchronous to prevent race conditions. Put the async function inside:\n"
              "\n"
              "useEffect(() {\n"
              "  fetchData() async {\n"
              "    // You can await here\n"
              "    final response = await myAPI.getData(someId);\n"
              "    // ...\n"
              "  }\n"
              "  fetchData();\n"
              "}, [someId]); // Or [] if effect doesn't need props or state\n"
              "\n"
              "Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching",
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Thing = uiFunction<TestProps>((_) {
          useEffect(() async {});
        }, null);
      ''',
      'errors': [
        {
          'message': ""
              "Effect callbacks are synchronous to prevent race conditions. Put the async function inside:\n"
              "\n"
              "useEffect(() {\n"
              "  fetchData() async {\n"
              "    // You can await here\n"
              "    final response = await myAPI.getData(someId);\n"
              "    // ...\n"
              "  }\n"
              "  fetchData();\n"
              "}, [someId]); // Or [] if effect doesn't need props or state\n"
              "\n"
              "Learn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching",
          'suggestions': null,
        },
      ],
    },
    /* 2 test cases previously was removed involving referencing variables inside their initializers, since that it not allowed in Dart */
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          myEffect() {
            print(local);
          }
          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  myEffect() {
                    print(local);
                  }
                  useEffect(myEffect, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final myEffect = () {
            print(local);
          };
          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final myEffect = () {
                    print(local);
                  };
                  useEffect(myEffect, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final myEffect = () {
            print(local);
          };
          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final myEffect = () {
                    print(local);
                  };
                  useEffect(myEffect, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final otherThing = () {
            print(local);
          };
          final myEffect = () {
            otherThing();
          };
          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'otherThing\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [otherThing]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final otherThing = () {
                    print(local);
                  };
                  final myEffect = () {
                    otherThing();
                  };
                  useEffect(myEffect, [otherThing]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        num delay;
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final myEffect = debounce(() {
            print(local);
          }, delay);
          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [myEffect]',
              'output': r'''
                num delay;
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final myEffect = debounce(() {
                    print(local);
                  }, delay);
                  useEffect(myEffect, [myEffect]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        num delay;
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          final myEffect = debounce(() {
            print(local);
          }, delay);
          useEffect(myEffect, [local]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [myEffect]',
              'output': r'''
                num delay;
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = {};
                  final myEffect = debounce(() {
                    print(local);
                  }, delay);
                  useEffect(myEffect, [myEffect]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          var myEffect = props.myEffect;

          useEffect(myEffect, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'myEffect\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [myEffect]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  var myEffect = props.myEffect;

                  useEffect(myEffect, [myEffect]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        num delay;
        final MyComponent = uiFunction<TestProps>((_) {
          final local = {};
          useEffect(debounce(() {
            print(local);
          }, delay), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect received a function whose dependencies are unknown. Pass an inline function instead.',
          'suggestions': [],
        },
      ],
    },
    /* 1 test case previously here was removed around enableDangerousAutofixThisMayCauseInfiniteLoops, which is not applicable in this implementation */
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          dynamic foo;
          useEffect(() {
            foo.bar.baz = 43;
            props.foo.bar.baz = 1;
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'foo.bar\' and \'props.foo.bar\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [foo.bar, props.foo.bar]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  dynamic foo;
                  useEffect(() {
                    foo.bar.baz = 43;
                    props.foo.bar.baz = 1;
                  }, [foo.bar, props.foo.bar]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = {};
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useMemo Hook (at line 3) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (2 cases previously here involving var/let were consolidated into a single case below) */
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = [];
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' List makes the dependencies of useMemo Hook (at line 3) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (1 case previously here involving named functions was removed, since there is no equivalent in Dart) */
    /* (1 case previously here involving class expressions was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Component = uiFunction<TestProps>((props) {
          final foo = props.isEditMode ? {} : "fine";
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 3) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (1 case previously here involving || operator on non-booleans was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          dynamic bar;
          final foo = bar ?? {};
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' binary expression could make the dependencies of useMemo Hook (at line 4) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (1 case previously here involving && operator on non-booleans was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          dynamic bar;
          dynamic baz;
          final foo = bar ? baz ? {} : null : null;
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' conditional could make the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (2 cases previously here involving var/let were consolidated into a single case below) */
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          var foo = {};
          useMemo(() => foo, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useMemo Hook (at line 3) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = {};
          useCallback(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useCallback Hook (at line 5) change on every render. Move it inside the useCallback callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = {};
          useEffect(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useEffect Hook (at line 5) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = {};
          useLayoutEffect(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useLayoutEffect Hook (at line 5) change on every render. Move it inside the useLayoutEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Component = uiFunction<TestProps>((_) {
          final foo = {};
          useImperativeHandle(
            {},
            () {
               print(foo);
            },
            [foo]
          );
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useImperativeHandle Hook (at line 8) change on every render. Move it inside the useImperativeHandle callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((props) {
          final foo = props.section_components?.edges ?? [];
          useEffect(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' binary expression could make the dependencies of useEffect Hook (at line 5) change on every render. Move it inside the useEffect callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = {};
          print(foo);
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useMemo Hook (at line 6) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = Fragment()('Hi!');
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' ReactElement makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = Dom.div()('Hi!');
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' ReactElement makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          var bar;
          final foo = bar = {};
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' assignment expression makes the dependencies of useMemo Hook (at line 6) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (1 cases previously here involving boxed primitives was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = Object();
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Object makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = new Object();
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Object makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    /* (1 cases previously here involving regular expression literals was removed, since there is no equivalent in Dart) */
    /* (1 cases previously here involving class expressions was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = {};
          useLayoutEffect(() {
            print(foo);
          }, [foo]);
          useEffect(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useLayoutEffect Hook (at line 5) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
        {
          'message':
              'The \'foo\' Map makes the dependencies of useEffect Hook (at line 8) change on every render. To fix this, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
  ],
};

// Tests that are only valid/invalid across parsers supporting Flow
final Map<String, List<Map<String, Object>>> testsFlow = {
  'valid': [
    /* 1 test case previously here was remove since generic function types aren't valid as arguments to function calls */
  ],
  'invalid': [
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final dynamic foo = {};
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
  ],
};

// Tests that are only valid/invalid across parsers supporting TypeScript
final Map<String, List<Map<String, Object>>> testsTypescript = {
  'valid': [
    {
      // '''ref''' is still constant, despite the cast.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final ref = useRef() as over_react.Ref<Element>;
          useEffect(() {
            print(ref.current);
          }, []);
        }, null);
      ''',
    },
    /* (2 cases previously here involving typeof references was removed, since there is no equivalent in Dart) */
  ],
  'invalid': [
    {
      // '''local''' is still non-constant, despite the cast.
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final local = ({} as dynamic) as String;
          useEffect(() {
            print(local);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'local\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [local]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final local = ({} as dynamic) as String;
                  useEffect(() {
                    print(local);
                  }, [local]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* (1 case previously here involving typeof references was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          dynamic pizza;
          useEffect(() => ({
            'crust': pizza.crust,
            'toppings': pizza?.toppings,
          }), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has missing dependencies: \'pizza.crust\' and \'pizza?.toppings\'. Either include them or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [pizza.crust, pizza?.toppings]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  dynamic pizza;
                  useEffect(() => ({
                    'crust': pizza.crust,
                    'toppings': pizza?.toppings,
                  }), [pizza.crust, pizza?.toppings]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          dynamic pizza;
          useEffect(() => ({
            'crust': pizza?.crust,
            'density': pizza.crust.density,
          }), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [pizza.crust]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  dynamic pizza;
                  useEffect(() => ({
                    'crust': pizza?.crust,
                    'density': pizza.crust.density,
                  }), [pizza.crust]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          dynamic pizza;
          useEffect(() => ({
            'crust': pizza.crust,
            'density': pizza?.crust.density,
          }), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'pizza.crust\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [pizza.crust]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  dynamic pizza;
                  useEffect(() => ({
                    'crust': pizza.crust,
                    'density': pizza?.crust.density,
                  }), [pizza.crust]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          dynamic pizza;
          useEffect(() => ({
            'crust': pizza?.crust,
            'density': pizza?.crust.density,
          }), []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'pizza?.crust\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [pizza?.crust]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  dynamic pizza;
                  useEffect(() => ({
                    'crust': pizza?.crust,
                    'density': pizza?.crust.density,
                  }), [pizza?.crust]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    // Regression test.
    {
      'code': r'''
        final Example = uiFunction<TestProps>((props) {
          useEffect(() {
            var topHeight = 0;
            topHeight = props.upperViewHeight;
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props.upperViewHeight\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props.upperViewHeight]',
              'output': r'''
                final Example = uiFunction<TestProps>((props) {
                  useEffect(() {
                    var topHeight = 0;
                    topHeight = props.upperViewHeight;
                  }, [props.upperViewHeight]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    // Regression test.
    {
      'code': r'''
        final Example = uiFunction<TestProps>((props) {
          useEffect(() {
            var topHeight = 0;
            topHeight = props?.upperViewHeight;
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'props?.upperViewHeight\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [props?.upperViewHeight]',
              'output': r'''
                final Example = uiFunction<TestProps>((props) {
                  useEffect(() {
                    var topHeight = 0;
                    topHeight = props?.upperViewHeight;
                  }, [props?.upperViewHeight]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          var state = over_react.useState<num>(0);
          useEffect(() {
            final someNumber = 2;
            state.setWithUpdater((prevState) => prevState + someNumber + state.value);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'state.value\'. Either include it or remove the dependency list. You can also do a functional update \'state.setWithUpdater((s) => ...)\' if you only need \'state.value\' in the \'state.setWithUpdater\' call.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [state.value]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  var state = over_react.useState<num>(0);
                  useEffect(() {
                    final someNumber = 2;
                    state.setWithUpdater((prevState) => prevState + someNumber + state.value);
                  }, [state.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    /* (1 case previously here involving typeof references was removed, since there is no equivalent in Dart) */
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((_) {
          final foo = {} as dynamic;
          useMemo(() {
            print(foo);
          }, [foo]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'foo\' Map makes the dependencies of useMemo Hook (at line 5) change on every render. Move it inside the useMemo callback. Alternatively, wrap the initialization of \'foo\' in its own useMemo() Hook.',
          'suggestions': null,
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `.value`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count.value);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': [
            {
              'desc': 'Change the dependency to: count.value',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count.value);
                  }, [count.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses property on `value`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count.value.isEven);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': [
            {
              'desc': 'Change the dependency to: count.value',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count.value.isEven);
                  }, [count.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `value` and property on `value`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count.value);
            print(count.value.isEven);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': [
            {
              'desc': 'Change the dependency to: count.value',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count.value);
                    print(count.value.isEven);
                  }, [count.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `set`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count.set(1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it, and this dependency can be safely removed.',
          'suggestions': [
            {
              'desc': 'Remove the dependency on \'count\'.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    count.set(1);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      // Make sure we don't treat this case as a valid use of the dependency
      'name': 'StateHook as dependency, callback uses cascaded `set` and discards the object',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count..set(1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.',
          'suggestions': null,
        },
      ],
    },
    {
      // Make sure we don't treat this case as a valid use of the dependency
      'name': 'StateHook as dependency, callback uses cascaded `set` and uses the whole object',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count..set(1));
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.',
          'suggestions': null,
        },
      ],
    },
    {
      // This tests:
      // 1. That other dependencies are left alone
      // 2. Removal of the comma after the dependency
      'name': 'StateHook as dependency, callback uses stable setter, and there are other dependencies in the list',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((props) {
          final count = useState(0);
          useEffect(() {
            count.set(1);
            print([props.foo, props.bar]);
          }, [props.foo, count, props.bar]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it, and this dependency can be safely removed.',
          'suggestions': [
            {
              'desc': 'Remove the dependency on \'count\'.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((props) {
                  final count = useState(0);
                  useEffect(() {
                    count.set(1);
                    print([props.foo, props.bar]);
                  }, [props.foo, props.bar]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `setWithUpdater`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count.setWithUpdater((c) => c + 1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.setWithUpdater\' is stable across renders, no dependencies are required to use it, and this dependency can be safely removed.',
          'suggestions': [
            {
              'desc': 'Remove the dependency on \'count\'.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    count.setWithUpdater((c) => c + 1);
                  }, []);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `set` and `setWithUpdater`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count.set(1);
            count.setWithUpdater((c) => c + 1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' and \'count.setWithUpdater\' are stable across renders, no dependencies are required to use them, and this dependency can be safely removed.',
          'suggestions': [
            {
              'desc': 'Remove the dependency on \'count\'.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    count.set(1);
                    count.setWithUpdater((c) => c + 1);
                  }, []);
                }, null);
              ''',
            },
          ],
        }
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `set` and `value`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count.value);
            count.set(0);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': [
            {
              'desc': 'Change the dependency to: count.value',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count.value);
                    count.set(0);
                  }, [count.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses `value` inside `set`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count.set(count.value + 1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': [
            {
              'desc': 'Change the dependency to: count.value',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    count.set(count.value + 1);
                  }, [count.value]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
    {
      'name': 'StateHook as dependency, is unused',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {}, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.',
          'suggestions': [
            {
              'desc': 'Remove the dependency on \'count\'.',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {}, []);
                }, null);
              ''',
            },
          ],
        }
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses whole object',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.',
          'suggestions': null,
        }
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses whole object and `value`',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            print(count.value);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          // TODO(greg) improve the message for this case?
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': null,
        }
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses whole object and stable setter',
      'code': r'''
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            count.set(1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it.',
          'suggestions': null,
        }
      ],
    },
    {
      'name': 'StateHook as dependency, callback uses whole object and `value` and stable setter',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            print(count.value);
            count.set(1);
          }, [count]);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'The \'count\' StateHook (from useState) makes the dependencies of React Hook useEffect change every render, and should not itself be a dependency.'
                  ' Since \'count.set\' is stable across renders, no dependencies are required to use it.'
                  ' Since \'count.value\' is being used, depend on it instead.',
          'suggestions': null,
        }
      ],
    },
    {
      // No special case for this one. Once they add the dependency, they'll get a better message.
      'name': 'StateHook not a dependency, callback uses whole object',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count);
                  }, [count]);
                }, null);
              '''
            }
          ],
        }
      ],
    },
    {
      // No special case for this one. Once they add the dependency, they'll get a better message.
      'name': 'StateHook not a dependency, callback uses whole object and `value`',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            print(count.value);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count);
                    print(count.value);
                  }, [count]);
                }, null);
              '''
            }
          ],
        }
      ],
    },
    {
      'name': 'StateHook not a dependency, callback uses whole object and stable setter',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            count.set(1);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count);
                    count.set(1);
                  }, [count]);
                }, null);
              '''
            }
          ],
        }
      ],
    },
    {
      // No special case for this one. Once they add the dependency, they'll get a better message.
      'name': 'StateHook not a dependency, callback uses whole object and and `value` and stable setter',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count);
            print(count.value);
            count.set(1);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count);
                    print(count.value);
                    count.set(1);
                  }, [count]);
                }, null);
              '''
            }
          ],
        }
      ],
    },
    {
      // This test case is redundant with another test above, but is added among this set of tests for completeness.
      'name': 'StateHook not a dependency, callback uses value and stable setter',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            print(count.value);
            count.set(1);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'count.value\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [count.value]',
              'output': r'''
                final MyComponent = uiFunction<TestProps>((_) {
                  final count = useState(0);
                  useEffect(() {
                    print(count.value);
                    count.set(1);
                  }, [count.value]);
                }, null);
              '''
            }
          ],
        }
      ],
    },
    {
      'name': 'StateHook not a dependency, callback uses cascaded stable setter and discards the object',
      'code': r''' 
        final MyComponent = uiFunction<TestProps>((_) {
          final count = useState(0);
          useEffect(() {
            count..set(1);
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect most likely has issues in its dependencies list, but the exact problems and recommended fixes could not be be computed since the dependency \'count\' is the target of a cascade. Try refactoring to not cascade on that dependency in the callback to get more helpful instructions and potentially a suggested fix.',
          'suggestions': null,
        }
      ],
    },
    {
      'name': 'Generic type parameter referenced inside callback from pure scope',
      'code': r'''
        void useSomething<T>() {
          useEffect(() {
            final items = <T>[];
          }, []);
        }
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'T\'. Either include it or remove the dependency list.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [T]',
              'output': r'''
                void useSomething<T>() {
                  useEffect(() {
                    final items = <T>[];
                  }, [T]);
                }
              '''
            }
          ],
        }
      ]
    },
  ],
};

// Tests that are only valid/invalid for '''@typescript-eslint/parser@4.x'''
final Map<String, List<Map<String, Object>>> testsTypescriptEslintParserV4 = {
  'valid': [],
  'invalid': [
    // TODO(ported):Should also be invalid as part of the JS test suite i.e. be invalid with babel eslint parsers.
    //  It doesn't use any explicit types but any JS is still valid TS.
    {
      'code': r'''
        final Foo = uiFunction<TestProps>((props) {
          var Component = props.Component;

          over_react.useEffect(() {
            print(Component()());
          }, []);
        }, null);
      ''',
      'errors': [
        {
          'message':
              'React Hook useEffect has a missing dependency: \'Component\'. Either include it or remove the dependency list. If \'Component\' changes too often, find the parent component that defines it and wrap that definition in useCallback.',
          'suggestions': [
            {
              'desc': 'Update the dependencies list to be: [Component]',
              'output': r'''
                final Foo = uiFunction<TestProps>((props) {
                  var Component = props.Component;

                  over_react.useEffect(() {
                    print(Component()());
                  }, [Component]);
                }, null);
              ''',
            },
          ],
        },
      ],
    },
  ],
};
