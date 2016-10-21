// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:source_span/source_span.dart';

import 'breakpoint.dart';
import 'class.dart';
import 'library.dart';
import 'object.dart';
import 'scope.dart';
import 'source_location.dart';
import 'source_report.dart';

VMScriptRef newVMScriptRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Script" || json["type"] == "Script");
  return new VMScriptRef._(scope, json);
}

VMScriptToken newVMScriptToken(String isolateId, String scriptId,
        int position) {
  if (position == null) return null;
  return new VMScriptToken._(isolateId, scriptId, position);
}

VMScriptToken newVMScriptTokenFromPosition(VMScriptRef script, int position) {
  if (position == null) return null;
  return new VMScriptToken._(script._scope.isolateId, script._id, position);
}

/// A reference to a script in the Dart VM.
///
/// A script contains information about the actual text of a library. Usually
/// there's only one script per library, but the `part` directive can produce
/// libraries made up of multiple scripts.
class VMScriptRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for script library, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// script objects that refer to the same script.
  final bool _fixedId;

  /// The URI from which this script was loaded.
  final Uri uri;

  VMScriptRef._(this._scope, Map json)
      : _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        uri = Uri.parse(json["uri"]);

  Future<VMScript> load() async =>
      new VMScript._(_scope, await _scope.loadObject(_id));

  /// Adds a breakpoint at [line] (and optionally [column]) in this script.
  ///
  /// Both [line] and [column] are 1-based.
  Future<VMBreakpoint> addBreakpoint(int line, {int column}) async {
    var params = {"scriptId": _id, "line": line};
    if (column != null) params["column"] = column;

    try {
      var response = await _scope.sendRequest("addBreakpoint", params);
      return newVMBreakpoint(_scope, response);
    } on rpc.RpcException catch (error) {
      // Error 102 indicates that the breakpoint couldn't be created.
      if (error.code == 102) return null;
      rethrow;
    }
  }

  /// Generates a set of reports tied to this script.
  ///
  /// If [includeCoverageReport] is `true`, the report includes code coverage
  /// information via [VMSourceReportRange.hits] and
  /// [VMSourceReportRange.misses] in [VMSourceReport.ranges]. Otherwise,
  /// these properties are `null`.
  ///
  /// If [includePossibleBreakpoints] is `true`, the report includes a list of
  /// token positions which correspond to possible breakpoints via
  /// [VMSourceReportRange.possibleBreakpoints] in [VMSourceReport.ranges].
  /// Otherwise, [VMSourceReportRange.possibleBreakpoints] is `null`.
  ///
  /// If [forceCompile] is `true`, all functions in the range of the report
  /// will be compiled. If `false`, functions that are never used may not appear
  /// in [VMSourceReportRange.misses].
  /// Forcing compilation can cause a compilation error, which could terminate
  /// the running Dart program.
  ///
  /// [location] can be provided to restrict analysis to a subrange of the
  /// script. An [ArgumentError] is thrown if `location.end` is `null`.
  Future<VMSourceReport> getSourceReport(
      {bool includeCoverageReport: true,
      bool includePossibleBreakpoints: true,
      bool forceCompile: false,
      VMSourceLocation location}) async {
    var reports = <String>[];
    if (includeCoverageReport) reports.add('Coverage');
    if (includePossibleBreakpoints) reports.add('PossibleBreakpoints');

    var params = <String, dynamic>{'scriptId': _id, 'reports': reports};
    if (forceCompile) params['forceCompile'] = true;
    if (location != null) {
      if (location.end == null) {
        throw new ArgumentError.value(
            location, 'location', 'location.end cannot be null.');
      }
      params['tokenPos'] = location.token._position;
      params['endTokenPos'] = location.end._position;
    }

    var json = await _scope.sendRequest('getSourceReport', params);
    return newSourceReport(_scope, json);
  }

  bool operator ==(other) => other is VMScriptRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => uri.toString();
}

/// A script in the Dart VM.
class VMScript extends VMScriptRef implements VMObject {
  final VMClassRef klass;

  final int size;

  /// The library that owns this script.
  final VMLibraryRef library;

  /// The source code for this script.
  ///
  /// For certain built-in libraries, this may be reconstructed without source
  /// comments.
  final String source;

