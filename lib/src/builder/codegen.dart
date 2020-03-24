// Copyright 2016 Workiva Inc.
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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:logging/logging.dart';
import 'package:source_span/source_span.dart';

import 'codegen/accessors_generator.dart';
import 'codegen/component_factory_generator.dart';
import 'codegen/component_generator.dart';
import 'codegen/typed_map_impl_generator.dart';
import 'codegen/util.dart';
import 'parsing.dart';

/// A utility class that generates implementations for a set of [BoilerplateDeclaration]s obtained from a [SourceFile].
///
/// Generates implementations for:
///
/// * A component comprised of a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
///
///     * Generates:
///
///          * Private subclasses for the component, props, and state classes, implementing stubbed methods.
///          * A private React component factory via a call to `registerComponent`.
///          * Metadata containing fields and keys for all Props and State classes.
///
///     * Wires up all the generated component pieces and exposes them via a function assigned to
///     the initializer of factory function variable.
///
/// * Any number of abstract component pieces: `@AbstractProps()`, `@AbstractState()`.
///
///     * Generate private subclasses which implement stubbed methods.
///     * Metadata containing fields and keys for all Abstract Props and Abstract State classes.
///
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`.
///
///     * Generates public subclasses which implement stubbed methods for any number of mixins in a library.
///     * Metadata containing fields and keys for all Props and State mixins.
class ImplGenerator {
  ImplGenerator(this.logger, this.sourceFile);

  final Logger logger;
  final StringBuffer outputContentsBuffer = StringBuffer();

  final SourceFile sourceFile;

  void generate(Iterable<BoilerplateDeclaration> declarations) {
    for (var declaration in declarations) {
      switch (declaration.type) {
        case DeclarationType.propsMapViewOrFunctionComponentDeclaration:
          _generatePropsMapViewOrFunctionComponent(declaration);
          break;
        case DeclarationType.classComponentDeclaration:
          _generateClassComponent(declaration);
          break;
        case DeclarationType.legacyClassComponentDeclaration:
          _generateLegacyClassComponent(declaration);
          break;
        case DeclarationType.legacyAbstractPropsDeclaration:
          _generateLegacyAbstractProps(declaration);
          break;
        case DeclarationType.legacyAbstractStateDeclaration:
          _generateLegacyAbstractState(declaration);
          break;
        case DeclarationType.propsMixinDeclaration:
          _generatePropsMixin(declaration);
          break;
        case DeclarationType.stateMixinDeclaration:
          _generateStateMixin(declaration);
          break;
        default:
          throw ArgumentError('Unhandled declaration type: $declaration');
      }
    }
  }

  /// Injects context variables like the output buffer into [generator], generates code,
  /// and then uninjects them.
  void _generateUsing(Generator generator) {
    generator
      ..sourceFile = sourceFile
      ..outputContentsBuffer = outputContentsBuffer
      ..logger = logger
      ..generate()
      ..sourceFile = null
      ..outputContentsBuffer = null
      ..logger = null;
  }

  void _generateLegacyClassComponent(LegacyClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryGenerator.legacy(declaration));
    _generateUsing(TypedMapAccessorsGenerator.legacyProps(declaration));
    _generateUsing(TypedMapImplGenerator.legacyProps(declaration));
    if (declaration.state != null) {
      _generateUsing(TypedMapAccessorsGenerator.legacyState(declaration));
      _generateUsing(TypedMapImplGenerator.legacyState(declaration));
    }
    _generateUsing(ComponentGenerator.legacy(declaration));
  }

  void _generateLegacyAbstractProps(LegacyAbstractPropsDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.legacyAbstractProps(declaration));
  }

  void _generateLegacyAbstractState(LegacyAbstractStateDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.legacyAbstractState(declaration));
  }

  void _generatePropsMixin(PropsMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.propsMixin(declaration));
  }

  void _generateStateMixin(StateMixinDeclaration declaration) {
    _generateUsing(TypedMapAccessorsGenerator.stateMixin(declaration));
  }

  void _generateClassComponent(ClassComponentDeclaration declaration) {
    _generateUsing(ComponentFactoryGenerator(declaration));
    _generateUsing(TypedMapImplGenerator.props(declaration));
    if (declaration.state != null) {
      _generateUsing(TypedMapImplGenerator.state(declaration));
    }
    _generateUsing(ComponentGenerator(declaration));
  }

  void _generatePropsMapViewOrFunctionComponent(
      PropsMapViewOrFunctionComponentDeclaration declaration) {
    _generateUsing(TypedMapImplGenerator.propsMapViewOrFunctionComponent(declaration));
  }
}
