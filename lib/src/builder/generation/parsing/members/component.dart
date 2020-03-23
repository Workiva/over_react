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

  BoilerplateComponent(this.nodeHelper, VersionConfidence confidence)
      : node = nodeHelper.node,
        super(confidence) {
    final meta = InstantiatedComponentMeta<annotations.Component2>(node) ??
        // ignore: deprecated_member_use_from_same_package
        InstantiatedComponentMeta<annotations.Component>(node);

    this.meta = meta?.value ?? annotations.Component2();
    configSubtypeOf = meta?.subtypeOfValue;
  }

  /// The [ClassDeclaration] backing the member
  @override
  final NamedCompilationUnitMember node;

  @override
  SimpleIdentifier get name => nodeHelper.name;

  /// A metadata class that lifts helpful fields out of [node] to a top level,
  /// in addition to providing additional getters relevant member parsing.
  final ClassishDeclaration nodeHelper;

  /// Metadata around the member, which will most likely be [InstantiatedComponentMeta]
  /// or [annotations.Component2].
  @override
  // ignore: deprecated_member_use_from_same_package
  annotations.Component meta;

  // The superclass that can be noted in the `@Component()` or `@Component2()` annotation.
  Identifier configSubtypeOf;

  /// The [TypeAnnotation] for the component's prop class.
  TypeAnnotation get propsGenericArg {
    return nodeHelper.superclass.typeArguments?.arguments
        ?.firstWhere((type) => type.typeNameWithoutPrefix.endsWith('Props'), orElse: () => null);
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
        if (const ['UiComponent', 'UiStatefulComponent', 'FluxUiComponent']
            .contains(superclass?.nameWithoutPrefix)) {
          errorCollector.addError(
              'Must extend UiComponent2, not UiComponent.', errorCollector.spanFor(superclass));
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
          'Components should not add their own implementions of ${member.name.name}.',
          errorCollector.spanFor(member));
    });

    // Ensure that Component2 declarations do not use legacy lifecycle methods.
    if (isComponent2(version) && node is ClassOrMixinDeclaration) {
      Map<String, String> legacyLifecycleMethodsMap = {
        'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
        'componentWillMount': 'Use init instead.',
        'componentWillUpdate': 'Use getSnapshotBeforeUpdate instead.',
      };

      legacyLifecycleMethodsMap.forEach((methodName, helpMessage) {
        final method = (node as ClassOrMixinDeclaration).getMethod(methodName);
        if (method != null) {
          errorCollector.addError(unindent('''
               When using Component2, a class cannot use ${method.name} because React 16 has removed ${method.name} 
               and renamed it UNSAFE_${method.name}.
               
               $helpMessage
               
               See https://reactjs.org/docs/react-component.html#legacy-lifecycle-methods for additional information.   
               '''), errorCollector.spanFor(method));
        }
      });
    }
  }
}
