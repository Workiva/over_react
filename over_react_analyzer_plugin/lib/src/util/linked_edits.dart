import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

void _addUiComponentBoilerplateFactory(DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..writeln('// UNCOMMENT THE PART DIRECTIVE WHEN MOVING TO ITS OWN FILE')
    ..writeln('// ignore: uri_has_not_been_generated')
    ..writeln("// part '<the_extracted_component_file_name>.over_react.g.dart';")
    ..writeln('');

  builder
    ..write('/// TODO: Provide a brief explanation of what the ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write(' component does / renders.\n')
    ..writeln('@Factory()')
    ..write('UiFactory<')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props> ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write(' = _\$')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write(';')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateProps(DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..writeln('@Props()')
    ..write('class _\$')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props extends UiProps {}')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateFluxProps(DartEditBuilder builder, {
  String groupName = 'orFlux',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..writeln('@Props()')
    ..write('class _\$')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props extends FluxUiProps<')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Actions, ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Store')
    ..write('> {}')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateState(DartEditBuilder builder, {
  String groupName = 'orStful',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..writeln('@State()')
    ..write('class _\$')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('State extends UiState {}')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateComponent(DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
  String baseComponentClassName = 'UiComponent',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  String componentRenderReturnValueSrc;
  if (getComponentRenderReturnValueSrc != null) {
    componentRenderReturnValueSrc = getComponentRenderReturnValueSrc(indent: 4);
  }

  builder
    ..writeln('@Component()')
    ..write('class ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Component extends $baseComponentClassName<')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props');

  if (baseComponentClassName.contains('Stateful')) {
    builder
      ..write(', ')
      ..addSimpleLinkedEdit(groupName, componentFactoryName)
      ..write('State');
  }

  builder
    ..write('> {')
    ..writeln('')
    ..writeln('  @override')
    ..writeln('  Map getDefaultProps() => (newProps());')
    ..writeln('');

  if (baseComponentClassName.contains('Stateful')) {
    builder
      ..writeln('  @override')
      ..writeln('  Map getInitialState() => (newState());')
      ..writeln('');
  }

  builder
    ..writeln('  @override')
    ..writeln('  render() {')
    ..write(  '    return $componentRenderReturnValueSrc;')
    ..writeln('')
    ..writeln('  }')
    ..writeln('}');
}

void addUiComponentBoilerplateLinkedEdit(DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder, groupName: groupName, componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addUiStatefulComponentBoilerplateLinkedEdit(DartEditBuilder builder, {
  String groupName = 'orStful',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateState(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder, groupName: groupName, baseComponentClassName: 'UiStatefulComponent',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addFluxUiComponentBoilerplateLinkedEdit(DartEditBuilder builder, {
  String groupName = 'orFlux',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateFluxProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder, groupName: groupName, baseComponentClassName: 'FluxUiComponent',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addFluxUiStatefulComponentBoilerplateLinkedEdit(DartEditBuilder builder, {
  String groupName = 'orFluxStful',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateFluxProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateState(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder, groupName: groupName, baseComponentClassName: 'FluxUiStatefulComponent',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}
