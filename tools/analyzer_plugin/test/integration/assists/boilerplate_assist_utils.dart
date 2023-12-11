import 'package:path/path.dart' as p;

mixin BoilerplateAssistTestStrings {
  static const prefix = 'Foo';

  static const stateMixin = '''

mixin ${prefix}State on UiState {}
''';

  static const getInitialState = '''
  @override
  get initialState => (newState());
''';

  static const getDefaultProps = '''
  @override
  get defaultProps => (newProps());
''';

  String componentNameSelector = 'class #${prefix}Component# extends';

  String simpleComponentSuperclass({bool withState = false}) =>
      withState ? 'UiStatefulComponent2<${prefix}Props, ${prefix}State>' : 'UiComponent2<${prefix}Props>';

  String fluxComponentSuperclass({bool withState = false}) =>
      withState ? 'FluxUiStatefulComponent2<${prefix}Props, ${prefix}State>' : 'FluxUiComponent2<${prefix}Props>';

  String simpleUiComponentSource(
      {required String filename, bool isStateful = false, bool shouldIncludeSelection = false, bool includeDefaultProps = true}) {
    return '''
import 'package:over_react/over_react.dart';
part '${p.basenameWithoutExtension(filename)}.over_react.g.dart';

UiFactory<${prefix}Props> $prefix = _\$$prefix; // ignore: undefined_identifier

mixin ${prefix}Props on UiProps {}
${isStateful ? stateMixin : ''}
class ${prefix}Component extends ${simpleComponentSuperclass(withState: isStateful)} {
${includeDefaultProps ? getDefaultProps : ''}${includeDefaultProps && isStateful ? '\n' : ''}${isStateful ? getInitialState : ''}

  @override
  render() {}
}
''';
  }

  String fluxUiComponentSource(
      {required String filename, bool isStateful = false, bool shouldIncludeSelection = false, bool includeDefaultProps = true}) {
    return '''
import 'package:over_react/over_react.dart';
part '${p.basenameWithoutExtension(filename)}.over_react.g.dart';

UiFactory<${prefix}Props> $prefix = _\$$prefix; // ignore: undefined_identifier

mixin ${prefix}Props on UiProps {}

class ${prefix}Props = UiProps with FluxUiPropsMixin, ${prefix}PropsMixin;
${isStateful ? stateMixin : ''}
class ${prefix}Component extends ${fluxComponentSuperclass(withState: isStateful)} {
${includeDefaultProps ? getDefaultProps : ''}${includeDefaultProps && isStateful ? '\n' : ''}${isStateful ? getInitialState : ''}

  @override
  render() {}
}
''';
  }
}
