// Adapted from https://github.com/dart-lang/sdk/blob/79e6beaf7d2ec8722e47c483e8bc0218134b9cf7/pkg/analyzer/lib/src/ignore_comments/ignore_info.dart
// Copyright 2013, the Dart project authors.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google LLC nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/ast/token.dart' show CommentToken;

/// The name and location of a diagnostic name in an ignore comment.
class DiagnosticName implements IgnoredElement {
  /// The name of the diagnostic being ignored.
  final String name;

  final int offset;

  /// Initialize a newly created diagnostic name to have the given [name] and
  /// [offset].
  DiagnosticName(this.name, this.offset);

  /// Return `true` if this diagnostic name matches the given error code.
  @override
  bool matches(String errorCode) {
    if (name == errorCode.toLowerCase()) {
      return true;
    }
    return false;
    // Deviate from the original implementation: No uniqueName since we only get the string errorCode.
    // var uniqueName = errorCode.uniqueName;
    // var period = uniqueName.indexOf('.');
    // if (period >= 0) {
    //   uniqueName = uniqueName.substring(period + 1);
    // }
    // return name == uniqueName.toLowerCase();
  }
}

class DiagnosticType implements IgnoredElement {
  final String type;

  final int offset;

  final int length;

  DiagnosticType(String type, this.offset, this.length)
      : type = type.toLowerCase();

  @override
  bool matches(String errorCode) =>
      type == errorCode.toLowerCase();
}

abstract class IgnoredElement {
  bool matches(String errorCode);
}

/// Information about analysis `//ignore:` and `//ignore_for_file:` comments
/// within a source file.
class IgnoreInfo {
  /// A regular expression for matching 'ignore' comments.
  ///
  /// Resulting codes may be in a list ('error_code_1,error_code2').
  static final RegExp IGNORE_MATCHER = RegExp(r'//+[ ]*ignore:');

  /// A regular expression for matching 'ignore_for_file' comments.
  ///
  /// Resulting codes may be in a list ('error_code_1,error_code2').
  static final RegExp IGNORE_FOR_FILE_MATCHER =
      RegExp(r'//[ ]*ignore_for_file:');

  /// A table mapping line numbers to the elements (diagnostics and diagnostic
  /// types) that are ignored on that line.
  final Map<int, List<IgnoredElement>> _ignoredOnLine = {};

  /// A list containing all of the elements (diagnostics and diagnostic types)
  /// that are ignored for the whole file.
  final List<IgnoredElement> _ignoredForFile = [];

  /// Initialize a newly created instance of this class to represent the ignore
  /// comments in the given compilation [unit].
  IgnoreInfo.forDart(CompilationUnit unit, String content) {
    for (final comment in unit.ignoreComments) {
      var lexeme = comment.lexeme;
      if (lexeme.contains('ignore:')) {
        var location = unit.lineInfo.getLocation(comment.offset);
        var lineNumber = location.lineNumber;
        var offsetOfLine = unit.lineInfo.getOffsetOfLine(lineNumber - 1);
        var beforeMatch = content.substring(
            offsetOfLine, offsetOfLine + location.columnNumber - 1);
        if (beforeMatch.trim().isEmpty) {
          // The comment is on its own line, so it refers to the next line.
          lineNumber++;
        }
        _ignoredOnLine
            .putIfAbsent(lineNumber, () => [])
            .addAll(comment.ignoredElements);
      } else if (lexeme.contains('ignore_for_file:')) {
        _ignoredForFile.addAll(comment.ignoredElements);
      }
    }
  }

  /// Return `true` if there are any ignore comments in the file.
  bool get hasIgnores =>
      _ignoredOnLine.isNotEmpty || _ignoredForFile.isNotEmpty;

  /// Return a list containing all of the diagnostics that are ignored for the
  /// whole file.
  List<IgnoredElement> get ignoredForFile => _ignoredForFile.toList();

  /// Return a table mapping line numbers to the diagnostics that are ignored on
  /// that line.
  Map<int, List<IgnoredElement>> get ignoredOnLine {
    var ignoredOnLine = <int, List<IgnoredElement>>{};
    for (final entry in _ignoredOnLine.entries) {
      ignoredOnLine[entry.key] = entry.value.toList();
    }
    return ignoredOnLine;
  }

  /// Return `true` if the [errorCode] is ignored at the given [line].
  bool ignoredAt(String errorCode, int line) {
    var ignoredDiagnostics = _ignoredOnLine[line];
    if (ignoredForFile.isEmpty && ignoredDiagnostics == null) {
      return false;
    }
    if (ignoredForFile.any((name) => name.matches(errorCode))) {
      return true;
    }
    if (ignoredDiagnostics == null) {
      return false;
    }
    return ignoredDiagnostics.any((name) => name.matches(errorCode));
  }
}

extension on CompilationUnit {
  /// Return all of the ignore comments in this compilation unit.
  Iterable<CommentToken> get ignoreComments sync* {
    Iterable<CommentToken> processPrecedingComments(Token currentToken) sync* {
      var comment = currentToken.precedingComments;
      while (comment != null) {
        var lexeme = comment.lexeme;
        if (lexeme.startsWith(IgnoreInfo.IGNORE_MATCHER)) {
          yield comment;
        } else if (lexeme.startsWith(IgnoreInfo.IGNORE_FOR_FILE_MATCHER)) {
          yield comment;
        }
        comment = comment.next as CommentToken?;
      }
    }

    var currentToken = beginToken;
    while (currentToken != currentToken.next) {
      yield* processPrecedingComments(currentToken);
      currentToken = currentToken.next!;
    }
    yield* processPrecedingComments(currentToken);
  }
}

extension on CommentToken {
  /// The error codes currently do not contain dollar signs, so we can be a bit
  /// more restrictive in this test.
  static final _errorCodeNameRegExp = RegExp(r'^[a-zA-Z][_a-z0-9A-Z]*$');

  static final _errorTypeRegExp =
      RegExp(r'^type[ ]*=[ ]*lint', caseSensitive: false);

  /// Return the diagnostic names contained in this comment, assuming that it is
  /// a correctly formatted ignore comment.
  Iterable<IgnoredElement> get ignoredElements sync* {
    var offset = lexeme.indexOf(':') + 1;
    var names = lexeme.substring(offset).split(',');
    offset += this.offset;
    for (final name in names) {
      var trimmedName = name.trim();
      if (trimmedName.isNotEmpty) {
        if (trimmedName.contains(_errorCodeNameRegExp)) {
          var innerOffset = name.indexOf(trimmedName);
          yield DiagnosticName(trimmedName.toLowerCase(), offset + innerOffset);
        } else {
          var match = _errorTypeRegExp.matchAsPrefix(trimmedName);
          if (match != null) {
            var innerOffset = name.indexOf(trimmedName);
            yield DiagnosticType('lint', offset + innerOffset, name.length);
          }
        }
      }
      offset += name.length + 1;
    }
  }
}
