// Copyright 2019 Workiva Inc.
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

import 'package:quiver/core.dart';

/// A representation of a change to a source file.
///
/// The change targets a specific span within the file and specifies the text
/// that would be inserted at that span if applied.
///
/// A patch can represent an insertion, a deletion, or a replacement:
///
/// - An insertion has a non-empty [updatedText] value at a "point span",
///   meaning [startOffset] and [endOffset] are the same.
/// - A deletion will have an empty [updatedText] value with an [endOffset] that
///   is greater than [startOffset]. The text across this span will be deleted.
/// - A replacement will have a non-empty [updatedText] value with an
///   [endOffset] that is greater than [startOffset]. The text across this span
///   will be replaced by [updatedText].
class Patch implements Comparable<Patch> {
  final int startOffset;

  final int endOffset;

  /// The value that would be written in place of the existing text.
  ///
  /// An empty value here represents a deletion, whereas a non-empty value may
  /// represent either an insertion or a replacement.
  final String updatedText;

  Patch(this.updatedText, this.startOffset, this.endOffset);

  @override
  int compareTo(Patch other) {
    final result = startOffset.compareTo(other.startOffset);
    return result == 0 ? endOffset.compareTo(other.endOffset) : result;
  }

  @override
  bool operator ==(other) =>
      other is Patch &&
      startOffset == other.startOffset &&
      endOffset == other.endOffset &&
      updatedText == other.updatedText;

  @override
  int get hashCode => hash3(updatedText, startOffset, endOffset);

  @override
  String toString() => '<Patch: from $startOffset to $endOffset>';
}

/// Returns the result of applying all of the [patches]
/// (insertions/deletions/replacements) to the contents of [string].
///
/// Throws an [Exception] if any two of the given [patches] overlap.
String applyPatches(String string, Iterable<Patch> patches) {
  final buffer = StringBuffer();
  final sortedPatches = patches.toList()..sort();

  var lastEdgeOffset = 0;
  late Patch prev;
  for (final patch in sortedPatches) {
    if (patch.startOffset < lastEdgeOffset) {
      throw Exception('Codemod terminated due to overlapping patch.\n'
          'Previous patch:\n'
          '  $prev\n'
          '  Updated text: ${prev.updatedText}\n'
          'Overlapping patch:\n'
          '  $patch\n'
          '  Updated text: ${patch.updatedText}\n');
    }

    // Write unmodified text from end of last patch to beginning of this patch
    buffer.write(string.substring(lastEdgeOffset, patch.startOffset));
    // Write the patched text (and do nothing with the original text, which is
    // effectively the same as replacing it)
    buffer.write(patch.updatedText);

    lastEdgeOffset = patch.endOffset;
    prev = patch;
  }

  buffer.write(string.substring(lastEdgeOffset));
  return buffer.toString();
}
