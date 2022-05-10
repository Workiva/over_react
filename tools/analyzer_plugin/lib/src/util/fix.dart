import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

Future<SourceChange> buildFileEdit(
  ResolvedUnitResult result,
  FutureOr<void> Function(DartFileEditBuilder builder) buildFileEdit,
) async {
  final builder = ChangeBuilder(session: result.session);
  await builder.addDartFileEdit(result.path!, buildFileEdit);
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
