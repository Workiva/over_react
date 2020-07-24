// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:over_react/over_react.dart';
import 'package:react/hooks.dart' as react_hooks;

/// Adds local state to a [uiFunction] component
/// by returning a [StateHook] with [StateHook.value] initialized to [initialValue].
///
/// > __Note:__ If the [initialValue] is expensive to compute, [useStateLazy] should be used instead.
///
/// __Example__:
///
/// ```dart
/// UiFactory<UiProps> UseStateExample = uiFunction(
///       (props) {
///     final count = useState(0);
///     return Fragment()(
///       count.value,
///       (Dom.button()..onClick = (_) => count.set(0))('Reset'),
///       (Dom.button()
///         ..onClick = (_) => count.setWithUpdater((prev) => prev + 1))('+'),
///     );
///   },
///   null,
///   displayName: 'UseStateExample',
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-state.html>.
StateHook<T> useState<T>(T initialValue) => react_hooks.useState<T>(initialValue);

/// Adds local state to a [uiFunction] component
/// by returning a [StateHook] with [StateHook.value] initialized to the return value of [init].
///
/// __Example__:
///
/// ```dart
/// UiFactory<UiProps> UseStateExample = uiFunction(
///       (props) {
///     final count = useStateLazy(() {
///       var initialState = someExpensiveComputation(props);
///       return initialState;
///     });
///
///     return Fragment()(
///       count.value,
///       (Dom.button()..onClick = (_) => count.set(0))('Reset'),
///       (Dom.button()..onClick = (_) => count.setWithUpdater((prev) => prev + 1))('+'),
///     );
///   },
///   null,
///   displayName: 'UseStateExample',
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#lazy-initial-state>.
StateHook<T> useStateLazy<T>(T Function() init) => react_hooks.useStateLazy<T>(init);

/// Runs [sideEffect] after every completed render of a [uiFunction] component.
///
/// If [dependencies] are given, [sideEffect] will only run if one of the [dependencies] have changed.
/// [sideEffect] may return a cleanup function that is run before the component unmounts or re-renders.
///
/// > __Note:__ there are two [rules for using Hooks](https://reactjs.org/docs/hooks-rules.html):
/// >
/// > * Only call Hooks at the top level.
/// > * Only call Hooks from inside the first argument of [uiFunction].
///
/// __Example__:
///
/// ```dart
/// UiFactory<UiProps> UseEffectExample = uiFunction(
///       (props) {
///     final count = useState(1);
///     final evenOdd = useState('even');
///
///     useEffect(() {
///       if (count.value % 2 == 0) {
///         evenOdd.set('even');
///       } else {
///         evenOdd.set('odd');
///       }
///       return () {
///         print('count is changing... do some cleanup if you need to');
///       };
///
///       // This dependency prevents the effect from running every time [evenOdd.value] changes.
///     }, [count.value]);
///
///     return Fragment()(
///       Dom.p()('${count.value} is ${evenOdd.value}'),
///       (Dom.button()..onClick = (_) => count.set(count.value + 1))('+'),
///     );
///   },
///   null,
///   displayName: 'UseEffectExample',
/// );
/// ```
///
/// See: <https://reactjs.org/docs/hooks-effect.html#tip-optimizing-performance-by-skipping-effects>.
void useEffect(dynamic Function() sideEffect, [List<Object> dependencies]) => react_hooks.useEffect(sideEffect, dependencies);

/// Initializes state of a [uiFunction] component to [initialState] and creates [ReducerHook.dispatch] method.
///
/// __Example__:
///
/// ```dart
/// Map reducer(Map state, Map action) {
///   switch (action['type']) {
///     case 'increment':
///       return {...state, 'count': state['count'] + 1};
///     case 'decrement':
///       return {...state, 'count': state['count'] - 1};
///     default:
///       return state;
///   }
/// }
///
/// UiFactory<UiProps> UseReducerExample = uiFunction(
///       (props) {
///     final state = useReducer(reducer, {'count': 0});
///
///     return Fragment()(
///       state.state['count'],
///       (Dom.button()
///         ..onClick = (_) => state.dispatch({'type': 'increment'}))('+'),
///       (Dom.button()
///         ..onClick = (_) => state.dispatch({'type': 'decrement'}))('-'),
///     );
///   },
///   null,
///   displayName: 'UseReducerExample',
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#usereducer>.
ReducerHook<TState, TAction, TInit> useReducer<TState, TAction, TInit>(
    TState Function(TState state, TAction action) reducer, TState initialState) =>
    react_hooks.useReducer(reducer, initialState);

