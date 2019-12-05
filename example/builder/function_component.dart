import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/react_interop.dart';

// ignore_for_file: uri_has_not_been_generated
import 'function_component.example.over_react.g.dart' as $;

mixin BasicPropsMixin on UiProps {
  @requiredProp
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

UiFactory<BasicPropsMixin> Basic = uiFunctionComponent((props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, $.$Basic, (statics) {
  statics.defaultProps = (statics.newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1'
  );
});

ReactElement functionComponentContent() {
  final genericFactory = uiFunctionComponent((props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
    );
  });

  final basicFactory = uiFunctionComponent<BasicPropsMixin>((props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('prop basic1: ${props.basic1}'),
    );
  }, $.$Basic);

  return Fragment()(
    (genericFactory()..id = '1')(),
    (basicFactory()..id = '2'..basic1 = 'basic1 value')(),
    (Basic()..id = '3'..basicProp = 'basicProp')(),
  );
}

UiFactory<T> uiFunctionComponent<T extends UiProps>(
  dynamic Function(T props) functionComponent, [
  // FIXME allow passing in displayName for generic function components
  GeneratedFunctionInfo<T> generatedInfo,
  void Function(UiFunctionComponentStatics<T>) initStatics,
]) {
  UiFactory<T> uiFactory;
  T Function(JsBackedMap) typedPropsFactoryJs;

  // todo attempt to set a JS name on this
  dynamic typedFunctionComponentWrapper(Map props) {
    return functionComponent(typedPropsFactoryJs(props as JsBackedMap));
  }

  /// FIXME DartFunctionComponent should be JsBackedMap?
  final factory = react.registerFunctionComponent(typedFunctionComponentWrapper,
      displayName: generatedInfo?.displayName);

  if (generatedInfo != null) {
    uiFactory = generatedInfo.factoryFactory(factory);
  } else {
    // todo allow passing in of custom uiFactory/typedPropsFactory
    // TODO make it easier to pass in parts of generatedInfo
    if (T != UiProps && T != GenericUiProps) {
      throw ArgumentError('generatedInfo must be provided when using custom props classes');
    }
    GenericUiProps genericFactory([Map backingMap]) => GenericUiProps(factory, backingMap);
    uiFactory = genericFactory as UiFactory<T>;
  }

  // todo optimize this so there isn't an extra null check
  typedPropsFactoryJs = uiFactory;

  if (initStatics != null) {
    final statics = UiFunctionComponentStatics<T>._(
      newProps: () => uiFactory(),
      keyFor: (accessProps) => getPropKey(accessProps, uiFactory)
    );
    initStatics(statics);

    if (statics.defaultProps != null) {
      // fixme need to move to react-dart
      (factory.reactFunction as ReactClass).defaultProps = JsBackedMap.from(statics.defaultProps).jsObject;
    }
    // fixme need to implement in react-dart
//    if (statics.propTypes != null) {}
  }

  return uiFactory;
}

class UiFunctionComponentStatics<T> {
  Map defaultProps;
  Map<String, react.PropValidator<T>> propTypes;

  final String Function(void Function(T) accessProps) keyFor;
  final T Function() newProps;

  UiFunctionComponentStatics._({this.keyFor, this.newProps});
//
//  T newProps() => this._newProps();
//
//  String keyFor(void Function(T) accessProps) => this._keyFor(accessProps);

}

class GenericUiProps extends UiProps {
  @override
  final Map props;

  GenericUiProps(ReactComponentFactoryProxy componentFactory, [Map props]) :
        this.props = props ?? JsBackedMap() {
    this.componentFactory = componentFactory;
  }

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

typedef FunctionFactoryFactory<T extends UiProps> = UiFactory<T> Function(ReactDartFunctionComponentFactoryProxy);


@protected
class GeneratedFunctionInfo<T extends UiProps> {
  @protected
  final FunctionFactoryFactory<T> factoryFactory;
  final String displayName;

  @protected
  GeneratedFunctionInfo({this.factoryFactory, this.displayName});
}
