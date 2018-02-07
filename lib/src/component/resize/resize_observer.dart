// Copyright 2016 Workiva Inc.
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

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:resize_observer_polyfill_wrapper/resize_observer_polyfill_wrapper.dart' as ro;

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/resize/resize_props_mixin.dart';

@Factory()
UiFactory<ResizeObserverProps> ResizeObserver;

@Props()
class ResizeObserverProps extends UiProps with ResizeSensorPropsMixin {}

@Component()
class ResizeObserverComponent extends UiComponent<ResizeObserverProps> {
  ro.ResizeObserver _resizeObserver;
  StreamController<ResizeSensorEvent> _resizeObserverStreamController;

  /// The most recently measured value for the rect [_childRef].
  Rectangle _prevRect = new Rectangle(0, 0, 0, 0);

  // Refs

  Element _childRef;

  Element get childRef => _childRef;

  @override
  get consumedProps => const [
    const $Props(ResizeObserverProps),
    const $Props(ResizeSensorPropsMixin),
  ];

  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();

    super.consumedProps;

    _resizeObserverStreamController = new StreamController<ResizeSensorEvent>();

    _resizeObserverStreamController.stream.asBroadcastStream()
      ..take(1).listen((rectangle) {
        if (props.onInitialize != null) props.onInitialize(rectangle);
      })
      ..skip(1).listen((rectangle) {
        if (props.onResize != null) props.onResize(rectangle);
      });
  }

  @override
  void componentDidMount() {
    _resizeObserver = new ro.ResizeObserver(_resizeObserverCallback)
      ..observe(_childRef);
  }

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _resizeObserverStreamController.close();
    _resizeObserverStreamController = null;

    _resizeObserver
      ..unobserve(_childRef)
      ..disconnect();
  }

  @override
  @mustCallSuper
  void validateProps(Map propsMap) {
    super.validateProps(propsMap);

    var tPropsMap = typedPropsFactory(propsMap);

    if (tPropsMap.children.length != 1) {
      throw new PropError.value(tPropsMap.children, 'children', 'ResizeObserver expects a single child.');
    }
  }

  @override
  render() {
    var propsToAdd = domProps()
      ..addProps(copyUnconsumedDomProps())
      ..className = forwardingClassNameBuilder().toClassName()
      ..ref = chainRef(props.children.single, (ref) { _childRef = findDomNode(ref); });

    return cloneElement(props.children.single, propsToAdd);
  }

  void _resizeObserverCallback(List<ro.ResizeObserverEntry> entries, _) {
    for (var entry in entries) {
      if (entry.target == _childRef) {
        var newRect = entry.rectangle;
        var event = new ResizeSensorEvent(newRect.width, newRect.height, _prevRect.width, _prevRect.height);
        _resizeObserverStreamController.add(event);
        _prevRect = newRect;
      }
    }
  }
}

typedef void ResizeCallback(Rectangle rectangle);
