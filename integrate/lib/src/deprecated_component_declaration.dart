part of deprecated_component_declaration;

FooDefinition Foo() => new FooDefinition({});

@GenerateProps(#FooProps)
class FooDefinition extends BaseComponentDefinition with FooProps {
  FooDefinition(Map props) : super(_FooComponentFactory, props);
}

ReactComponentFactory _FooComponentFactory = registerComponent(() => new _Foo());
class _Foo extends BaseComponent<FooDefinition> {
  @override
  render() {
    return Button()(
      'Child 1',
      'Child 2'
    );
  }

  @override
  FooDefinition typedPropsFactory(Map propsMap) => new FooDefinition(propsMap);
}
