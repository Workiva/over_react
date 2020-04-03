import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:redux/redux.dart';

part 'redux_multi_provider.over_react.g.dart';

/// An HOC that can be used to wrap a component tree with multiple [ReduxProvider]s
/// without manually nesting providers manually.
///
/// __Example:__
/// ```dart
/// import 'package:react/react_dom.dart' as react_dom;
///
/// react_dom.render(
///     // Note the use of the `ReduxMultiProvider` as opposed to a traditional
///     // `ReduxProvider`, and that the stores being passed in are the
///     // `FluxToReduxAdapterStore`s.
///     (ReduxMultiProvider()
///       ..storesByContext = {
///         randomColorStoreContext: randomColorStoreAdapter,
///         lowLevelStoreContext: lowLevelStoreAdapter,
///         anotherColorStoreContext: anotherColorStoreAdapter,
///       }
///     )(
///       // Note that when being wrapped with `connect`, these components can
///       // each reference a context included in `storesByContext`.
///       ConnectFluxBigBlock()(),
///       ReduxBigBlock()(),
///       ShouldNotUpdate()(),
///     ),
///     querySelector('#content'));
/// ```
@Factory()
UiFactory<ReduxMultiProviderProps> ReduxMultiProvider =
    // ignore: undefined_identifier
    _$ReduxMultiProvider;

@Props()
class _$ReduxMultiProviderProps extends UiProps {
  /// A `Map` of contexts that connected components within the component tree
  /// can use to receive updates from specific stores.
  ///
  /// Each context and store instance should be unique. Referencing the context
  /// in a connected component is exactly the same as it would with a standard
  /// [ReduxProvider].
  @requiredProp
  Map<Context, Store> storesByContext;
}

@Component2()
class ReduxMultiProviderComponent
    extends UiComponent2<ReduxMultiProviderProps> {
  @override
  get propTypes => {
        keyForProp((p) => p.storesByContext): (props, info) {
          if (props.storesByContext != null && props.storesByContext.isEmpty) {
            return PropError.value(
                props.storesByContext, info.propName, 'It must not be empty');
          }
          return null;
        }
      };

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
