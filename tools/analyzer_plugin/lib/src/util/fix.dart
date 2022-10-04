import 'dart:async';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

Future<SourceChange> buildFileEdit(
  PotentiallyResolvedResult result,
  FutureOr<void> Function(DartFileEditBuilder builder) buildFileEdit,
) async {
  final builder = ChangeBuilder(session: result.session);
  await builder.addDartFileEdit(result.path!, buildFileEdit);
  return builder.sourceChange;
}

Future<SourceChange> buildGenericFileEdit(
  PotentiallyResolvedResult result,
  void Function(FileEditBuilder builder) buildFileEdit,
) async {
  final builder = ChangeBuilder(session: result.session);
  await builder.addGenericFileEdit(result.path!, buildFileEdit);
  return builder.sourceChange;
}

//Future<SourceChange> Function() getFixComputer(
//  ResolvedUnitResult result,
//  FutureOr<void> Function(DartFileEditBuilder builder) buildFileEdit,
//) {
//  Future<SourceChange> fixComputer() async {
//    final builder = new DartChangeBuilder(result.session);
//    await builder.addFileEdit(result.path, buildFileEdit);
//    return builder.sourceChange;
//  }
//
//  return fixComputer;
//}
