part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestNestedProps> TestNested;

@Props()
class TestNestedProps extends FluxUiProps {}

@Component()
class TestNestedComponent extends FluxUiComponent {
  int renderCount = 0;

  @override
  render() {
    renderCount++;

    var keyCounter = 0;
    var newChildren = props.children.map((child) {
      // The keys are consistent across rerenders, so they aren't remounted,
      // but cloning the element is necessary for react to consider it changed,
      // since it returns new ReactElement instances.
      return cloneElement(child, domProps()..key = keyCounter++);
    }).toList();

    return Dom.div()(newChildren);
  }
}
