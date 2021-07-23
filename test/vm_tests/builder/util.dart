// Copyright 2020 Workiva Inc.
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

import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String factorySrc                  = '\n@Factory()\nUiFactory<FooProps> Foo = _\$Foo;\n';
const String componentSrc                = '\n@Component()\nclass FooComponent {render() {return null;}}\n';
const String component2Src               = '\n@Component2()\nclass FooComponent {render() {return null;}}\n';
const String component2LegacySrc         = '\n@Component2()\nclass FooComponent {'
                                                'componentWillMount() {return null;} '
                                                'componentWillReceiveProps() {return null;} '
                                                'componentWillUpdate() {return null;} '
                                                'render() {return null;}}\n';
const String abstractComponentSrc        = '\n@AbstractComponent()\nclass AbstractFooComponent {}\n';
const String abstractComponent2Src       = '\n@AbstractComponent2()\nclass AbstractFooComponent {}\n';

const String propsSrc                    = '\n@Props()\nclass _\$FooProps {}\n';
const String privatePropsSrc             = '\n@Props()\nclass _\$_FooProps {}\n';
const String propsSrcDart1               = '\n@Props()\nclass FooProps {}\n';
const String abstractPropsSrc            = '\n@AbstractProps()\nclass _\$AbstractFooProps {}\n';
const String abstractPropsSrcDart1       = '\n@AbstractProps()\nclass AbstractFooProps {}\n';
const String companionClassProps         = 'class FooProps {}';
const String companionClassAbstractProps = 'class AbstractFooProps {}';

const String stateSrc                    = '\n@State()\nclass _\$FooState {}\n';
const String privateStateSrc             = '\n@State()\nclass _\$_FooState {}\n';
const String stateSrcDart1               = '\n@State()\nclass FooState {}\n';
const String abstractStateSrc            = '\n@AbstractState()\nclass _\$AbstractFooState {}\n';
const String abstractStateSrcDart1       = '\n@AbstractState()\nclass AbstractFooState {}\n';
const String companionClassState         = 'class FooState {}';

const String propsMixinSrc = r'''
@PropsMixin()
abstract class FooPropsMixin {
  Map get props;
  static const PropsMeta meta = _$metaForFooPropsMixin;
}''';
const String stateMixinSrc = r'''
@StateMixin()
abstract class FooStateMixin {
  Map get state;
  static const StateMeta meta = _$metaForFooStateMixin;
}''';

enum AnnotationType {
  props,
  state,
  abstractProps,
  abstractState,
  propsMixin,
  stateMixin
}

