import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'test_component.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test =
    // ignore: undefined_identifier
    _$Test;

@Props()
class _$TestProps extends UiProps {
  LifecycleCallback onComponentDidMount;
  LifecycleCallback onComponentWillUpdate;
  LifecycleCallback onComponentWillReceiveProps;
  LifecycleCallback onComponentDidUpdate;
  LifecycleCallback onComponentWillUnmount;
  LifecycleCallback onRender;
}

@Component(isWrapper: true)
class TestComponent extends UiComponent<TestProps> {
  @override
  componentDidMount() {
    props.onComponentDidMount?.call();
  }

  @override
  componentDidUpdate(prevProps, prevState) {
    props.onComponentDidUpdate?.call();
  }
  @override
  componentWillUpdate(nextProps, nextState) {
    typedPropsFactory(nextProps).onComponentWillUpdate?.call();
  }
  @override
  componentWillReceiveProps(nextProps) {
    super.componentWillReceiveProps(nextProps);
    typedPropsFactory(nextProps).onComponentWillReceiveProps?.call();
  }
  @override
  componentWillUnmount() {
    super.componentWillUnmount();
    typedPropsFactory(nextProps).onComponentWillUnmount?.call();
  }

  @override
  render() {
    props.onRender?.call();
    return (Dom.div()..addProps(copyUnconsumedProps()))(props.children);
  }
}

typedef void LifecycleCallback();

class TestProps extends _$TestProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$TestPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestProps;
}
