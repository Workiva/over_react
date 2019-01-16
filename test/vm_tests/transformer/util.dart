import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';

const String factorySrc                  = '\n@Factory()\nUiFactory<FooProps> Foo = _\$Foo;\n';
const String componentSrc                = '\n@Component()\nclass FooComponent {render() {return null;}}\n';
const String abstractComponentSrc        = '\n@AbstractComponent()\nclass AbstractFooComponent {}\n';

const String propsSrc                    = '\n@Props()\nclass _\$FooProps {}\n';
const String propsSrcDart1               = '\n@Props()\nclass FooProps {}\n';
const String abstractPropsSrc            = '\n@AbstractProps()\nclass _\$AbstractFooProps {}\n';
const String abstractPropsSrcDart1       = '\n@AbstractProps()\nclass AbstractFooProps {}\n';
const String companionClassProps         = 'class FooProps {}';
const String companionClassAbstractProps = 'class AbstractFooProps {}';

const String stateSrc                    = '\n@State()\nclass _\$FooState {}\n';
const String stateSrcDart1               = '\n@State()\nclass FooState {}\n';
const String abstractStateSrc            = '\n@AbstractState()\nclass _\$AbstractFooState {}\n';
const String abstractStateSrcDart1       = '\n@AbstractState()\nclass AbstractFooState {}\n';
const String companionClassState         = 'class FooState {}';


enum AnnotationType {
  props,
  state,
  abstractProps,
  abstractState,
}

/// Builds src code for props or state classes with Dart1-2 transition boilerplate
class PropsOrStateSrc {
  PropsOrStateSrc(this._type, this._body, this._className, this._typeParameters);

  final AnnotationType _type;
  final String _body;
  final TypeParameterList _typeParameters;
  final String _className;

  String get _annotation {
    switch (_type) {
      case AnnotationType.props:
        {
          return '@Props()';
        }
      case AnnotationType.state:
        {
          return '@State()';
        }
      case AnnotationType.abstractProps:
        {
          return '@AbstractProps()';
        }
      case AnnotationType.abstractState:
        {
          return '@AbstractState()';
        }
    }
  }

  String get src {
    var classKeyword = (_type == AnnotationType.props || _type == AnnotationType.state) ? 'class' : 'abstract class';
    var isProps = (_type == AnnotationType.props || _type == AnnotationType.abstractProps);
    var typeParamSrc = _typeParameters?.toSource() ?? '';
    var typeParamSrcWithoutBounds = removeBoundsFromTypeParameters(_typeParameters);
    return (StringBuffer()
        ..write('$_annotation $classKeyword _\$$_className$typeParamSrc {\n$_body}\n')
        ..write('''\n$classKeyword $_className$typeParamSrc 
            extends _\$$_className$typeParamSrcWithoutBounds with _\$${_className}AccessorsMixin$typeParamSrcWithoutBounds {
          static const ${isProps ? 'PropsMeta' : 'StateMeta'} meta = _\$metaFor$_className;
         }\n'''))
        .toString();
  }
}

String removeBoundsFromTypeParameters(TypeParameterList typeParameters) {
  return typeParameters != null ? (StringBuffer()
    ..write('<')..write(
        typeParameters.typeParameters.map((t) => t.name.name).join(
            ', '))..write('>'))
      .toString()
      : '';
}

class MockLogger extends Mock implements Logger {}
