import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

void _addUiComponentBoilerplateFactory(
  DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..write('/// TODO: Provide a brief explanation of what the ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write(' component does / renders.\n')
    ..write('UiFactory<')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props> ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write(' = _\$')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('; // ignore: undefined_identifier')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateProps(
  DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..write('mixin ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props on UiProps {}')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateFluxProps(
  DartEditBuilder builder, {
  String groupName = 'orFlux',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..write('mixin ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('PropsMixin on UiProps {}')
    ..writeln('')
    ..writeln('')
    ..write('class ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Props = UiProps with FluxUiPropsMixin<')
    ..write('Actions, ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('Store')
    ..write('>, ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('PropsMixin')
    ..write(';')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateState(
  DartEditBuilder builder, {
  String groupName = 'orStful',
  String componentFactoryName = 'Foo',
}) {
  builder
    ..write('mixin ')
    ..addSimpleLinkedEdit(groupName, componentFactoryName)
    ..write('State on UiState {}')
    ..writeln('')
    ..writeln('');
}

void _addUiComponentBoilerplateComponent(
  DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
  String baseComponentClassName = 'UiComponent2',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  String componentRenderReturnValueSrc;
  if (getComponentRenderReturnValueSrc != null) {
    componentRenderReturnValueSrc = getComponentRenderReturnValueSrc(indent: 4);
  }

  builder
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
    ..writeln('  get defaultProps => (newProps());')
    ..writeln('');

  if (baseComponentClassName.contains('Stateful')) {
    builder..writeln('  @override')..writeln('  get initialState => (newState());')..writeln('');
  }

  builder
    ..writeln('  @override')
    ..writeln('  render() {')
    ..write('    return $componentRenderReturnValueSrc;')
    ..writeln('')
    ..writeln('  }')
    ..writeln('}');
}

void addUiComponentBoilerplateLinkedEdit(
  DartEditBuilder builder, {
  String groupName = 'orStless',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder,
      groupName: groupName,
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addUiStatefulComponentBoilerplateLinkedEdit(
  DartEditBuilder builder, {
  String groupName = 'orStful',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateState(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder,
      groupName: groupName,
      baseComponentClassName: 'UiStatefulComponent2',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addFluxUiComponentBoilerplateLinkedEdit(
  DartEditBuilder builder, {
  String groupName = 'orFlux',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateFluxProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder,
      groupName: groupName,
      baseComponentClassName: 'FluxUiComponent2',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}

void addFluxUiStatefulComponentBoilerplateLinkedEdit(
  DartEditBuilder builder, {
  String groupName = 'orFluxStful',
  String componentFactoryName = 'Foo',
  String Function({int indent}) getComponentRenderReturnValueSrc,
}) {
  _addUiComponentBoilerplateFactory(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateFluxProps(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateState(builder, groupName: groupName, componentFactoryName: componentFactoryName);
  _addUiComponentBoilerplateComponent(builder,
      groupName: groupName,
      baseComponentClassName: 'FluxUiStatefulComponent2',
      componentFactoryName: componentFactoryName,
      getComponentRenderReturnValueSrc: getComponentRenderReturnValueSrc);
}
