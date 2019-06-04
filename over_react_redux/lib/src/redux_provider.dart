import 'package:meta/meta.dart';
import 'package:react/react.dart' as react;
import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';

part 'redux_provider.over_react.g.dart';

// TODO wrap Provider, create adapter so react-redux can subscribe to Dart store
@Factory()
UiFactory<ReduxProviderProps> ReduxProvider = _$ReduxProvider;



@Props()
class _$ReduxProviderProps extends UiProps {
  Store store;
}
ReactDartContext ReduxContext = createContext('redux_context');

@Component2()
class ReduxProviderComponent extends UiComponent2<ReduxProviderProps> {
  @override
  final contextType = ReduxContext;

  @override
  render() {
    return ReduxContext.Provider(react.span(props.children));
  }
}