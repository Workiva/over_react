import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';
import 'package:over_react_analyzer_plugin/src/util/linked_edits.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:source_span/source_span.dart';

class RenameComponentFactoryContributor extends AssistContributorBase {
  AssistKind extractComponent = AssistKind('extractComponent', 150, 'Rename component factory');

  bool isFactory(TopLevelVariableDeclaration decl) {
    final type = decl.variables.type;
    return type is TypeName && type.name.name == 'UiFactory';
  }

  String groupName = 'renameComponentFactory';

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    if (node is SimpleIdentifier) {
      final factoryDecl = node.thisOrAncestorOfType<TopLevelVariableDeclaration>();

      if (factoryDecl != null && isFactory(factoryDecl)) {
        final sourceFile = SourceFile.fromString(request.result.content, url: request.result.path);
        final errorCollector = ErrorCollector.callback(sourceFile);
        final declarations = parseDeclarations(request.result.unit, errorCollector);

        for (final declaration in declarations) {
          final members = declaration.members;
          final factories = members.whereType<BoilerplateFactory>();

          if (factories.isNotEmpty && factories.first.node == factoryDecl) {
            final newFactoryName = factories.first.name.name;

            final sourceChange = await buildFileEdit(request.result, (builder) {
              for (final member in members) {
                renameBoilerplateMemberHelper(builder, member, newFactoryName, groupName);
                if (member is BoilerplateFactory) {
                  renameComponentFactoryLinkedEdit(builder, member, newFactoryName, groupName);
                }
              }
            });

            sourceChange
              ..message = extractComponent.message
              ..id = extractComponent.id;
            collector.addAssist(PrioritizedSourceChange(extractComponent.priority, sourceChange));
          }
        }
      }
    }
  }
}
