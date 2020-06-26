mixin BoilerplateAssistTestStrings {
  static const fileName = 'test.dart';

  static const prefix = 'Foo';

  static const stateMixin = '''

mixin ${prefix}State on UiState {}
''';

  static const getInitialState = '''

  @override
  get initialState => (newState());
''';

  String componentName({bool withSelection = false}) => withSelection ? '#${prefix}Component#' : '${prefix}Component';

  String simpleComponentSuperclass({bool withState = false}) =>
      withState ? 'UiStatefulComponent2<${prefix}Props, ${prefix}State>' : 'UiComponent2<${prefix}Props>';

  String fluxComponentSuperclass({bool withState = false}) =>
      withState ? 'FluxUiStatefulComponent2<${prefix}Props, ${prefix}State>' : 'FluxUiComponent2<${prefix}Props>';

  String simpleUiComponentSource({bool isStateful = false, bool shouldIncludeSelection = false}) {
    return '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

UiFactory<${prefix}Props> $prefix = _\$$prefix; // ignore: undefined_identifier

mixin ${prefix}Props on UiProps {}
${isStateful ? stateMixin : ''}
class ${componentName(withSelection: shouldIncludeSelection)} extends ${simpleComponentSuperclass(withState: isStateful)} {
  @override
  get defaultProps => (newProps());
${isStateful ? getInitialState : ''}
  @override
  render() {}
}
''';
  }

  String fluxUiComponentSource({bool isStateful = false, bool shouldIncludeSelection = false}) {
    return '''
import 'package:over_react/over_react.dart';
part 'test.over_react.g.dart';

UiFactory<${prefix}Props> $prefix = _\$$prefix; // ignore: undefined_identifier

mixin ${prefix}Props on UiProps {}

class ${prefix}Props = UiProps with FluxUiPropsMixin, ${prefix}PropsMixin;
${isStateful ? stateMixin : ''}
class ${componentName(withSelection: shouldIncludeSelection)} extends ${fluxComponentSuperclass(withState: isStateful)} {
  @override
  get defaultProps => (newProps());
${isStateful ? getInitialState : ''}
  @override
  render() {}
}
''';
  }
}