/// Used to generate valid over_react source code which can be used for
/// testing the builder pieces. See one of the named constructors for usage
/// details:
///   [OverReactSrc.abstractProps]
///   [OverReactSrc.abstractState]
///   [OverReactSrc.props]
///   [OverReactSrc.propsMixin]
///   [OverReactSrc.state]
///   [OverReactSrc.stateMixin]
class OverReactSrc {
  /// Creates valid over_react [source] with an abstract props class included.
  ///
  /// Can optionally specify an accompanying abstract component class by setting
  /// [needsComponent] to true.
  ///
  /// Set [typeParameters] to true to add type parameters to the abstract props
  /// class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  const OverReactSrc.abstractProps({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.needsComponent = false,
    this.typeParameters = false,
    this.componentVersion = 1,
    this.baseName = 'AbstractFoo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.abstractProps,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.numMixins = 0,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] with an abstract state class included.
  ///
  /// Can optionally specify an accompanying abstract component class by setting
  /// [needsComponent] to `true`. If [needsComponent] is true, an abstract props
  /// class will also be included in the [source].
  ///
  /// Set [typeParameters] to true to add type parameters to the abstract state
  /// class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  const OverReactSrc.abstractState({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.needsComponent = false,
    this.typeParameters = false,
    this.componentVersion = 1,
    this.baseName = 'AbstractFoo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.abstractState,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.numMixins = 0,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] with a props class included.
  ///
  /// Will also include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the props class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  const OverReactSrc.props({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.typeParameters = false,
    this.componentVersion = 1,
    this.baseName = 'Foo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.props,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = true,
        this.numMixins = 0,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] with a props mixin class included.
  ///
  /// This will not include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the props mixin class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  ///
  /// Use [numMixins] to specify the number of mixins in the source.
  const OverReactSrc.propsMixin({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.typeParameters = false,
    this.numMixins = 1,
    this.componentVersion = 1,
    this.baseName = 'Foo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.propsMixin,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = false,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] with a state class included.
  ///
  /// Will also include a factory, component, and props in the [source], since
  /// these are required when a @State() class is present. Set [typeParameters]
  /// to true to add type parameters to the state class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  const OverReactSrc.state({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.typeParameters = false,
    this.componentVersion = 1,
    this.baseName = 'Foo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.state,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = true,
        this.numMixins = 0,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] with a props mixin class included.
  ///
  /// This will not include a factory and component in the [source]. Set
  /// [typeParameters] to true to add type parameters to the state mixin class.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  /// annotation.
  ///
  /// Use [numMixins] to specify the number of mixins in the source.
  const OverReactSrc.stateMixin({
    this.annotationArg = '',
    this.backwardsCompatible = true,
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.typeParameters = false,
    this.numMixins = 1,
    this.componentVersion = 1,
    this.baseName = 'Foo',
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.stateMixin,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = false,
        this.isMixinBasedBoilerplate = false,
        this.shouldIncludePropsAlias = false,
        this.shouldIncludeAnnotations = true,
        this.useDart290Factory = false;

  /// Creates valid over_react [source] using the mixin based boilerplate for props.
  ///
  /// Will also include a factory and component in the [source].
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  ///
  /// Use [shouldIncludePropsAlias] to create a props alias class (AKA the non-abbreviated
  /// version of the boilerplate).
  ///
  /// Use [shouldIncludeAnnotations] to add the relevant annotation to the factory,
  /// props, and component declarations.
  const OverReactSrc.mixinBasedBoilerplateProps({
    this.annotationArg = '',
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.shouldIncludePropsAlias = false,
    this.shouldIncludeAnnotations = false,
    this.baseName = 'Foo',
    this.useDart290Factory = false,
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.props,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = true,
        this.numMixins = 0,
        this.typeParameters = false,
        this.componentVersion = 2,
        this.isMixinBasedBoilerplate = true,
        this.backwardsCompatible = false;

  /// Creates valid over_react [source] with a state class included.
  ///
  /// Will also include a factory, component, and props in the [source], since
  /// these are required when a @State() class is present.
  ///
  /// Set [isPrivate] to true to make the class private.
  ///
  /// Use [annotationArg] to add an argument to the `@Props()` annotation.
  ///
  /// Use [baseName] to set the shared identifier between a component's related
  /// boilerplate pieces (e.g. FooComponent, FooProps, FooState).
  ///
  /// Use [body] to specify a body for the `@Props()` annotated class.
  ///
  /// Use [componentBody] to specify a body for the `@Component()` annotated class.
  ///
  /// Use [componentAnnotationArg] to add an argument to the `@Component()`
  ///
  /// Use [shouldIncludePropsAlias] to create a props alias class (AKA the non-abbreviated
  /// version of the boilerplate).
  ///
  /// Use [shouldIncludeAnnotations] to add the relevant annotation to the factory,
  /// props, and component declarations.
  const OverReactSrc.mixinBasedBoilerplateState({
    this.annotationArg = '',
    this.body = '',
    this.componentAnnotationArg = '',
    this.componentBody = '',
    this.typeParameters = false,
    this.shouldIncludePropsAlias = false,
    this.shouldIncludeAnnotations = false,
    this.baseName = 'Foo',
    this.useDart290Factory = false,
    bool isPrivate = false})
      :
        this.annotation = AnnotationType.state,
        this.prefixedBaseName = '${isPrivate ? '_' : ''}$baseName',
        this.needsComponent = true,
        this.numMixins = 0,
        this.componentVersion = 2,
        this.isMixinBasedBoilerplate = true,
        this.backwardsCompatible = false;

  final AnnotationType annotation;
  final bool backwardsCompatible;
  final String componentAnnotationArg;
  final String componentBody;
  final String annotationArg;
  final String body;
  final String baseName;
  final String prefixedBaseName;
  final bool needsComponent;
  final int componentVersion;
  final int numMixins;
  final bool typeParameters;
  final bool isMixinBasedBoilerplate;
  final bool shouldIncludePropsAlias;
  final bool shouldIncludeAnnotations;
  final bool useDart290Factory;

  String get componentName => '${prefixedBaseName}Component';
  String get constantListName => isProps(annotation) ? '\$props' : '\$state';
  String get factoryInitializer => '_\$$prefixedBaseName';
  String get factoryInitializerWithPossibleCast => useDart290Factory ? '_\$$prefixedBaseName' : 'castUiFactory(_\$$prefixedBaseName)';
  String get keyListName => isProps(annotation) ? '\$propKeys' : '\$stateKeys';
  String get propsClassName => '${prefixedBaseName}Props';
  String get propsMixinClassName => '${prefixedBaseName}PropsMixin';
  String get propsOrStateOrMixinClassName => _propsOrStateOrMixinClassName(isProps(annotation) ? 'Props' : 'State');
  String get stateClassName => '${prefixedBaseName}State';
  String get stateMixinClassName => '${prefixedBaseName}StateMixin';
  String get typeParamSrc => typeParameters ? '<T extends Iterable, U>' : '';
  String get typeParamSrcWithoutBounds => typeParameters ? '<T, U>' : '';


  String metaStructName(AnnotationType annotation) {
    return isProps(annotation) ? 'PropsMeta' : 'StateMeta';
  }

  String get source {
    final buffer = StringBuffer();

    if (needsComponent) {
      String componentStr = componentVersion == 2 ? 'Component2' : 'Component';
      if (!isAbstract(annotation)) {
        if (shouldIncludeAnnotations) {
          buffer.writeln('\n@Factory()\nUiFactory<$propsClassName> $prefixedBaseName = $factoryInitializerWithPossibleCast;\n');
        } else {
          buffer.writeln('\nUiFactory<$propsClassName> $prefixedBaseName = $factoryInitializerWithPossibleCast;\n');
        }
      }

      if (shouldIncludeAnnotations) {
        buffer.writeln('@${isAbstract(annotation) ? 'Abstract' : ''}$componentStr($componentAnnotationArg) ${_classKeyword(annotation)} $componentName {$componentBody}');
      } else {
        buffer.writeln('${_classKeyword(annotation)} $componentName {$componentBody}');
      }

      // If we need a component, but we're not a props class, then we need to write a props class
      if (!isProps(this.annotation)) {
        buffer.write(_propsOrStateSrc(isAbstract(annotation) ? AnnotationType.abstractProps : AnnotationType.props));
      }
    }
    if (isMixin(annotation)) {
      // only 1 mixin, so no index necessary
      if (numMixins == 1) {
        buffer.write(_propsOrStateMixinSrc(annotation, body: body));
      } else {
        var i = 1;
        while (i <= numMixins) {
          buffer.write(_propsOrStateMixinSrc(annotation, body: body, index: i));
          i++;
        }
      }
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
      return '$prefixedBaseName${type}Mixin';
    } else {
      return '$prefixedBaseName$type';
    }
  }

  String _annotationSrc(AnnotationType annotation, {String annotationArg = ''}) {
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

  String _propsOrStateSrc(AnnotationType annotation, {String body = '', String annotationArg = ''}) {
    if (isMixin(annotation)) {
      return '';
    }

    final className = isProps(annotation) ? propsClassName : stateClassName;
    final propsOrStateKeyword = isProps(annotation) ? 'Props' : 'State';
    var buffer = StringBuffer();
    if (!isMixinBasedBoilerplate) {
      buffer.writeln('${_annotationSrc(annotation, annotationArg: annotationArg)}\n${_classKeyword(annotation)} _\$$className$typeParamSrc {$body\n}\n');
    } else {
      if (shouldIncludeAnnotations) {
        buffer.writeln('${_annotationSrc(annotation, annotationArg: annotationArg)}');
      }
      if (shouldIncludePropsAlias) {
       buffer.writeln('mixin ${className}Mixin on Ui$propsOrStateKeyword {$body\n}\nclass $className = Ui$propsOrStateKeyword with ${className}Mixin;');
      } else {
        buffer.writeln('mixin $className on Ui$propsOrStateKeyword {$body\n}\n');
      }
    }
    if (backwardsCompatible) {
      buffer
        ..writeln('${_classKeyword(annotation)} $className$typeParamSrc')
        ..writeln('    extends _\$$className$typeParamSrcWithoutBounds with _\$${className}AccessorsMixin$typeParamSrcWithoutBounds {')
        ..writeln(_propsGetterSrc(annotation))
        ..writeln(_metaSrc(className, annotation))
        ..writeln('}\n');
    }
    return buffer.toString();
  }

  String _propsOrStateMixinSrc(AnnotationType annotation, {String body = '', String annotationArg = '', int? index}) {
    if (!isMixin(annotation)) {
      return '';
    }

    final namePrefix = backwardsCompatible ? '' : '_\$';
    final className = '$namePrefix${isProps(annotation) ? propsMixinClassName : stateMixinClassName}';
    var buffer = StringBuffer();
    final indexStr = '${index ?? ''}';
    buffer
      ..writeln('${_annotationSrc(annotation, annotationArg: annotationArg)}\nabstract class $className$indexStr$typeParamSrc {')
      ..writeln(_propsGetterSrc(annotation));
    if (backwardsCompatible) {
      buffer.writeln(_metaSrc('$className$indexStr', annotation));
    }
    return (buffer
      ..writeln(body)
      ..writeln('}')).toString();

  }
}

class MockLogger extends Mock implements Logger {}


Iterable<T> expectLengthAndAllOfType<T>(Iterable<Object> items, int count) {
  expect(items, List.generate(count, (i) => isA<T>()));
  return items.cast<T>();
}

Iterable<T> expectAllOfType<T>(Iterable<Object> items) {
  expect(items, everyElement(isA<T>()));
  return items.cast<T>();
}

T expectSingleOfType<T>(Iterable<Object> items) {
  expect(items, [isA<T>()]);
  return items.cast<T>().single;
}
