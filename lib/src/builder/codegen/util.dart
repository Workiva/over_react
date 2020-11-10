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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';

import '../parsing.dart';
import 'names.dart';

abstract class BoilerplateDeclarationGenerator {
  SourceFile sourceFile;
  StringBuffer outputContentsBuffer;
  Logger logger;

  @protected
  Version get version;

  @protected
  String internalGeneratedMemberDeprecationLine({String additionalMessageStringLiteral = ''}) {
    final string = version.isLegacy
        ? ''
        : '@Deprecated('
            "'This API is for use only within generated code.'"
            "' Do not reference it in your code, as it may change at any time.'"
            '$additionalMessageStringLiteral'
            ')\n';

    assert(string.isEmpty || string.endsWith('\n'),
        'code that consumes this relies on there being a trailing newline if it is non-empty');
    return string;
  }

  void generate();
}

String getAccessorKeyNamespace(TypedMapNames names, annotations.TypedMap meta) {
  // Default to the name of the class followed by a period.
  final defaultNamespace = '${names.publicName}.';
  // Allow the consumer to specify a custom namespace that trumps the default.
  final specifiedKeyNamespace = meta?.keyNamespace;

  return specifiedKeyNamespace ?? defaultNamespace;
}

String generatedMixinWarningCommentLine(TypedMapNames mixinNames, {@required bool isProps}) {
  final value = '// If this generated mixin is undefined, it\'s likely because'
      ' ${mixinNames.consumerName} is not a valid `mixin`-based ${isProps ? 'props' : 'state'} mixin,'
      ' or because it is but the generated mixin was not imported.'
      ' Check the declaration of ${mixinNames.consumerName},'
      ' and check that ${mixinNames.generatedMixinName} is exported/imported properly.\n';

  assert(value.endsWith('\n'));

  return value;
}

void generatePropsMeta(
  StringBuffer buffer,
  List<Identifier> mixins, {
  String classType = 'PropsMetaCollection',
  String fieldName = 'propsMeta',
}) {
  buffer
    ..writeln()
    ..writeln('  @override')
    ..writeln('  $classType get $fieldName => const $classType({');
  for (final name in mixins) {
    final names = TypedMapNames(name.name);
    buffer.write('    ${generatedMixinWarningCommentLine(names, isProps: true)}');
    buffer.writeln('    ${names.consumerName}: ${names.publicGeneratedMetaName},');
  }
  buffer.writeln('  });');
}