  /// A table encoding a mapping from token position to line and column.
  ///
  /// Each subarray consists of an int designating the line, followed by any
  /// number of position-column pairs that represent the positions of tokens
  /// known to the VM.
  ///
  /// Because this encodes all the known token positions, it's more efficient to
  /// access than the representation used by a [SourceFile] as long as you're
  /// looking up a known token boundary.
  final List<List<int>> _tokenPositions;

  /// A source file that provides access to location and span information about
  /// this script.
  ///
  /// This is generally less efficient than calling [sourceSpan] and
  /// [sourceLocation] directly, and should only be used when you don't
  /// [VMSourceLocation] or [VMScriptToken] objects.
  ///
  /// Note that [SourceFile] uses 0-based lines and columns, whereas the rest of
  /// this package uses 1-based lines and columns.
  SourceFile get sourceFile {
    if (_sourceFile == null) _sourceFile = new SourceFile(source, url: uri);
    return _sourceFile;
  }
  SourceFile _sourceFile;

  VMScript._(Scope scope, Map json)
      : klass = newVMClassRef(scope, json["class"]),
        size = json["size"],
        library = newVMLibraryRef(scope, json["library"]),
        source = json["source"],
        _tokenPositions = json["tokenPosTable"],
        super._(scope, json);

  /// Returns a [FileSpan] representing the source covered by [location].
  ///
  /// If [location] doesn't have a [VMSourceLocation.end] token, this will be a
  /// point span. Note that [FileSpan] uses 0-based lines and columns, whereas
  /// the rest of this package uses 1-based lines and columns.
  ///
  /// Throws an [ArgumentError] if [location] isn't for this script.
  FileSpan sourceSpan(VMSourceLocation location) {
    if (location.script._scope.isolateId != _scope.isolateId ||
        (_fixedId && location.script._id != _id)) {
      throw new ArgumentError("SourceLocation isn't for this script.");
    }

    var end = location.end ?? location.token;
    return new _ScriptSpan(this, location.token._position, end._position);
  }

  /// Returns a [FileLocation] representing the location indicated by [token].
  ///
  /// Note that [FileLocation] uses 0-based lines and columns, whereas the rest
  /// of this package uses 1-based lines and columns.
  ///
  /// Throws an [ArgumentError] if [token] isn't for this script.
  FileLocation sourceLocation(VMScriptToken token) {
    if (token._isolateId != _scope.isolateId ||
        (_fixedId && token._scriptId != _id)) {
      throw new ArgumentError("Token isn't for this script.");
    }

    return new _ScriptLocation(this, token._position);
  }

  /// Binary searches [_tokenPositions] for the line and column information for
  /// the token at [position].
  ///
  /// This returns a `line, column` pair if the token is found, and throws a
  /// [StateError] otherwise.
  List<int> _lineAndColumn(int position) {
    var min = 0;
    var max = _tokenPositions.length;
    while (min < max) {
      var mid = min + ((max - min) >> 1);

      var row = _tokenPositions[mid];

      if (row[1] > position) {
        max = mid;
      } else {
        for (var i = 1; i < row.length; i += 2) {
          if (row[i] == position) return [row.first, row[i + 1]];
        }

        min = mid + 1;
      }
    }

    // We only call this for positions that come from the VM, so we shouldn't
    // ever actually reach this point.
    throw new StateError("Couldn't find line and column for token $position in "
        "$uri.");
  }
}

/// The location of a token in a Dart script.
///
/// A token can be passed to [VMScript.sourceLocation] to get the line and
/// column information for the token.
class VMScriptToken {
  /// The ID of this token's script's isolate.
  final String _isolateId;

  /// The ID of this token's script.
  final String _scriptId;

  /// This is deprecated.
  ///
  /// Use `VMScript.sourceLocation().offset` instead.
  @Deprecated("Will be removed in 0.3.0.")
  int get offset => _position;
  final int _position;

  VMScriptToken._(this._isolateId, this._scriptId, this._position);

  String toString() => _position.toString();
}

/// An implementation of [FileLocation] based on a known token position.
class _ScriptLocation extends SourceLocationMixin implements FileLocation {
  /// The script that produced this location.
  final VMScript _script;

  /// The position of the token used to generate this location.
  ///
  /// This is opaque, but it can be used to look up the line and column
  /// information.
  final int _position;

