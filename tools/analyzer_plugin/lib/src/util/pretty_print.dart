// Copyright 2022 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Adapted from over_react's prettyPrintMap: https://github.com/Workiva/over_react/blob/aec3dbc2faefd338d45a5ae810305f255095e59b/lib/src/util/pretty_print.dart

const String nonBreakingSpace = '\u00a0';
// Use non-breaking spaces so leading spaces show up in IDE tooltips.
const String _indent = '$nonBreakingSpace$nonBreakingSpace';
const int _maxKeyValuePairsPerLine = 2;
const int _maxListItemsPerLine = 4;
const int _maxSingleLineListOrMapLength = 50;

/// Indents [str] by [_indent], trimming any trailing whitespace.
String _indentString(String str) {
  return str.split('\n').map((line) => (_indent + line).trimRight()).join('\n');
}

/// Returns a pretty-printed version of [obj]. Output is similar to that of `toString` for [List]/[Map],
/// but splits longer collections onto multiple lines and indents nested items.
String prettyPrint(Object? obj) {
  String prettyPrintCollectionEntries(List<String> entries, int maxEntriesPerLine) {
    final singleLineInner = entries.join(', ');
    if (entries.length > maxEntriesPerLine ||
        singleLineInner.contains('\n') ||
        singleLineInner.length > _maxSingleLineListOrMapLength) {
      var inner = _indentString(entries.join(',\n'));
      return '\n$inner\n';
    } else {
      return '$singleLineInner';
    }
  }

  if (obj is List) {
    final items = obj.map(prettyPrint).toList();
    return '[${prettyPrintCollectionEntries(items, _maxListItemsPerLine)}]';
  } else if (obj is Map) {
    final pairs = obj.keys.map((dynamic key) => '$key: ${prettyPrint(obj[key])}').toList();
    return '{${prettyPrintCollectionEntries(pairs, _maxKeyValuePairsPerLine)}}';
  } else {
    return obj.toString();
  }
}
