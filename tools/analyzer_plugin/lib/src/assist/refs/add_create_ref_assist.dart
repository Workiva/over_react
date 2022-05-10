import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

import 'add_create_ref.dart' as create_ref_util;

const _desc = r'Add a React ref to the currently selected component builder.';
// <editor-fold desc="Documentation Details">
const _details = r'''

When an over_react component builder is selected by the user, the assist adds a `ref` prop value
on the builder, set equal to a field that is added within the class instance, assigned to the return
value of a call to `createRef()`. 

''';
// </editor-fold>

/// An assist that adds a `ref` prop value to a component builder and assigns it to a field that is
/// added to a component class that gets assigned to the return value of a `createRef()` call.
///
/// > See: [create_ref_util.addCreateRef]
class AddCreateRefAssistContributor extends AssistContributorBase {
  @DocsMeta(_desc, details: _details)
  static const addRef = AssistKind('addRef', 32, 'Add ref');

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

    final changeBuilder = ChangeBuilder(session: request.result.session);
    await changeBuilder.addDartFileEdit(request.result.path!, (builder) {
      return create_ref_util.addCreateRef(builder, usage, request.result);
    });

    final sourceChange = changeBuilder.sourceChange
      ..message = addRef.message
      ..id = addRef.id;
    collector.addAssist(PrioritizedSourceChange(addRef.priority, sourceChange));
  }
}
