import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/component_assist_api.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

class ToggleComponentStatefulness extends AssistContributorBase with ComponentDeclarationAssistApi {
  static AssistKind makeStateful = AssistKind('makeStateful', 30, 'Make component stateful.');
  static AssistKind makeStateless = AssistKind('makeStateless', 30, 'Make component stateless.');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    initializeAssistApi(request.result.unit, request.result.content);

    if (!isAValidComponentDeclaration) return;

    if (stateMixin != null) {
      await _removeStatefulness();
    } else {
      await _addStatefulness();
    }
  }

  Future<void> _addStatefulness() async {
    final sourceChange = await buildFileEdit(request.result, (builder) {
      final defaultProps = component.component.nodeHelper.members.firstWhere((member) {
        return member is MethodDeclaration && member.declaredElement.name == 'defaultProps';
      }, orElse: () => null);

      var indentOffset = 0;

      if (defaultProps != null) {
        indentOffset = defaultProps.offset;
      } else {
        final renderMethod = component.component.nodeHelper.members.firstWhere((e) {
          if (e is MethodDeclaration) {
            if (e.name.name == 'render') {
              return true;
            }
          }

          return false;
        });

        indentOffset = renderMethod.offset;
      }

      final indent = getIndent(
        request.result.content,
        request.result.unit.declaredElement.lineInfo,
        indentOffset,
      );

      final insertionOffset = defaultProps != null
          ? componentSourceFile.getOffsetForLineAfter(defaultProps.end)
          : componentSourceFile.getOffsetForLineAfter(component.component.nodeHelper.node.offset);

      builder.addInsertion(insertionOffset, (builder) {
        builder.write('\n$indent@override');
        builder.write('\n${indent}get initialState => (newState());\n');
      });

      builder.addInsertion(componentSourceFile.getOffsetForLineAfter(propsMixin.nodeHelper.node.end), (builder) {
        builder.write('\nmixin ${normalizedComponentName}State on UiState {}\n');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write('UiStatefulComponent2<${normalizedComponentName}Props, ${normalizedComponentName}State>');
      });
    });
    sourceChange
      ..message = makeStateful.message
      ..id = makeStateful.id;
    collector.addAssist(PrioritizedSourceChange(makeStateful.priority, sourceChange));
  }

  Future<void> _removeStatefulness() async {
    final sourceChange = await buildFileEdit(request.result, (builder) {
      final initialState = component.component.nodeHelper.members.firstWhere((member) {
        return member is MethodDeclaration && member.declaredElement.name == 'initialState';
      }, orElse: () => null);

      builder.addReplacement(componentSourceFile.getEncompassingRangeFor(stateMixin.nodeHelper.node), (builder) {
        builder.write('');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write('UiComponent2<${normalizedComponentName}Props>');
      });

      if (initialState != null) {
        builder.addReplacement(componentSourceFile.getEncompassingRangeFor(initialState), (builder) {
          builder.write('');
        });
      }
    });
    sourceChange
      ..message = makeStateless.message
      ..id = makeStateless.id;
    collector.addAssist(PrioritizedSourceChange(makeStateless.priority, sourceChange));
  }
}
