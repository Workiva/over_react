import 'dart:mirrors';

String getName(Type type) {
  return MirrorSystem.getName(reflectType(type).simpleName);
}


//import 'package:analyzer/analyzer.dart';
//import 'package:transformer_utils/transformer_utils.dart';
//
//import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
//
//String generatePropsAccessorsClass(AccessorType type,
//    String accessorsMixinName,
//    NodeWithMeta node, String name) {
//  var isProps = type == AccessorType.props;
//  StringBuffer generatedClass = new StringBuffer();
//  generatedClass.writeln(
//      'abstract class $accessorsMixinName {\n' +
//          '  Map get ${isProps ? 'props' : 'state'};\n'
//  );
//
//  generatedClass.write(generateAccessors(type, node).implementations);
//
//  generatedClass.writeln('}\n');
//
//  // TODO: Remove this call
//  generatedClass.writeln(_generateMetaClass(type, name, accessorsMixinName));
//  generatedClass.writeln();
//  return generatedClass.toString();
//}
//
//
//String _generateMetaClass(AccessorType type, String name,
//    String accessorMixinName) {
//  var isProps = type == AccessorType.props;
//  final metaStructName = isProps ? 'PropsMeta' : 'StateMeta';
//  final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
//  final String constantListName = isProps ? staticPropsName : staticStateName;
//  final String metaObjectName = getMetaClassName(name);
//
//  var output = new StringBuffer();
//  output.writeln(
//      'const $metaStructName $metaObjectName = const $metaStructName(');
//  output.writeln('  fields: $accessorMixinName.$constantListName,');
//  output.writeln('  keys: $accessorMixinName.$keyListName,');
//  output.writeln(');\n');
//  return output.toString();
//}
//
//AccessorOutput generateAccessors(AccessorType type,
//    NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap, {bool shouldFixDdcAbstractAccessors: false}) {
//  if (shouldFixDdcAbstractAccessors) {
//    fixDdcAbstractAccessors(type, typedMap);
//  }
//
//  String keyNamespace = getAccessorKeyNamespace(typedMap);
//
//  final bool isProps = type == AccessorType.props;
//
//  final String proxiedMapName = isProps
//      ? proxiedPropsMapName
//      : proxiedStateMapName;
//  final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
//  final String constantListName = isProps ? staticPropsName : staticStateName;
//  final String constConstructorName = isProps
//      ? 'PropDescriptor'
//      : 'StateDescriptor';
//
//  Map keyConstants = {};
//  Map constants = {};
//
//  StringBuffer output = new StringBuffer();
//
//  typedMap.node.members
//      .where((member) => member is FieldDeclaration && !member.isStatic)
//      .forEach((_field) {
//    final field = _field as FieldDeclaration; // ignore: avoid_as
//
//    T getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
//      return member.metadata.any((annotation) => annotation.name?.name == name)
//          ? value
//          : null;
//    }
//
//    annotations.Accessor accessorMeta = instantiateAnnotation(
//        field, annotations.Accessor);
//    annotations.Accessor requiredProp = getConstantAnnotation(
//        field, 'requiredProp', annotations.requiredProp);
//    annotations.Accessor nullableRequiredProp = getConstantAnnotation(
//        field, 'nullableRequiredProp', annotations.nullableRequiredProp);
//    // ignore: deprecated_member_use
//    annotations.Required requiredMeta = instantiateAnnotation(
//        field, annotations.Required);
//
//    if (accessorMeta?.doNotGenerate == true) {
//      logger.fine('Skipping generation of field `$field`.',
////                span: getSpan(sourceFile, field)
//      );
//
//      return;
//    }
//
//    // Remove everything in the field except the comments/meta and the variable names, preserving newlines.
//    // TODO add support for preserving comment nodes between variable declarations.
//
//    // Remove content between end of comment/meta and first variable name
////          transformedFile?.remove(
////              sourceFile?.span(field.firstTokenAfterCommentAndMetadata.offset, field.fields.variables.first.beginToken.offset),
////              preserveNewlines: true
////          );
//    // Remove content between variable names (including commas).
////          var prevVariable = field.fields.variables.first;
////          field.fields.variables.skip(1).forEach((variable) {
////            transformedFile?.remove(
////                sourceFile?.span(prevVariable.name.end, variable.name.offset),
////                preserveNewlines: true
////            );
////            prevVariable = variable;
////          });
//    // Remove content between last variable name and the end of the field (including the semicolon).
////          transformedFile?.remove(
////              sourceFile?.span(field.fields.variables.last.end, field.end),
////              preserveNewlines: true
////          );
//
//    field.fields.variables.forEach((VariableDeclaration variable) {
//      if (variable.initializer != null) {
//        logger.severe(
//          'Fields are stubs for generated setters/getters and should not have initializers.',
////                  span: getSpan(sourceFile, variable)
//        );
//      }
//
//      String accessorName = variable.name.name;
//
//      String individualKeyNamespace = accessorMeta?.keyNamespace ??
//          keyNamespace;
//      String individualKey = accessorMeta?.key ?? accessorName;
//
//      /// Necessary to work around issue where private static declarations in different classes
//      /// conflict with each other in strong mode: https://github.com/dart-lang/sdk/issues/29751
//      /// TODO remove once that issue is resolved
//      String staticConstNamespace = typedMap.node.name.name;
//
//      String keyConstantName = '${generatedPrefix}key__${accessorName}__$staticConstNamespace';
//      String keyValue = stringLiteral(individualKeyNamespace + individualKey);
//
//      String constantName = '${generatedPrefix}prop__${accessorName}__$staticConstNamespace';
//      String constantValue = 'const $constConstructorName($keyConstantName';
//
//      var annotationCount = 0;
//
//      if (accessorMeta != null) {
//        annotationCount++;
//
//        if (accessorMeta.isRequired) {
//          constantValue += ', isRequired: true';
//
//          if (accessorMeta.isNullable) constantValue += ', isNullable: true';
//
//          if (accessorMeta.requiredErrorMessage != null &&
//              accessorMeta.requiredErrorMessage.isNotEmpty) {
//            constantValue += ', errorMessage: ${stringLiteral(
//                accessorMeta.requiredErrorMessage)}';
//          }
//        }
//      }
//
//      if (requiredMeta != null) {
//        constantValue += ', isRequired: true';
//
//        if (requiredMeta.isNullable) constantValue += ', isNullable: true';
//
//        if (requiredMeta.message != null && requiredMeta.message.isNotEmpty) {
//          constantValue +=
//          ', errorMessage: ${stringLiteral(requiredMeta.message)}';
//        }
//      }
//
//      if (requiredProp != null) {
//        annotationCount++;
//        constantValue += ', isRequired: true';
//      }
//
//      if (nullableRequiredProp != null) {
//        annotationCount++;
//        constantValue += ', isRequired: true, isNullable: true';
//      }
//
//      if (annotationCount > 1) {
//        logger.severe(
//          '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
//              'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
////                  span: getSpan(sourceFile, field)
//        );
//      }
//
//      constantValue += ')';
//
//      keyConstants[keyConstantName] = keyValue;
//      constants[constantName] = constantValue;
//
//      TypeName type = field.fields.type;
//      String typeString = type == null ? '' : '$type ';
//      String setterTypeString = field.covariantKeyword == null
//          ? typeString
//          : '${field.covariantKeyword} $typeString';
//
//      String generatedAccessor =
//          '  ${typeString}get $accessorName => $proxiedMapName[$keyConstantName];\n'
//          '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;\n';
//
//      output.write(generatedAccessor);
////            transformedFile?.replace(
////                sourceFile?.span(variable.firstTokenAfterCommentAndMetadata.offset, variable.name.end),
////                generatedAccessor
////            );
//
////            logger.fine('Generated accessor `$accessorName` with key $keyValue.',
////                span: getSpan(sourceFile, variable)
////            );
//    });
//
//    if (field.fields.variables.length > 1 &&
//        (field.documentationComment != null || field.metadata.isNotEmpty)) {
//      logger.warning(
//        'Note: accessors declared as comma-separated variables will not all be generated '
//            'with the original doc comments and annotations; only the first variable will.',
////                span: getSpan(sourceFile, field.fields)
//      );
//    }
//  });
//
//  var keyConstantsImpl;
//  var constantsImpl;
//
//  if (keyConstants.keys.isEmpty) {
//    keyConstantsImpl = '';
//  } else {
//    keyConstantsImpl =
//        keyConstants.keys.map((
//            keyName) => '  static const String $keyName = ${keyConstants[keyName]}')
//            .join(';\n') +
//            ';\n';
//  }
//
//  if (constants.keys.isEmpty) {
//    constantsImpl = '';
//  } else {
//    constantsImpl =
//        constants.keys.map((
//            constantName) => '  static const $constConstructorName $constantName = ${constants[constantName]}')
//            .join(';\n') +
//            ';\n';
//  }
//
//  String keyListImpl =
//      '  static const List<String> $keyListName = const [' +
//          keyConstants.keys.join(', ') +
//          '];\n';
//
//  String listImpl =
//      '  static const List<$constConstructorName> $constantListName = const [' +
//          constants.keys.join(', ') +
//          '];\n';
//
//  String staticVariablesImpl = '  /* GENERATED CONSTANTS */ \n$constantsImpl$keyConstantsImpl\n$listImpl$keyListImpl';
//
//  output.write(staticVariablesImpl);
//  return new AccessorOutput(output.toString());
//}
//
///// Apply a workaround for an issue where, in the DDC, abstract getter or setter overrides declared in a class clobber
///// the inherited concrete implementations. <https://github.com/dart-lang/sdk/issues/29914>
/////
///// Fixes the issue by generating corresponding abstract getters/setters to complete the pair
///// for accessors with the `@override` annotation.
//void fixDdcAbstractAccessors(AccessorType accessorType,
//    NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap,) {
//  var candidateAccessors = new List<MethodDeclaration>.from(
//      typedMap.node.members.where((member) =>
//      member is MethodDeclaration &&
//          (member.isGetter || member.isSetter) &&
//          !member.isSynthetic &&
//          !member.isStatic &&
//          member.metadata.any((meta) => meta.name.name == 'override')
//      )
//  );
//
//  for (var accessor in candidateAccessors) {
//    // Non-abstract accessors don't exhibit this issue.
//    if (!accessor.isAbstract) return;
//
//    var name = accessor.name.name;
//
//    // Don't generate for `Map get props;`/`Map get state;` in mixins
//    if (accessorType == AccessorType.props && name == 'props') continue;
//    if (accessorType == AccessorType.state && name == 'state') continue;
//
//    if (candidateAccessors.any((other) =>
//    other != accessor && other.name.name == name)) {
//      // Don't generate when both the getter and the setter are declared.
//      continue;
//    }
//
//    /// Warning: tests rely on this comment as a means of determining whether this fix was applied.
//    ///
//    /// DO NOT modify or remove without updating tests
//    const String generatedComment = ' /* fixDdcAbstractAccessors workaround: */ ';
//
//    if (accessor.isGetter) {
//      var type = accessor.returnType?.toSource();
//      var typeString = type == null ? '' : '$type ';
//
//      transformedFile?.insert(sourceFile?.location(accessor.end),
//          // use `covariant` here to be extra safe in this typing
//          '${generatedComment}set $name(covariant ${typeString}value);');
//    } else {
//      var parameter = accessor.parameters.parameters.single;
//      var type = parameter is SimpleFormalParameter
//          ? parameter.type?.toSource()
//      // This `null` case is mainly for [FunctionTypedFormalParameter].
//          : null;
//      var typeString = type == null ? '' : '$type ';
//
//      transformedFile?.insert(sourceFile?.location(accessor.end),
//          '$generatedComment${typeString}get $name;');
//    }
//  }
//}}
//
//enum AccessorType {props, state}
//
//class AccessorOutput {
//  final String implementations;
//
//  AccessorOutput(this.implementations);
//}
