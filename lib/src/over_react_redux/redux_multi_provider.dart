import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:redux/redux.dart';

// ignore: uri_has_not_been_generated
part 'redux_multi_provider.over_react.g.dart';

@Factory()
UiFactory<ReduxMultiProviderProps> ReduxMultiProvider =
    // ignore: undefined_identifier
    _$ReduxMultiProvider;

@Props()
class _$ReduxMultiProviderProps extends UiProps {
  Map<Context, Store> storesByContext;
}

@Component2()
class ReduxMultiProviderComponent extends UiComponent2<ReduxMultiProviderProps> {
  @override
  render() {
    dynamic content = props.children;
    props.storesByContext.forEach((context, store) {
      content = (ReduxProvider()
        ..store = store
        ..context = context
      )(content);
    });
    return content;
  }
}
