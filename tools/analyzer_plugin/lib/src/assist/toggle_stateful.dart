import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
// This error is unavoidable until over_react's builder is null-safe. See this library's doc comment for more info.
// ignore: import_of_legacy_library_into_null_safe
import 'package:over_react_analyzer_plugin/src/over_react_builder_parsing.dart' as orbp;
import 'package:over_react_analyzer_plugin/src/util/boilerplate_assist_apis.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

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
  static const int statefulAssistPriority = 30;
  @DocsMeta(_makeStatefulDesc, details: _makeStatefulDetails)
  static const makeStateful = AssistKind('makeStateful', statefulAssistPriority, _makeStatefulDesc);
  @DocsMeta(_makeStatelessDesc, details: _makeStatelessDetails)
  static const makeStateless = AssistKind('makeStateless', statefulAssistPriority, _makeStatelessDesc);

  /// The counterpart base component class that will replace the current one.
  ///
  /// e.g "UiComponent2" / "UiStatefulComponent2", "FluxUiComponent2" / "FluxUiStatefulComponent2"
  String? newComponentBaseClass;

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute() || !initializeAssistApi(request.result.content!)) return;

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
      final defaultProps = componentDeclaration!.component.nodeHelper.members.firstWhereOrNull((member) {
        return member is MethodDeclaration && member.declaredElement!.name == 'defaultProps';
      });

      const indent = '  ';

      final insertionOffset = defaultProps != null
          ? componentSourceFile.getOffsetForLineAfter(defaultProps.end)
          : componentSourceFile.getOffsetForLineAfter(componentDeclaration!.component.nodeHelper.node.offset);

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
      final initialState = componentDeclaration!.component.nodeHelper.members.firstWhereOrNull((member) {
        return member is MethodDeclaration && member.declaredElement!.name == 'initialState';
      });

      builder.addDeletion(componentSourceFile.getEncompassingRangeFor(state!.either.nodeHelper.node));

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

  String? _getNewBase(String oldBase) {
    const baseMapping = {
      'UiComponent2': 'UiStatefulComponent2',
      'FluxUiComponent2': 'FluxUiStatefulComponent2',
    };

    return baseMapping[oldBase] ?? baseMapping.keys.firstWhereOrNull((key) => baseMapping[key] == oldBase);
  }
}
