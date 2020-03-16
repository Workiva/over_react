import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:transformer_utils/transformer_utils.dart';

import '../../util.dart';
import '../parsing.dart';
import 'names.dart';
import 'util.dart';

abstract class TypedMapImplGenerator extends Generator {
  TypedMapImplGenerator();

  // Provide factory constructors since they make invocations easier to read and tell apart
  // than all of the different subclasses.

  factory TypedMapImplGenerator.legacyProps(LegacyClassComponentDeclaration declaration) =
      _LegacyTypedMapImplGenerator.props;

  factory TypedMapImplGenerator.legacyState(LegacyClassComponentDeclaration declaration) =
      _LegacyTypedMapImplGenerator.state;

  factory TypedMapImplGenerator.props(ClassComponentDeclaration declaration) =
      _TypedMapImplGenerator.props;

  factory TypedMapImplGenerator.state(ClassComponentDeclaration declaration) =
      _TypedMapImplGenerator.state;

  factory TypedMapImplGenerator.propsMapViewOrFunctionComponent(
          PropsMapViewOrFunctionComponentDeclaration declaration) =
      _TypedMapImplGenerator.propsMapViewOrFunctionComponent;

  TypedMapNames get names;
  bool get isComponent2;
  String get factoryName;
  bool get isProps;

  BoilerplateAccessorsMember get member;

  TypeParameterList get typeParameters => member.nodeHelper.typeParameters;
  String get typeParamsOnClass => typeParameters?.toSource() ?? '';
  String get typeParamsOnSuper => removeBoundsFromTypeParameters(typeParameters);

  @override
  void generate() {
    if (isProps) {
      _generateFactory();
      _generatePropsImpl();
    } else {
      _generateStateImpl();
    }
  }

  void _generatePropsImpl();

  void _generateStateImpl();

  void _generateFactory() {
    if (factoryName == null) throw StateError('factoryName must not be null');

    outputContentsBuffer
        .write('${names.implName} $privateSourcePrefix$factoryName([Map backingProps]) => ');

    if (!isComponent2) {
      /// _$$FooProps _$Foo([Map backingProps]) => _$$FooProps(backingProps);
      outputContentsBuffer.writeln('${names.implName}(backingProps);');
    } else {
      /// _$$FooProps _$Foo([Map backingProps]) => backingProps == null ? $jsMapImplName(JsBackedMap()) : _$$FooProps(backingProps);
      // Optimize this case for when backingProps is null to promote inlining of `jsMapImplName` typing
      outputContentsBuffer.writeln(
          'backingProps == null ? ${names.jsMapImplName}(JsBackedMap()) : ${names.implName}(backingProps);');
    }
  }

  String _generateImplClassHeader();