  int get offset {
    // TODO(nweiz): Make this more efficient when sdk#26390 is fixed.
    _offset ??= _script.sourceFile.getOffset(line, column);
    return _offset;
  }
  int _offset;

  SourceFile get file => _script.sourceFile;

  Uri get sourceUrl => _script.uri;

  int get line {
    _ensureLineAndColumn();
    return _line;
  }
  int _line;

  int get column {
    _ensureLineAndColumn();
    return _column;
  }
  int _column;

  _ScriptLocation(this._script, this._position);

  /// Ensures that [_line] and [_column] are set based on [_script]'s
  /// information.
  void _ensureLineAndColumn() {
    if (_line != null) return null;
    var result = _script._lineAndColumn(_position);

    // SourceLocation lines and columns are zero-based, the VM service's are
    // 1-based.
    _line = result.first - 1;
    _column = result.last - 1;
  }

  int compareTo(SourceLocation other) =>
      other is _ScriptLocation && other.sourceUrl == sourceUrl
          ? _position - other._position
          : super.compareTo(other);

  bool operator ==(SourceLocation other) => other is _ScriptLocation
      ? _position == other._position && sourceUrl == other.sourceUrl
      : super == other;

  FileSpan pointSpan() =>
      new _ScriptSpan(_script, _position, _position, this, this);
}

/// An implementation of [FileSpan] based on known token positions.
class _ScriptSpan extends SourceSpanMixin implements FileSpan {
  /// The script that produced this location.
  final VMScript _script;

  SourceFile get file => _script.sourceFile;

  /// The position of the start token.
  final int _startPosition;

  /// The position of the end token.
  final int _endPosition;

  Uri get sourceUrl => _script.uri;

  int get length {
    // Prefer checking just the lines and columns, since they're more efficient
    // to access.
    if (start.line == end.line) return end.column - start.column;
    return end.offset - start.offset;
  }

  FileLocation get start {
    _start ??= new _ScriptLocation(_script, _startPosition);
    return _start;
  }
  FileLocation _start;

  FileLocation get end {
    _end ??= new _ScriptLocation(_script, _endPosition);
    return _end;
  }
  FileLocation _end;

  String get text => _script.source.substring(start.offset, end.offset);

  String get context => file.getText(file.getOffset(start.line),
      end.line == file.lines - 1 ? null : file.getOffset(end.line + 1));  

  _ScriptSpan(this._script, this._startPosition, this._endPosition,
      [this._start, this._end]);

  int compareTo(SourceSpan other) {
    if (other is! _ScriptSpan || other.sourceUrl != sourceUrl) {
      return super.compareTo(other);
    }

    _ScriptSpan otherFile = other;
    var result = _startPosition.compareTo(otherFile._startPosition);
    return result == 0 ?
        _endPosition.compareTo(otherFile._endPosition)
        : result;
  }

  SourceSpan union(SourceSpan other) {
    if (other is! _ScriptSpan) return super.union(other);

    var span = expand(other);
    var beginSpan = span._startPosition == _startPosition ? this : other;
    var endSpan = span._endPosition == _endPosition ? this : other;

    if (beginSpan._endPosition < endSpan._startPosition) {
      throw new ArgumentError("Spans $this and $other are disjoint.");
    }

    return span;
  }

  bool operator ==(other) => other is _ScriptSpan
      ? _startPosition == other._startPosition &&
            _endPosition == other._endPosition &&
            sourceUrl == other.sourceUrl
      : super == other;

  FileSpan expand(FileSpan other) {
    if (sourceUrl != other.sourceUrl) {
      throw new ArgumentError("Source URLs \"${sourceUrl}\" and "
          " \"${other.sourceUrl}\" don't match.");
    }

    if (other is _ScriptSpan) {
      var startPosition = math.min(this._startPosition, other._startPosition);
      var endPosition = math.max(this._endPosition, other._endPosition);
      return new _ScriptSpan(_script, startPosition, endPosition,
          startPosition == this._startPosition ? this._start : other._start,
          endPosition == this._endPosition ? this._end : other._end);
    } else {
      var start = math.min(this.start.offset, other.start.offset);
      var end = math.max(this.end.offset, other.end.offset);
      return file.span(start, end);
    }
  }
}
