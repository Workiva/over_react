import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react.dart';

part 'redux_provider.over_react.g.dart';



//ReactDartContext ReduxContext = createContext('redux_context');

// TODO wrap Provider, create adapter so react-redux can subscribe to Dart store
@Factory()
UiFactory<ReduxProviderProps> ReduxProvider = _$ReduxProvider;


@Props()
class _$ReduxProviderProps extends UiProps {
  Store store;
}

@State()
class _$ReduxProviderState extends UiState {}

@Component2()
class ReduxProviderComponent<T extends ReduxProviderProps, S extends
ReduxProviderState> extends
UiStatefulComponent2<T, S> {
//  @override
//  final contextType = ReduxContext;

  @override
  render() {
    return null;
//    return ReduxContext.Provider(react.span(props.children));
  }
}