// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'script.dart';
import 'scope.dart';
import 'source_location.dart';

VMSourceReport newSourceReport(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "SourceReport");

  var scripts = (json['scripts'] as List)
      .map((script) => newVMScriptRef(scope, script))
      .toList();

  var ranges = new List<VMSourceReportRange>.unmodifiable(
      (json['ranges'] as List).map((rangeItem) =>
          new VMSourceReportRange._fromJson(rangeItem, scripts)));

  return new VMSourceReport._(ranges);
}

/// A report about ranges of source code.
///
/// [ranges] exposes code coverage and information on possible breakpoints.
class VMSourceReport {
  /// Ranges in the program source corresponding to ranges of executable code in
  /// the user's program.
  ///
  /// Ranges can include members such as functions, methods, and
  /// constructors.
  ///
  /// Note: ranges may nest in other ranges, in the case of nested functions.
  /// Ranges may be duplicated, in the case of mixins.
  final List<VMSourceReportRange> ranges;

  VMSourceReport._(this.ranges);
}

/// A range of executable code (function, method, constructor, etc)
/// in the running program.
///
/// This is part of a [VMSourceReport].
class VMSourceReportRange {
  VMScriptRef get script => location.script;

  /// The location of the range in the target script.
  final VMSourceLocation location;

  /// `true` if this range been compiled by the Dart VM.
  ///
  /// If `false`, `possibleBreakpoints`, `hits`, and `misses` will be `null`.
  ///
  /// Use `forceCompile` in `getSourceReport` to ensure the target scripts are
  /// compiled.
  final bool compiled;

  /// Token positions at which breakpoints can be set.
  ///
  /// Provided only when `includePossibleBreakpoints` in `getSourceReport`
  /// is `true` and the range has been compiled.
  final List<VMScriptToken> possibleBreakpoints;

  /// Token positions in this range which have been executed.
  ///
  /// Provided only when `includeCoverageReport` in `getSourceReport` is `true`
  /// and the range has been compiled.
  ///
  /// Sorted by the position in the source file, starting with the first hit.
  final List<VMScriptToken> hits;

  /// Token positions in this range which have not yet been executed.
  ///
  /// Provided only when `includeCoverageReport` in `getSourceReport` is `true`
  /// and the range has been compiled.
  ///
  /// Sorted by the location in the source file, starting with the first miss.
  final List<VMScriptToken> misses;

  /// Creates a new [VMSourceReportRange].
  ///
  /// [json] corresponds to data returned by the `getSourceReport` RPC.
  ///
  /// [scripts] is used to find the [VMScriptRef] referenced by index in [json].
  factory VMSourceReportRange._fromJson(Map json, List<VMScriptRef> scripts) {
    var script = scripts[json['scriptIndex']];

    var location = newVMSourceLocationFromPosition(
        script, json['startPos'], json['endPos']);

    var compiled = json['compiled'];

    var hits = json['coverage'] == null
        ? null
        : _getTokens(script, json['coverage']['hits']);

    var misses = json['coverage'] == null
        ? null
        : _getTokens(script, json['coverage']['misses']);

    var possibleBreakpoints = json['possibleBreakpoints'] == null
        ? null
        : _getTokens(script, json['possibleBreakpoints']);

    return new VMSourceReportRange._(
        compiled, hits, misses, possibleBreakpoints, location);
  }

  VMSourceReportRange._(this.compiled, this.hits, this.misses,
      this.possibleBreakpoints, this.location);

  /// Returns an unmodifiable [List<VMScriptToken>] corresponding to the
  /// provided token [locations].
  static List<VMScriptToken> _getTokens(
      VMScriptRef script, Iterable<int> locations) {
    return new List<VMScriptToken>.unmodifiable(locations
        .map((position) => newVMScriptTokenFromPosition(script, position)));
  }
}
