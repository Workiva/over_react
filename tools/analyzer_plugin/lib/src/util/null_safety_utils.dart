import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';

/// Returns whether [result] is in a library with null safety enabled.
bool withNullability(ResolvedUnitResult result) =>
    result.unit.declaredElement?.library.featureSet.isEnabled(Feature.non_nullable) ?? false;