  /// Generates a concrete props or state implementation class for a given component.
  ///
  /// ## For Component2
  ///
  /// Generates an additional UiProps class implementation for each component that can only be backed by JS maps,
  /// and overrides the return type of `typedPropsFactoryJs`/`props` to match this.
  ///
  /// This allows dart2js to make some optimizations. For instance:
  ///
  /// For the access of `props.isOpen` within a component, if we try to inline things
  /// (for the purposes of understanding what's going on under the hood), then it looks like this:
  ///
  ///     props.isOpen;           // inlining FooProps.isOpen typed getter, this becomes...
  ///     props.props['isOpen'];  // inlining UiProps.operator[], this becomes...
  ///     props.props.backingMap['isOpen'];
  ///
  /// So, we're eventually accessing a property on the `Map backingMap`.
  ///
  /// But if `backingMap` is a `JsBackedMap`, we can go one layer deeper:
  ///
  ///     props.props.backingMap['isOpen'];  // inlining JsBackedMap.operator[], this becomes...
  ///     getProperty(props.props.backingMap.jsMap, 'isOpen');
  ///
  /// Now, onto dart2js, which performs actual inlining in certain cases (like prop accesses).
  ///
  /// When dart2js only knows that `backingMap` is a `Map`, it emits the following code, wherein
  /// `$index$asx` performs type-checking on the map and key, and then performs an interceptor lookup on
  /// the backing map before finally calling into the actual key lookup function.
  ///
  ///     J.$index$asx(this._cachedTypedProps.props.backingMap, 'isOpen');
  ///
  /// However, when dart2js knows that `backingMap` is a `JsMap`, it can skip that step and emit
  /// code that directly accesses the JS property `index$ax` instead:
  ///
  ///     J.$index$ax(this._cachedTypedProps.props.backingMap, 'isOpen');
  ///
  /// Which in some cases can just become:
  ///
  ///     this._cachedTypedProps.props.backingMap.jsMap.isOpen;
  ///     // or, minified:
  ///     this.foo.bar.baz.qux.isOpen;
  ///
  String _generateConcretePropsOrStateImpl({
    String componentFactoryName,
    String propKeyNamespace,
  }) {
    if (isProps) {
      if (componentFactoryName == null || propKeyNamespace == null) {
        throw ArgumentError('componentFactoryName/propKeyNamespace must be specified for props');
      }
    } else {
      if (componentFactoryName != null || propKeyNamespace != null) {
        throw ArgumentError(
            'componentFactoryName/propKeyNamespace must not be specified for state');
      }
    }

    final classDeclaration = StringBuffer();
    if (isComponent2) {
      // This class will only have a factory constructor that instantiates one
      // of two subclasses.
      classDeclaration.write('abstract ');
    }

    classDeclaration..write(_generateImplClassHeader())..write(' {');

    final propsOrState = isProps ? 'props' : 'state';

    // Class declaration
    final buffer = StringBuffer()
      ..writeln('// Concrete $propsOrState implementation.')
      ..writeln('//')
      ..writeln(
          '// Implements constructor and backing map${isProps ? ', and links up to generated component factory' : ''}.')
      ..write(internalGeneratedMemberDeprecationLine())
      ..writeln(classDeclaration);

    // Constructors
    if (isComponent2) {
      buffer
        ..writeln('  ${names.implName}._();')
        ..writeln()
        ..writeln('  factory ${names.implName}(Map backingMap) {')
        ..writeln('    if (backingMap == null || backingMap is JsBackedMap) {')
        ..writeln('      return ${names.jsMapImplName}(backingMap);')
        ..writeln('    } else {')
        ..writeln('      return ${names.plainMapImplName}(backingMap);')
        ..writeln('    }')
        ..writeln('  }');
    } else {
      buffer
        ..writeln(
            '  // This initializer of `_$propsOrState` to an empty map, as well as the reassignment')
        ..writeln(
            '  // of `_$propsOrState` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217')
        // TODO need to remove this workaround once https://github.com/dart-lang/sdk/issues/36217 is fixed get nice dart2js output
        ..writeln('  ${names.implName}(Map backingMap) : this._$propsOrState = {} {')
        ..writeln('     this._$propsOrState = backingMap ?? {};')
        ..writeln('  }');
    }

    // Members
    if (!isComponent2) {
      buffer
        ..writeln()
        ..writeln('  /// The backing $propsOrState map proxied by this class.')
        ..writeln('  @override')
        ..writeln('  Map get $propsOrState => _$propsOrState;')
        ..writeln('  Map _$propsOrState;');
    }
    buffer
      ..writeln()
      ..writeln(
          '  /// Let `${isProps ? 'UiProps' : 'UiState'}` internals know that this class has been generated.')
      ..writeln('  @override')
      ..writeln('  bool get \$isClassGenerated => true;');
    if (isProps) {
      // No reason to override if it's null.
      if (componentFactoryName != 'null') {
        buffer
          ..writeln()
          ..writeln(
              '  /// The `ReactComponentFactory` associated with the component built by this class.')
          ..writeln('  @override')
          ..writeln('  ReactComponentFactoryProxy get componentFactory =>'
              ' super.componentFactory ?? $componentFactoryName;')
          ..writeln();
      }
      buffer
        ..writeln(
            '  /// The default namespace for the prop getters/setters generated for this class.')
        ..writeln('  @override')
        ..writeln('  String get propKeyNamespace => ${stringLiteral(propKeyNamespace)};');
    }

    // End of class body
    buffer.writeln('}');

    // Component2-specific classes
    if (isComponent2) {
      // TODO need to remove this workaround once https://github.com/dart-lang/sdk/issues/36217 is fixed get nice dart2js output
      buffer..writeln()..writeln('''
// Concrete $propsOrState implementation that can be backed by any [Map].
${internalGeneratedMemberDeprecationLine()}class ${names.plainMapImplName}$typeParamsOnClass extends ${names.implName}$typeParamsOnSuper {
  // This initializer of `_$propsOrState` to an empty map, as well as the reassignment
  // of `_$propsOrState` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  ${names.plainMapImplName}(Map backingMap) : this._$propsOrState = {}, super._() {
     this._$propsOrState = backingMap ?? {};
  }
  /// The backing $propsOrState map proxied by this class.
  @override
  Map get $propsOrState => _$propsOrState;
  Map _$propsOrState;
}
// Concrete $propsOrState implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
${internalGeneratedMemberDeprecationLine()}class ${names.jsMapImplName}$typeParamsOnClass extends ${names.implName}$typeParamsOnSuper {
  // This initializer of `_$propsOrState` to an empty map, as well as the reassignment
  // of `_$propsOrState` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  ${names.jsMapImplName}(JsBackedMap backingMap) : this._$propsOrState = JsBackedMap(), super._() {
     this._$propsOrState = backingMap ?? JsBackedMap();
  }
  /// The backing $propsOrState map proxied by this class.
  @override
  JsBackedMap get $propsOrState => _$propsOrState;
  JsBackedMap _$propsOrState;
}''');
    }
    return buffer.toString();
  }
}

class _LegacyTypedMapImplGenerator extends TypedMapImplGenerator {
  @override
  final TypedMapNames names;

  @override
  final bool isProps;

  final LegacyClassComponentDeclaration declaration;

  @override
  final BoilerplatePropsOrState member;

  _LegacyTypedMapImplGenerator.props(this.declaration)
      : names = TypedMapNames(declaration.props.name.name),
        member = declaration.props,
        isProps = true;

