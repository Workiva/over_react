
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';

class Context {
  Context(this.Provider, this.Consumer, this._jsThis);
  final ReactContext _jsThis;

  /// Every [ReactDartContext] object comes with a Provider component that allows consuming components to subscribe
  /// to context changes.
  ///
  /// Accepts a `value` prop to be passed to consuming components that are descendants of this [Provider].
  final UiFactory<ProviderProps> Provider;

  /// A React component that subscribes to context changes.
  /// Requires a function as a child. The function receives the current context value and returns a React node.
  final UiFactory<ConsumerProps> Consumer;
  ReactContext get jsThis => _jsThis;
}

class ProviderProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ProviderProps(JsBackedMap backingMap)
      : this._props = new JsBackedMap() {
    this._props = backingMap ?? new JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;

  @override
  String get propKeyNamespace => '';

  dynamic get value => props['value'];
  set value(dynamic v) => props['value'] = v;
}

class ConsumerProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ConsumerProps([Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}

Context createContext([dynamic defaultValue, int Function(dynamic, dynamic) calculateChangedBits]) {
  react_client.ReactDartContext reactDartContext = react_client.createContext(defaultValue, calculateChangedBits);
  UiFactory<ProviderProps> Provider = ([map]) => (new ProviderProps(map)..componentFactory = reactDartContext.Provider);
  UiFactory<ConsumerProps> Consumer = ([map]) => (new ConsumerProps(map)..componentFactory = reactDartContext.Consumer);
  return Context(Provider, Consumer, reactDartContext.jsThis);
}

