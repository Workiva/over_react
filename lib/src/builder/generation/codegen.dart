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
import 'package:over_react/src/builder/generation/codegen/accessors_class_generator.dart';
import 'package:over_react/src/builder/generation/codegen/accessors_impl_generator.dart';
import 'package:over_react/src/builder/generation/codegen/component_generator.dart';
import 'package:source_span/source_span.dart';

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
      if (declaration is LegacyClassComponentDeclaration) {
        _generateUsing(ComponentFactoryGenerator.legacy(declaration));
        _generateUsing(LegacyPropsOrStateGenerator.props(declaration));
        _generateUsing(LegacyPropsOrStateImplGenerator.props(declaration));
        if (declaration.state != null) {
          _generateUsing(LegacyPropsOrStateGenerator.state(declaration));
          _generateUsing(LegacyPropsOrStateImplGenerator.state(declaration));
        }
        _generateUsing(LegacyComponentGenerator(declaration));
      } else if (declaration is LegacyAbstractPropsDeclaration) {
        _generateUsing(LegacyPropsOrStateGenerator.abstractProps(declaration));
      } else if (declaration is LegacyAbstractStateDeclaration) {
        _generateUsing(LegacyPropsOrStateGenerator.abstractState(declaration));
      } else if (declaration is PropsMixinDeclaration) {
        _generateUsing(MixinAccessorsGenerator.props(declaration));
      } else if (declaration is StateMixinDeclaration) {
        _generateUsing(MixinAccessorsGenerator.state(declaration));
      } else if (declaration is ClassComponentDeclaration) {
        _generateUsing(ComponentFactoryGenerator(declaration));
        _generateUsing(PropsOrStateImplGenerator.props(declaration));
        if (declaration.state != null) {
          _generateUsing(PropsOrStateImplGenerator.state(declaration));
        }
        _generateUsing(ComponentGenerator(declaration));
      } else if (declaration is PropsMapViewDeclaration) {
        logger
            .severe('Codegen for new boilerplate (PropsMapViewDeclaration) is not yet implemented');
      } else if (declaration is FunctionComponentDeclaration) {
        logger.severe('Codegen for new boilerplate is not yet implemented $declaration');
      } else {
        throw StateError('Unhandled declaration type: $declaration');
      }
    }
  }

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
}