  _LegacyTypedMapImplGenerator.state(this.declaration)
      : names = TypedMapNames(declaration.state.name.name),
        member = declaration.state,
        isProps = false;

  @override
  Version get version => declaration.version;

  @override
  bool get isComponent2 => declaration.isComponent2;

  @override
  String get factoryName => declaration.factory.name.name;

  @override
  void _generatePropsImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl(
      componentFactoryName: ComponentNames(declaration.component.name.name).componentFactoryName,
      propKeyNamespace: getAccessorKeyNamespace(names, member.meta),
    ));
  }

  @override
  void _generateStateImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl());
  }

  @override
  String _generateImplClassHeader() {
    final typeParamsOnSuper = this.typeParamsOnSuper;

    return 'class ${names.implName}$typeParamsOnClass '
        'extends ${names.consumerName}$typeParamsOnSuper '
        'with ${names.legacyAccessorsMixinName}$typeParamsOnSuper '
        'implements ${names.publicName}$typeParamsOnSuper';
  }
}

class _TypedMapImplGenerator extends TypedMapImplGenerator {
  @override
  final TypedMapNames names;

  @override
  final bool isProps;

  @override
  final BoilerplateAccessorsMember member;

  @override
  final String factoryName;

  final String componentFactoryName;

  @override
  final Version version;

  _TypedMapImplGenerator.props(ClassComponentDeclaration declaration)
      : names = TypedMapNames(declaration.props.either.name.name),
        member = declaration.props.either,
        isProps = true,
        factoryName = declaration.factory.name.name,
        componentFactoryName = ComponentNames(declaration.component.name.name).componentFactoryName,
        version = declaration.version;

  _TypedMapImplGenerator.state(ClassComponentDeclaration declaration)
      : names = TypedMapNames(declaration.state.either.name.name),
        member = declaration.state.either,
        isProps = false,
        factoryName = declaration.factory.name.name,
        componentFactoryName = ComponentNames(declaration.component.name.name).componentFactoryName,
        version = declaration.version;

  _TypedMapImplGenerator.propsMapViewOrFunctionComponent(
      PropsMapViewOrFunctionComponentDeclaration declaration)
      : names = TypedMapNames(declaration.props.either.name.name),
        member = declaration.props.either,
        isProps = true,
        factoryName = declaration.factory.name.name,
        componentFactoryName = 'null',
        version = declaration.version;

  @override
  bool get isComponent2 => true;

  @override
  void _generatePropsImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl(
      componentFactoryName: componentFactoryName,
      // This doesn't really apply to the new boilerplate
      propKeyNamespace: '',
    ));
  }

  @override
  void _generateStateImpl() {
    outputContentsBuffer.write(_generateConcretePropsOrStateImpl());
  }

  @override
  String _generateImplClassHeader() {
    if (member is BoilerplatePropsOrStateMixin) {
      return 'class ${names.implName}$typeParamsOnClass'
          ' extends ${isProps ? 'UiProps' : 'UiState'}'
          ' with\n'
          ' ${names.consumerName}$typeParamsOnSuper\n,'
          ' ${names.generatedMixinName}$typeParamsOnSuper${generatedMixinWarningCommentLine(names, isProps: isProps)}';
    } else if (member is BoilerplatePropsOrState) {
      final header = StringBuffer()
        ..write('class ${names.implName}$typeParamsOnClass'
            ' extends ${isProps ? 'UiProps' : 'UiState'}');
      final mixins = member.nodeHelper.mixins;

      // Group the mixins with their generated mixins to avoid issues with covariant overrides.
      // For this reason, we can't subclass the user-authored class, and have to instead implement
      // it in order to get the correct mixin order
      //
      // For example:
      //     class FooProps = UiProps with AProps, BProps;
      // ...becomes:
      //     class _$FooProps = UiProps with AProps, $AProps, BProps, $BProps implements FooProps;
      // ...and not:
      //     class _$FooProps = FooProps with $AProps, $BProps;
      // ...or its equivalent
      //     class _$FooProps = UiProps with AProps, BProps, $AProps, $BProps implements FooProps;
      if (mixins.isNotEmpty) {
        header.write(' with ');
        for (var i = 0; i < mixins.length; i++) {
          final mixin = mixins[i];
          final typeArguments = mixin.typeArguments?.toSource() ?? '';
          final names = TypedMapNames(mixin.name.name);
          header.write('${names.consumerName}$typeArguments');
          header.write(',');
          header.write('${names.generatedMixinName}$typeArguments');
          // Don't write the comma if we're at the end of the list.
          // Do this manually instead of using `.join` so that we can always have
          // the warning comment be at the end of the line, regardless of whether the comma is there.
          if (i != mixins.length - 1) {
            header.write(',');
          }
          header.write(generatedMixinWarningCommentLine(names, isProps: isProps));
        }
      }

      header.write(' implements ${names.consumerName}$typeParamsOnSuper');

      return header.toString();
    } else {
      throw StateError('`member` is an unexpected type: $member');
    }
  }
}
