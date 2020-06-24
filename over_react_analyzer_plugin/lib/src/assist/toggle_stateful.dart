import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_assist_apis.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

// ignore_for_file: implementation_imports
import 'package:over_react/src/builder/parsing/util.dart';

class ToggleComponentStatefulness extends AssistContributorBase with ComponentDeclarationAssistApi {
  static AssistKind makeStateful = AssistKind('makeStateful', 30, 'Make component stateful.');
  static AssistKind makeStateless = AssistKind('makeStateless', 30, 'Make component stateless.');

  /// The counterpart base component class that will replace the current one.
  ///
  /// e.g "UiComponent2" / "UiStatefulComponent2", "FluxUiComponent2" / "FluxUiStatefulComponent2"
  String newComponentBaseClass;

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute() || !initializeAssistApi(request.result.content)) return;

    newComponentBaseClass = _getNewBase(componentSupertypeNode.name.name);

    // If there is no known corresponding base class, short circuit.
    if (newComponentBaseClass == null) return;

    if (state != null) {
      await _removeStatefulness();
    } else {
      await _addStatefulness();
    }
  }

  Future<void> _addStatefulness() async {
    final sourceChange = await buildFileEdit(request.result, (builder) {
      final defaultProps = componentDeclaration.component.nodeHelper.members.firstWhere((member) {
        return member is MethodDeclaration && member.declaredElement.name == 'defaultProps';
      }, orElse: () => null);

      const indent = '  ';

      final insertionOffset = defaultProps != null
          ? componentSourceFile.getOffsetForLineAfter(defaultProps.end)
          : componentSourceFile.getOffsetForLineAfter(componentDeclaration.component.nodeHelper.node.offset);

      builder.addInsertion(insertionOffset, (builder) {
        if (defaultProps != null) builder.write('\n');
        builder.write('$indent@override');
        builder.write('\n${indent}get initialState => (newState());\n');
        builder.write(!componentSourceFile.hasEmptyLineAfter(insertionOffset) ? '\n' : '');
      });

      builder.addInsertion(componentSourceFile.getOffsetForLineAfter(props.either.nodeHelper.node.end), (builder) {
        builder.write('\nmixin ${normalizedComponentName}State on UiState {}\n');
      });

      builder.addReplacement(range.node(componentSupertypeNode), (builder) {
        builder.write('$newComponentBaseClass<${props.either.name.name}, ${normalizedComponentName}State>');
      });
    });
    sourceChange
      ..message = makeStateful.message
      ..id = makeStateful.id;
    collector.addAssist(PrioritizedSourceChange(makeStateful.priority, sourceChange));
  }

  Future<void> _removeStatefulness() async {
    final sourceChange = await buildFileEdit(request.result, (builder) {
      final initialState = componentDeclaration.component.nodeHelper.members.firstWhere((member) {
        return member is MethodDeclaration && member.declaredElement.name == 'initialState';
      }, orElse: () => null);

      builder.addDeletion(componentSourceFile.getEncompassingRangeFor(state.either.nodeHelper.node));

      builder.addReplacement(range.node(componentSupertypeNode), (builder) {
        builder.write('$newComponentBaseClass<${normalizedComponentName}Props>');
      });

      if (initialState != null) {
        if (componentSourceFile.hasEmptyLineBefore(initialState.offset)) {
          builder.addDeletion(componentSourceFile.getEncompassingRangeFor(initialState));
        } else {
          builder.addDeletion(componentSourceFile.getPreciseRangeFor(initialState));
        }
      }
    });
    sourceChange
      ..message = makeStateless.message
      ..id = makeStateless.id;
    collector.addAssist(PrioritizedSourceChange(makeStateless.priority, sourceChange));
  }

  String _getNewBase(String oldBase) {
    const baseMapping = {
      'UiComponent2': 'UiStatefulComponent2',
      'FluxUiComponent2': 'FluxUiStatefulComponent2',
    };

    return baseMapping[oldBase] ??
        baseMapping.keys.firstWhere((key) => baseMapping[key] == oldBase, orElse: () => null);
  }
}
