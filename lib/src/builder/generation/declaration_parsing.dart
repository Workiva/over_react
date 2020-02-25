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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/util/string_util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart' show getSpan, NodeWithMeta;

/// A set of [NodeWithMeta] component pieces declared using `over_react` builder annotations.
///
/// Can include:
///
/// * A single component declared using a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
/// * Any number of abstract component pieces: `@AbstractComponent()`, `@AbstractProps()`, `@AbstractState()`
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`
class ParsedDeclarations {
  foo(CompilationUnit unit, SourceFile sourceFile, Logger logger) {
    bool hasErrors = false;
    bool hasDeclarations = false;
    bool hasPropsCompanionClass = false;
    bool hasAbstractPropsCompanionClass = false;
    bool hasStateCompanionClass = false;
    bool hasAbstractStateCompanionClass = false;

    void error(String message, [SourceSpan span]) {
      hasErrors = true;
      logger.severe(messageWithSpan(message, span: span));
    }


    void updateCompanionClass(String annotation, bool value) {
      switch (annotation) {
        case 'Props':
          hasPropsCompanionClass = value;
          break;
        case 'AbstractProps':
          hasAbstractPropsCompanionClass = value;
          break;
        case 'State':
          hasStateCompanionClass = value;
          break;
        case 'AbstractState':
          hasAbstractStateCompanionClass = value;
          break;
      }
    }

    bool isPropsClass(String annotation) {
      return (annotation == 'Props' || annotation == 'AbstractProps');
    }

    bool isStateClass(String annotation) {
      return (annotation == 'State' || annotation == 'AbstractState');
    }

    unit.declarations.forEach((_member) {
      _member.metadata.forEach((_annotation) {
        final annotation = _annotation.name.toString();

        // Add to declarationMap if we have a valid over_react annotation
        if (declarationMap[annotation] != null) {
          hasDeclarations = true;
          declarationMap[annotation].add(_member);
        }

        // Now we need to check for a companion class on Dart 2 backwards compatible boilerplate
        // only check for companion class for @Props(), @State, @AbstractProps(),
        // and @AbstractState() annotated classes
        if (_member is! ClassDeclaration || !(isPropsClass(annotation) || isStateClass(annotation))) {
          return;
        }

        final ClassDeclaration member = _member;

        // Check that class name starts with [privateSourcePrefix]
        if (!member.name.name.startsWith(privateSourcePrefix)) {
          error('The class `${member.name.name}` does not start with `$privateSourcePrefix`. All Props, State, '
              'AbstractProps, and AbstractState classes should begin with `$privateSourcePrefix` on Dart 2',
              getSpan(sourceFile, member));
          return;
        }

        final companionName = member.name.name.substring(privateSourcePrefix.length);
        final companionClass = unit.declarations.firstWhere(
                (innerMember) =>
            innerMember is ClassDeclaration && innerMember.name.name == companionName,
            orElse: () => null);

        final hasCompanionClass = companionClass != null;
        if (hasCompanionClass) {
          // Backwards compatible boilerplate. Verify the companion class' meta field
          updateCompanionClass(annotation, true);
          validateMetaField(companionClass, isPropsClass(annotation) ? 'PropsMeta': 'StateMeta');
        } else {
          // Dart 2 only boilerplate. Check for meta presence
          checkForMetaPresence(member);
          updateCompanionClass(annotation, false);
        }
      });
    });
  {
      void checkMetaForMixin(ClassDeclaration mixin, String metaStructName) {
        final className = mixin.name.name;
        // If the mixin starts with `_$`, then we are on Dart 2 only boilerplate,
        // and the mixin should not have a meta field/method
        if (className.startsWith(privateSourcePrefix)) {
          checkForMetaPresence(mixin);
        } else {
          // If the mixin does start not start with `_$`, then we are on the transitional
          // boilerplate and we need to validate the meta field.
          validateMetaField(mixin, metaStructName);
        }
      }
      for (final propsMixin in declarationMap[key_propsMixin]) {
        checkMetaForMixin(propsMixin, 'PropsMeta');
      }

      for (final stateMixin in declarationMap[key_stateMixin]) {
        checkMetaForMixin(stateMixin, 'StateMeta');
      }
    }
    if (hasErrors) {
      for (final key in declarationMap.keys) {
        declarationMap[key] = [];
      }
    }
  }

  static final RegExp maybeDeclarationPattern = RegExp(
      // todo is this necessary?
      r'\.over_react\.g\.dart'
      r'|@(?:' +
      [
        key_factory,
        key_component,
        key_component2,
        key_props,
        key_state,
        key_abstractComponent,
        key_abstractComponent2,
        key_abstractProps,
        key_abstractState,
        key_propsMixin,
        key_stateMixin,
      ].join('|').replaceAll(r'$', r'\$') +
      r')'
      r'|Ui(?:Factory|Props|Component|State)',
      caseSensitive: true
  );

  static bool mightContainDeclarations(String source) {
    return maybeDeclarationPattern.hasMatch(source);
  }
}

// Generic type aliases, for readability.

