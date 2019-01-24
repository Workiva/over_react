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

const String propsMixinSrc               = '@PropsMixin()\nabstract class FooPropsMixin {}\n';
const String stateMixinSrc               = '@StateMixin()\nabstract class FooStateMixin {}\n';

enum AnnotationType {
  props,
  state,
  abstractProps,
  abstractState,
  propsMixin,
  stateMixin
}

/// class used to generate valid over_react source code which can be used for
/// testing the builder pieces
class OverReactSrc {
  /// Creates valid over_react [source] with an abstract props class included.
  ///
  /// Can optionally specify an accompanying abstract component class by setting
  /// [needsComponent] to true. Set [typeParameters] to true to add type
  /// parameters to the abstract props class. Set [isPrivate] to true to make
  /// the class private.
  const OverReactSrc.abstractProps({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.needsComponent: false,
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.abstractProps,
        this.baseName = '${isPrivate ? '_' : ''}AbstractFoo';

  /// Creates valid over_react [source] with an abstract state class included.
  ///
  /// Can optionally specify an accompanying abstract component class by setting
  /// [needsComponent] to `true`. If [needsComponent] is true, an abstract props
  /// class will also be included in the [source]. Set [typeParameters] to true
  /// to add type parameters to the abstract state class. Set [isPrivate] to
  /// true to make the class private.
  const OverReactSrc.abstractState({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.needsComponent: false,
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.abstractState,
        this.baseName = '${isPrivate ? '_' : ''}AbstractFoo';

  /// Creates valid over_react [source] with a props class included.
  ///
  /// Will also include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the props class. Set
  /// [isPrivate] to true to make the class private.
  const OverReactSrc.props({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.props,
        this.baseName = '${isPrivate ? '_' : ''}Foo',
        this.needsComponent = true;

  /// Creates valid over_react [source] with a props mixin class included.
  ///
  /// This will not include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the props mixin class.
  /// Set [isPrivate] to true to make the class private.
  const OverReactSrc.propsMixin({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.propsMixin,
        this.baseName = '${isPrivate ? '_' : ''}Foo',
        this.needsComponent = false;

  /// Creates valid over_react [source] with a props mixin class included.
  ///
  ///
  /// This will not include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the state mixin class.
  /// Set [isPrivate] to true to make the class private.
  const OverReactSrc.stateMixin({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.stateMixin,
        this.baseName = '${isPrivate ? '_' : ''}Foo',
        this.needsComponent = false;

  /// Creates valid over_react [source] with a state class included.
  ///
  /// Will also include a factory, component, and props in the [source], since
  /// these are required when a @State() class is present. Set [typeParameters]
  /// to true to add type parameters to the state class. Set [isPrivate] to true
  /// to make the class private.
  const OverReactSrc.state({
    this.annotationArg: '',
    this.body: '',
    this.componentAnnotationArg: '',
    this.componentBody: '',
    this.typeParameters: false,
    isPrivate: false})
      :
        this.annotation = AnnotationType.state,
        this.baseName = '${isPrivate ? '_' : ''}Foo',
        this.needsComponent = true;

  final AnnotationType annotation;
  final String componentAnnotationArg;
  final String componentBody;
  final String annotationArg;
  final String body;
  final String baseName;
  final bool needsComponent;
  final bool typeParameters;

  String get componentName => '${baseName}Component';
  String get constantListName => isProps(annotation) ? '\$props' : '\$state';
  String get factoryInitializer => '_\$$baseName';
  String get keyListName => isProps(annotation) ? '\$propKeys' : '\$stateKeys';
  String get propsClassName => '${baseName}Props';
  String get propsMixinClassName => '${baseName}PropsMixin';
  String get propsOrStateOrMixinClassName => _propsOrStateOrMixinClassName(isProps(annotation) ? 'Props' : 'State');
  String get stateClassName => '${baseName}State';
  String get stateMixinClassName => '${baseName}StateMixin';
  String get typeParamSrc => typeParameters ? '<T extends Iterable, U>' : '';
  String get typeParamSrcWithoutBounds => typeParameters ? '<T, U>' : '';


  String metaStructName(AnnotationType annotation) {
    return isProps(annotation) ? 'PropsMeta' : 'StateMeta';
  }

  String get source {
    final buffer = new StringBuffer();

    if (needsComponent) {
      if (!isAbstract(annotation)) {
        buffer.writeln('\n@Factory()\nUiFactory<$propsClassName> $baseName = _\$$baseName;\n');
      }
      buffer.writeln('@${isAbstract(annotation) ? 'Abstract' : ''}Component($componentAnnotationArg) ${_classKeyword(annotation)} $componentName {$componentBody}');

      // If we need a component, but we're not a props class, then we need to write a props class
      if (!isProps(this.annotation)) {
        buffer.write(_propsOrStateSrc(isAbstract(annotation) ? AnnotationType.abstractProps : AnnotationType.props));
      }
    }
    if (isMixin(annotation)) {
      buffer.write(_propsOrStateMixinSrc(annotation, body: body));
    } else {
      buffer.write(_propsOrStateSrc(annotation, body: body));
    }

    return buffer.toString();
  }

  bool isAbstract(AnnotationType annotation) => annotation == AnnotationType.abstractProps ||
        annotation == AnnotationType.abstractState ||
        annotation == AnnotationType.propsMixin ||
        annotation == AnnotationType.stateMixin;

  bool isProps(AnnotationType annotation) => annotation == AnnotationType.props ||
        annotation == AnnotationType.propsMixin ||
        annotation == AnnotationType.abstractProps;

  bool isMixin(AnnotationType annotation) => annotation == AnnotationType.propsMixin ||
        annotation == AnnotationType.stateMixin;

  String _propsOrStateOrMixinClassName(String type) {
    if (isMixin(annotation)) {
      return '$baseName${type}Mixin';
    } else {
      return '$baseName$type';
    }
  }

  String _annotationSrc(AnnotationType annotation, {String annotationArg: ''}) {
    switch (annotation) {
      case AnnotationType.props:
        {
          return '@Props($annotationArg)';
        }
      case AnnotationType.state:
        {
          return '@State($annotationArg)';
        }
      case AnnotationType.abstractProps:
        {
          return '@AbstractProps($annotationArg)';
        }
      case AnnotationType.abstractState:
        {
          return '@AbstractState($annotationArg)';
        }
      case AnnotationType.propsMixin:
        {
          return '@PropsMixin($annotationArg)';
        }
      case AnnotationType.stateMixin:
        {
          return '@StateMixin($annotationArg)';
        }
      default: return '';
    }
  }

  String _classKeyword(AnnotationType annotation) => isAbstract(annotation) ? 'abstract class' : 'class';

  String _metaSrc(String className, AnnotationType annotation) => '  static const ${metaStructName(annotation)} meta = _\$metaFor$className;';

  String _propsGetterSrc(AnnotationType annotation) => isAbstract(annotation) ? '  Map get ${isProps(annotation) ? "props" : "state"};' : '';

  String _propsOrStateSrc(AnnotationType annotation, {String body: '', String annotationArg: ''}) {
    if (isMixin(annotation)) {
      return '';
    }

    final className = isProps(annotation) ? propsClassName : stateClassName;
    return (StringBuffer()
      ..writeln('${_annotationSrc(annotation, annotationArg: annotationArg)}\n${_classKeyword(annotation)} _\$$className$typeParamSrc {$body\n}')
      ..writeln('${_classKeyword(annotation)} $className$typeParamSrc')
      ..writeln('    extends _\$$className$typeParamSrcWithoutBounds with _\$${className}AccessorsMixin$typeParamSrcWithoutBounds {')
      ..writeln(_propsGetterSrc(annotation))
      ..writeln(_metaSrc(className, annotation))
      ..writeln('}\n')).toString();
  }

  String _propsOrStateMixinSrc(AnnotationType annotation, {String body: '', String annotationArg: ''}) {
    if (!isMixin(annotation)) {
      return '';
    }

    final className = isProps(annotation) ? propsMixinClassName : stateMixinClassName;
    return (StringBuffer()
      ..writeln('${_annotationSrc(annotation, annotationArg: annotationArg)}\nabstract class $className$typeParamSrc {')
      ..writeln(_propsGetterSrc(annotation))
      ..writeln(_metaSrc(className, annotation))
      ..writeln(body)
      ..writeln('}')).toString();
  }
}

class MockLogger extends Mock implements Logger {}
