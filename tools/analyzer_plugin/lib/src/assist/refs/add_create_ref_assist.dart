import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

import 'add_create_ref.dart' as create_ref_util;

/// An assist that adds a `ref` prop value to a component builder and assigns it to a field that is
/// added to a component class that gets assigned to the return value of a `createRef()` call.
///
/// > See: [create_ref_util.addCreateRef]
class AddCreateRefAssistContributor extends AssistContributorBase {
  static AssistKind addRef = AssistKind('addRef', 32, 'Add ref');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _addCreateRef();
  }

  Future<void> _addCreateRef() async {
    final usage = identifyUsage(node);

    if (usage == null) return;

    // The StringRefDiagnostic/CallbackRefDiagnostic will handle adding suggestions to
    // replace existing refs with createRef.
    if (usage.cascadedProps.any((prop) => prop.name.name == 'ref')) return;

    final changeBuilder = DartChangeBuilder(session);
    await changeBuilder.addFileEdit(request.result.path, (builder) {
      return create_ref_util.addCreateRef(builder, usage, request.result);
    });

    final sourceChange = changeBuilder.sourceChange
      ..message = addRef.message
      ..id = addRef.id;
    collector.addAssist(PrioritizedSourceChange(addRef.priority, sourceChange));
  }
}
