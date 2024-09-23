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

part of '../members.dart';

/// The class that represents a boilerplate component.
class BoilerplateComponent extends BoilerplateMember {
  BoilerplateComponent(this.nodeHelper, VersionConfidences confidence)
      : node = nodeHelper.node,
        super(confidence) {
    final meta = InstantiatedComponentMeta.fromNode<annotations.Component2>(node) ??
        // ignore: deprecated_member_use_from_same_package
        InstantiatedComponentMeta.fromNode<annotations.Component>(node);

    this.meta = meta?.value ?? annotations.Component2();
    configSubtypeOf = meta?.subtypeOfValue;
  }

  /// The [ClassDeclaration] backing the member
  @override
  final NamedCompilationUnitMember node;

  @override
  Token get name => nodeHelper.name;

  /// A metadata class that lifts helpful fields out of [node] to a top level,
  /// in addition to providing additional getters relevant member parsing.
  final ClassishDeclaration nodeHelper;

  /// Metadata around the member, which will most likely be [InstantiatedComponentMeta]
  /// or [annotations.Component2].
  @override
  // ignore: deprecated_member_use_from_same_package
  late annotations.Component meta;

  // The superclass that can be noted in the `@Component()` or `@Component2()` annotation.
  Identifier? configSubtypeOf;

  /// The [TypeAnnotation] for the component's prop class.
  TypeAnnotation? get propsGenericArg {
    return nodeHelper.superclass!.typeArguments?.arguments
        .firstWhereOrNull((type) => propsOrMixinNamePattern.hasMatch(type.typeNameWithoutPrefix!));
  }

  /// Whether or not the component has any annotation, ignoring component version
  /// and whether or not it is an abstract annotation.
  ///
  /// Related: [hasComponent1OrAbstractAnnotation], [hasComponent2OrAbstractAnnotation]
  bool get hasAnnotation => hasComponent1OrAbstractAnnotation || hasComponent2OrAbstractAnnotation;

  bool get hasComponent1OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component', 'AbstractComponent'});

  bool get hasComponent2OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component2', 'AbstractComponent2'});

  bool get hasAbstractAnnotation =>
      node.hasAnnotationWithNames({'AbstractComponent', 'AbstractComponent2'});

  /// Checks if the component is mixin based or has the Component2 annotation (including abstract).
  bool isComponent2(Version version) =>
      version == Version.v4_mixinBased || hasComponent2OrAbstractAnnotation;

  /// The names of the props that are definitely defaulted in this class component.
  ///
  /// See [getDefaultedPropNames] for more details.
  Set<String> get defaultedPropNames => getDefaultedPropNames(nodeHelper);

  /// Verifies the correct implementation of every boilerplate component version.
  ///
  /// Major checks included are:
  /// - Enforcing Component2 superclasses for mixin based boilerplate
  /// - Verifying no reserved static members are overridden
  /// - Checking for deprecated lifecycle method usage in conjunction with `Component2`
  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        final superclass = nodeHelper.superclass;
        if (superclass != null &&
            const {'UiComponent', 'UiStatefulComponent', 'FluxUiComponent', 'BuiltReduxUiComponent'}
                .contains(superclass.nameWithoutPrefix)) {
          errorCollector.addError(
              'Must extend UiComponent2, not UiComponent.', errorCollector.spanFor(superclass));
        }

        final badAnnotation = node.getAnnotationWithNames({'Component', 'AbstractComponent'});
        if (badAnnotation != null) {
          errorCollector.addError(
              'Only @Component2() is supported for this syntax. Remove or update this annotation.',
              errorCollector.spanFor(badAnnotation));
        }
        break;
      case Version.v2_legacyBackwardsCompat:
      case Version.v3_legacyDart2Only:
        break;
    }

    const reservedMembers = {
      'typedPropsFactory',
      'typedPropsFactoryJs',
      'typedStateFactory',
      'typedStateFactoryJs',
    };
    nodeHelper.members
        .whereType<MethodDeclaration>()
        .where((member) => !member.isStatic && reservedMembers.contains(member.name.name))
        .forEach((member) {
      // This is a warning since emitting an error would break existing code that's doing this.
      errorCollector.addWarning(
          'Components should not add their own implementations of ${member.name.name}.',
          errorCollector.spanFor(member.name));
    });

    // Ensure that Component2 declarations do not use legacy lifecycle methods.
    if (isComponent2(version)) {
      Map<String, String> legacyLifecycleMethodsMap = {
        'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
        'componentWillMount': 'Use componentDidMount instead.',
        'componentWillUpdate': 'Use getSnapshotBeforeUpdate and/or componentDidUpdate instead.',
      };

      final methods = nodeHelper.members.whereType<MethodDeclaration>().toList();
      legacyLifecycleMethodsMap.forEach((methodName, helpMessage) {
        final method = methods.firstWhereOrNull((m) => m.name.name == methodName);
        if (method != null) {
          errorCollector.addError(unindent('''
               When using Component2, a class cannot use ${method.name} because React 16 has removed ${method.name} 
               and renamed it UNSAFE_${method.name}.
               
               $helpMessage
               
               See https://reactjs.org/docs/react-component.html#legacy-lifecycle-methods for additional information.   
               '''), errorCollector.spanFor(method.name));
        }
      });
    }
  }
}

/// Returns the names of the props that are definitely defaulted in class component [classComponent].
///
/// This only includes simple assignments in `defaultProps` or `getDefaultProps`, and does not include
/// any props added in other ways, such as super-calls or `addProps`/`addAll`.
///
/// For example, this function would return `{'foo', 'bar'}` for the following component:
/// ```dart
/// class FooComponent extends UiComponent2<FooProps> {
///   @override
///   get defaultProps => (newProps()
///     ..foo = 1
///     ..bar = 2
///   );
/// }
/// ```
Set<String> getDefaultedPropNames(ClassishDeclaration classComponent) {
  final defaultPropsImpl = classComponent.members.whereType<MethodDeclaration>().firstWhereOrNull(
      (m) => !m.isStatic && const {'defaultProps', 'getDefaultProps'}.contains(m.name.name));
  if (defaultPropsImpl == null) return {};

  final body = defaultPropsImpl.body;
  Expression? returnValue;
  if (body is BlockFunctionBody) {
    // Don't worry about handling multiple return statements, ånd just use the first one.
    returnValue = body.block.statements.whereType<ReturnStatement>().firstOrNull?.expression;
  } else if (body is ExpressionFunctionBody) {
    returnValue = body.expression;
  }
  if (returnValue == null) return {};

  returnValue = returnValue.unParenthesized;
  if (returnValue is! CascadeExpression) return {};

  final target = returnValue.target;
  if (target is! MethodInvocation || target.methodName.name != 'newProps') return {};

  return returnValue.cascadeSections
      .whereType<AssignmentExpression>()
      .map((a) => a.leftHandSide)
      .whereType<PropertyAccess>()
      // Filter out prefixed accesses.
      // In `..dom.id = 'value'`, `p.target` is `dom`.
      // In `..foo = 'value'`, `p.target` is null.
      .where((p) => p.target == null)
      .map((p) => p.propertyName.name)
      .toSet();
}