/// Initializes state of a [uiFunction] component to [init(initialArg)] and creates [ReducerHook.dispatch] method.
///
/// __Example__:
///
/// ```dart
/// Map initializeCount(int initialValue) {
///   return {'count': initialValue};
/// }
///
/// Map reducer(Map state, Map action) {
///   switch (action['type']) {
///     case 'increment':
///       return {...state, 'count': state['count'] + 1};
///     case 'decrement':
///       return {...state, 'count': state['count'] - 1};
///     case 'reset':
///       return initializeCount(action['payload']);
///     default:
///       return state;
///   }
/// }
///
/// mixin UseReducerExampleProps on UiProps {
///   int initialCount;
/// }
///
/// UiFactory<UseReducerExampleProps> UseReducerExample = uiFunction(
///       (props) {
///     final ReducerHook<Map, Map, int> state =
///     useReducerLazy(reducer, props.initialCount, initializeCount);
///
///     return Fragment()(
///       state.state['count'],
///       (Dom.button()
///         ..onClick = (_) => state.dispatch({'type': 'increment'}))('+'),
///       (Dom.button()
///         ..onClick = (_) => state.dispatch({'type': 'decrement'}))('-'),
///       (Dom.button()
///         ..onClick = (_) => state.dispatch({
///           'type': 'reset',
///           'payload': props.initialCount,
///         }))('reset'),
///     );
///   },
///   $UseReducerExampleConfig, // ignore: undefined_identifier
///   displayName: 'UseReducerExample',
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#lazy-initialization>.
ReducerHook<TState, TAction, TInit> useReducerLazy<TState, TAction, TInit>(
    TState Function(TState state, TAction action) reducer, TInit initialArg, TState Function(TInit) init) =>
    react_hooks.useReducerLazy(reducer, initialArg, init);

/// Returns a memoized version of [callback] that only changes if one of the [dependencies] has changed.
///
/// > __Note:__ there are two [rules for using Hooks](https://reactjs.org/docs/hooks-rules.html):
/// >
/// > * Only call Hooks at the top level.
/// > * Only call Hooks from inside the first argument of [uiFunction].
///
/// __Example__:
///
/// ```dart
/// UiFactory<UiProps> UseCallbackExample = uiFunction(
///       (props) {
///     final count = useState(0);
///     final delta = useState(1);
///
///     var increment = useCallback((_) {
///       count.setWithUpdater((prev) => prev + delta.value);
///     }, [delta.value]);
///
///     var incrementDelta = useCallback((_) {
///       delta.setWithUpdater((prev) => prev + 1);
///     }, []);
///
///     return Fragment()(
///       Dom.div()('Delta is ${delta.value}'),
///       Dom.div()('Count is ${count.value}'),
///       (Dom.button()..onClick = increment)('Increment count'),
///       (Dom.button()..onClick = incrementDelta)('Increment delta'),
///     );
///   },
///   null,
///   displayName: 'UseCallbackExample',
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#usecallback>.
T useCallback<T extends Function>(T callback, List dependencies) => react_hooks.useCallback(callback, dependencies);

/// Returns the value of the nearest [Context.Provider] for the provided [context] object every time that context is
/// updated.
///
/// The usage is similar to that of a [Context.Consumer] in that the return type of [useContext] is dependent upon
/// the typing of the value passed into [createContext] and [Context.Provider].
///
/// > __Note:__ there are two [rules for using Hooks](https://reactjs.org/docs/hooks-rules.html):
/// >
/// > * Only call Hooks at the top level.
/// > * Only call Hooks from inside the first argument of [uiFunction].
///
/// __Example__:
///
/// ```dart
/// Context countContext = createContext(0);
///
/// UseCallbackTestComponent(Map props) {
///   final count = useContext(countContext);
///
///   return react.div({}, [
///     react.div({}, ['The count from context is $count']), // initially renders: 'The count from context is 0'
///   ]);
/// }
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#usecontext>.
T useContext<T>(Context<T> context) => react_hooks.useContext(context.reactDartContext);

/// Returns a mutable [Ref] object with [Ref.current] property initialized to [initialValue].
///
/// Changes to the [Ref.current] property do not cause the containing [DartFunctionComponent] to re-render.
///
/// The returned [Ref] object will persist for the full lifetime of the [DartFunctionComponent].
/// Compare to [createRef] which returns a new [Ref] object on each render.
///
/// > __Note:__ there are two [rules for using Hooks](https://reactjs.org/docs/hooks-rules.html):
/// >
/// > * Only call Hooks at the top level.
/// > * Only call Hooks from inside a [DartFunctionComponent].
///
/// __Example__:
///
/// ```dart
/// UseRefTestComponent(Map props) {
///   final inputValue = useState('');
///
///   final inputRef = useRef<InputElement>();
///   final prevInputValueRef = useRef<String>();
///
///   useEffect(() {
///     prevInputValueRef.current = inputValue.value;
///   });
///
///   return react.Fragment({}, [
///     react.p({}, ['Current Input: ${inputValue.value}, Previous Input: ${prevInputValueRef.current}']),
///     react.input({'ref': inputRef}),
///     react.button({'onClick': (_) => inputValue.set(inputRef.current.value)}, ['Update']),
///   ]);
/// }
/// ```
///
/// Learn more: <https://reactjs.org/docs/hooks-reference.html#useref>.
Ref<T> useRef<T>([T initialValue]) => Ref.useRefInit(initialValue);
