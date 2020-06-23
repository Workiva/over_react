import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/component_assist_api.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

// ignore_for_file: implementation_imports
import 'package:over_react/src/builder/parsing/util.dart';

class ToggleComponentStatefulness extends AssistContributorBase with ComponentDeclarationAssistApi {
  static AssistKind makeStateful = AssistKind('makeStateful', 30, 'Make component stateful.');
  static AssistKind makeStateless = AssistKind('makeStateless', 30, 'Make component stateless.');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute() || !initializeAssistApi(request.result.content)) return;

    if (state != null) {
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

      const indent = '  ';

      final insertionOffset = defaultProps != null
          ? componentSourceFile.getOffsetForLineAfter(defaultProps.end)
          : componentSourceFile.getOffsetForLineAfter(component.component.nodeHelper.node.offset);

      builder.addInsertion(insertionOffset, (builder) {
        if (defaultProps != null) builder.write('\n');
        builder.write('$indent@override');
        builder.write('\n${indent}get initialState => (newState());\n');
        builder.write(!componentSourceFile.hasEmptyLineAfter(insertionOffset) ? '\n' : '');
      });

      builder.addInsertion(componentSourceFile.getOffsetForLineAfter(props.either.nodeHelper.node.end), (builder) {
        builder.write('\nmixin ${normalizedComponentName}State on UiState {}\n');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write(
            '${_getNewBase(component.component.nodeHelper.superclass.name.name)}<${props.either.name.name}, ${normalizedComponentName}State>');
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

      builder.addReplacement(componentSourceFile.getEncompassingRangeFor(state.either.nodeHelper.node), (builder) {
        builder.write('');
      });

      builder.addReplacement(range.node(componentType), (builder) {
        builder.write(
            '${_getNewBase(component.component.nodeHelper.superclass.name.name)}<${normalizedComponentName}Props>');
      });

      if (initialState != null) {
        if (componentSourceFile.hasEmptyLineBefore(initialState.offset)) {
          builder.addReplacement(componentSourceFile.getEncompassingRangeFor(initialState), (builder) {
            builder.write('');
          });
        } else {
          builder.addReplacement(componentSourceFile.getPreciseRangeFor(initialState), (builder) {
            builder.write('');
          });
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

    final newBase = baseMapping[oldBase] ?? baseMapping.keys.where((key) => baseMapping[key] == oldBase).firstOrNull;

    if (newBase == null) {
      throw ArgumentError(
          'Unknown component base. This assist only expects UiComponent2 or FluxUiComponent2 (and their stateful counterparts).');
    }

    return newBase;
  }
}
