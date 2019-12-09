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
}, $.$basicConfig, (statics) {
  statics.defaultProps = (statics.newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1'
  );
});



final Simple = uiFunctionComponent<BasicPropsMixin>((props) {
  return Dom.div()(props.basicProp);
}, $.$basicConfig);

//UiFactory<BasicPropsMixin> Basic2 = (BasicPropsMixin props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.withTypedProps($.$Basic.factoryFactory);
//
//
//
//UiFactory<BasicPropsMixin> Basic5 = (BasicPropsMixin props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.asFunctionComponent();
//
//
//UiFactory<BasicPropsMixin> Basic3 = functionBuilder<BasicPropsMixin>().function((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.asFunctionComponent();
//


//extension on ReactDartFunctionComponentFactoryProxy {
//  UiFactory<T> withTypedProps<T extends UiProps>(FunctionFactoryFactory<T> factoryFactory) {
//    return factoryFactory(this);
//  }
//  UiFactory<T> withTypedPropsFromOtherFactory<T extends UiProps>(UiFactory<T> otherFactory) {
//    T uiFactory([Map backingProps]) => otherFactory(backingProps)..componentFactory = this;
//    return uiFactory;
//  }
//}

ReactElement functionComponentContent() {
  final genericFactory = uiFunctionComponent<UiProps>((props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
    );
  }, FunctionComponentConfig(displayName: 'genericFactory'));

  final basicFactory = uiFunctionComponent((props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('prop basic1: ${props.basic1}'),
    );
  }, $.$basicConfig);

//  final basicFactory3 = uiFunctionComponent<BasicPropsMixin>((props) {
//    return Dom.div()(
//      Dom.div()('prop id: ${props.id}'),
//      Dom.div()('prop basic1: ${props.basic1}'),
//    );
//  }, factoryFactory: $.$Basic.factoryFactory);

  return Fragment()(
    (genericFactory()..id = '1')(),
    (basicFactory()..id = '2'..basic1 = 'basic1 value')(),
    (Basic()..id = '3'..basicProp = 'basicProp')(),
    (Simple()..basicProp = 'basicProp'),
  );
}


UiFactory<T> uiFunctionComponent<T extends UiProps>(
  dynamic Function(T props) functionComponent, [
  // FIXME allow passing in displayName for generic function components
  FunctionComponentConfig<T> config,
//  PropsFactory<T> propsFactory,
//  String displayName,
  void Function(UiFunctionComponentStatics<T>) initStatics,
]) {
//  if (config != null) {
//    if (propsFactory != null) throw ArgumentError('factoryFactory cannot be used along with fromGenerated');
//    if (displayName != null) throw ArgumentError('displayName cannot be used along with fromGenerated');
//  } else {
//    propsFactory = config.propsFactory;
//    displayName = config.displayName;
//  }
  final propsFactory = config.propsFactory;
  final displayName = config.displayName;

  // todo attempt to set a JS name on this
  dynamic typedFunctionComponentWrapper(Map props) {
    return functionComponent(propsFactory.jsMap(props as JsBackedMap));
  }

  /// FIXME DartFunctionComponent should be JsBackedMap?
  final factory = react.registerFunctionComponent(typedFunctionComponentWrapper,
      displayName: displayName);

//  if (propsFactory == null) {
//    // todo allow passing in of custom uiFactory/typedPropsFactory
//    // TODO make it easier to pass in parts of generatedInfo
//    if (T != UiProps && T != GenericUiProps) {
//      throw ArgumentError('generatedInfo must be provided when using custom props classes');
//    }
//    propsFactory = PropsFactory.fromUiFactory(([backingMap]) => GenericUiProps(factory, backingMap)) as PropsFactory<T>;
//  }

  if (initStatics != null) {
    final statics = UiFunctionComponentStatics<T>._(
      newProps: () => propsFactory.jsMap(JsBackedMap()),
      keyFor: (accessProps) => getPropKey(accessProps, propsFactory.map)
    );
    initStatics(statics);

    if (statics.defaultProps != null) {
      // fixme need to move to react-dart
      (factory.reactFunction as ReactClass).defaultProps = JsBackedMap.from(statics.defaultProps).jsObject;
    }
    // fixme need to implement in react-dart
//    if (statics.propTypes != null) {}
  }

  T _uiFactory([Map backingMap]) {
    if (backingMap == null) return propsFactory.jsMap(JsBackedMap());
    if (backingMap is JsBackedMap) return propsFactory.jsMap(backingMap);
    return propsFactory.map(backingMap);
  }
  return _uiFactory;
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
class FunctionComponentConfig<T extends UiProps> {
  @protected
  final PropsFactory<T> propsFactory;
  final String displayName;

  @protected
  FunctionComponentConfig({this.propsFactory, this.displayName});
}

class PropsFactory<T extends UiProps> {
  final T Function(Map props) map;
  final T Function(JsBackedMap props) jsMap;

  PropsFactory(this.map, this.jsMap);

  PropsFactory.fromUiFactory(UiFactory<T> factory) : this.map = factory, this.jsMap = factory;
}
