// ignore_for_file: implementation_imports
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_assist_apis.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';
import 'package:over_react/src/builder/parsing/util.dart';

const _makeStatefulDesc = r'Make component stateful';
// <editor-fold desc="Make Stateful Documentation Details">
const _makeStatefulDetails = r'''

When the user's cursor is within the name of a `UiComponent2` class declaration, the assist can be 
used to convert it to a `UiStatefulComponent2`, complete with an analogous `UiState` mixin.

''';
// </editor-fold>

const _makeStatelessDesc = r'Make component stateless';
// <editor-fold desc="Make Stateless Documentation Details">
const _makeStatelessDetails = r'''

When the user's cursor is within the name of a `UiStatefulComponent2` class declaration, the assist can be 
used to convert it to a `UiComponent2`, removing the analogous `UiState` mixin / class.

''';
// </editor-fold>

class ToggleComponentStatefulness extends AssistContributorBase with ComponentDeclarationAssistApi {
  @DocsMeta(_makeStatefulDesc, details: _makeStatefulDetails)
  static const makeStateful = AssistKind('makeStateful', 30, _makeStatefulDesc);
  @DocsMeta(_makeStatelessDesc, details: _makeStatelessDetails)
  static const makeStateless = AssistKind('makeStateless', 30, _makeStatelessDesc);

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
