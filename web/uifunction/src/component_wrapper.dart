import 'dart:html';
import 'dart:js_util';
import 'dart:math';

import 'package:over_react/over_react.dart';

part 'component_wrapper.over_react.g.dart';

final containerStyles = {
  'position': 'relative',
  'border': '2px solid #ddd',
  'padding': '20px',
  'borderRadius': '5px',
  'backgroundColor': '#1a191c',
  'color': '#e7e9ec',
  'WebkitFontSmoothing': 'antialiased',
  'MozOsxFontSmoothing': 'grayscale',
};

UiFactory<T> createVisualComponent<T extends UiProps>(UiFactory<T> otherFactory, {Set<Type> excludedMixins = const {}, bool domOnly = false}) {
  final blankFactoryProps = otherFactory();
  final blankFactoryReactElement = blankFactoryProps();
  final componentName = getProperty(blankFactoryProps?.componentFactory, 'displayName') ?? getReactElementDisplayName(blankFactoryReactElement);
  UiFactory<T> VisualComponentHoc = uiFunction(
    (props) {
      var isDomComponent = true;
      List<String> consumedPropKeys = [];
      final consumedPropKeysForToForward = [];
      if (props is! DomProps) {
        isDomComponent = false;
        final consumedProps = props.staticMeta.forMixins(excludedMixins ?? {T});
        consumedPropKeys = consumedProps.map((v) => v.keys).expand((i) => i).toList();
        consumedPropKeysForToForward.addAll(consumedPropKeys);
      }
      props.removeWhere((key, value) => consumedPropKeysForToForward.contains(key));
      final componentElement = (otherFactory()..addProps(props))(props.children) as ReactElement;
      window.console.log(componentElement);
      return Dom.div()(
        (Dom.div()..className = 'component-container'..style = containerStyles)(
          (Dom.span()
            ..className = 'rerender'
            ..key=Random().nextInt(1000000)
            ..style = {
              'position':'absolute',
              'left': '1.25rem',
              'top': '0.5rem',
              'color': 'EE0000',
              'fontWeight': 'bold',
              'fontSize': 'smaller',
            }
          )(
            'RENDER'
          ),
          (Dom.span()..className = 'component-name'..style = {'fontWeight': 'bold', 'paddingBottom': '10px', 'fontSize': '2rem'})(componentName),
          //(MapDisplay()..name = 'STATE'..backgroundColor = '#2A8300'..mapToDisplay = Map.from(componentElement.))(),
          (MapDisplay()
            ..name = 'CONSUMED PROPS'
            ..backgroundColor = '#2A8300'
            ..mapToDisplay = (Map.from(props)..removeWhere((key, value) => !(consumedPropKeys?.contains(key) ?? true))..remove('children'))
          )(),
          (MapDisplay()
            ..name = isDomComponent ? 'CONSUMED PROPS' : 'PROPS TO FORWARD'
            ..backgroundColor = isDomComponent ? '#2A8300' : '#1c4498'
            ..mapToDisplay = (JsBackedMap.fromJs(componentElement.props)
              ..removeWhere((key, value) => consumedPropKeysForToForward.contains(key))
              ..remove('children'))
          )(),
          (Dom.div()..className = 'component-render')(componentElement),
        ),
      );
    },
    UiFactoryConfig(
      displayName: 'VisualComponentHoc($componentName)',
      propsFactory: PropsFactory.fromUiFactory(otherFactory),
    ),
  );

  return VisualComponentHoc;
}

String getReactElementDisplayName(ReactElement element) {
  final elementType = element?.type;
  final elementTypeName = getProperty(elementType, 'name');
  if (elementType != null && elementType is String) {
    return elementType;
  } else if (elementTypeName != null && elementTypeName is String) {
    return elementTypeName;
  }
  return 'Anonymous';
}

mixin MapDisplayPropsMixin on UiProps {
  String name;
  String backgroundColor;
  Map mapToDisplay;
}

final MapDisplay = uiFunction<MapDisplayPropsMixin>((props) {
  final backgroundColor = props.backgroundColor ?? '#2070f3';
  final name = props.name ?? 'PROPS';
  final mapToDisplay = props.mapToDisplay ?? {};

  if (mapToDisplay.isEmpty) {
    return null;
  }

  final mapDisplay = [];

  mapToDisplay.forEach((key, value) {
    mapDisplay.add((Dom.div()..className = 'prop-entry'..key = '$key')('$key: $value'));
  });

  return (Dom.div()
    ..className = 'prop-list-container'
    ..style = {
      'backgroundColor': backgroundColor,
      'display': 'flex',
      'borderRadius': '5px',
      'overflow': 'hidden',
      'marginBottom': '10px',
      'position': 'relative',
    }
  )(
    (Dom.span()
      ..className = 'prop-list-name'
      ..style = const {
        'padding': '10px',
        'alignItems': 'center',
        'justifyContent': 'center',
        'display': 'flex',
        'color': 'rgba(255, 255, 255, .75)',
        'fontWeight': 'bold',
        'fontSize': 'smaller',
      }
    )(name),
    (Dom.div()
      ..id = 'prop-entries-container'
      ..style = const {
        'position': 'relative',
        'padding': '10px',
        'fontWeight': '400',
        'fontFamily': 'Fira Code',
        'flex': '1',
      }
    )(
      (Dom.div()
        ..id = 'prop-entries-light-background'
        ..style = const {
          'width': '100%',
          'height': '100%',
          'position': 'absolute',
          'top': 0,
          'left': 0,
          'background': '#b7b7b7',
          'mixBlendMode': 'soft-light',
          'opacity': '.75',
        }
      )(),
      mapDisplay,
    ),
  );
}, _$MapDisplayConfig);
