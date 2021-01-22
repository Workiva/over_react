import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

import 'over_react_redux/counter_fn.dart';
import 'over_react_redux/store.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_selector_example.over_react.g.dart';

final counterStore = Store(counterStateReducer, initialState: CounterState());
final bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState());

mixin UseSelectorExampleProps on UiProps {}

UiFactory<UseSelectorExampleProps> UseSelectorExample = uiFunction(
  (props) {
    return (ReduxProvider()..store = counterStore)(
      Dom.h5()('Root Provider:'),
      ModelCounterFn()(),
      (ReduxProvider()
        ..store = bigCounterStore
        ..context = bigCounterContext
      )(
        Dom.h5()('Nested Provider:'),
        CustomContextCounterFn()(props.children),
      ),
    );
  },
  $UseSelectorExampleConfig, // ignore: undefined_identifier
);
