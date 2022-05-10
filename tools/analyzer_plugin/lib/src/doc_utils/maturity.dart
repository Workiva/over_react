// Taken from https://github.com/dart-lang/sdk/blob/2fe40ad6ed523d4c9bc6ccdc11c1818168c5dd37/pkg/analyzer/lib/src/lint/linter.dart
//
// Copyright 2013, the Dart project authors. All rights reserved.
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
//     * Neither the name of Google Inc. nor the names of its
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

import 'package:meta/meta.dart';

class Maturity implements Comparable<Maturity> {
  static const Maturity stable = Maturity._('stable', ordinal: 0);
  static const Maturity experimental = Maturity._('experimental', ordinal: 1);
  static const Maturity deprecated = Maturity._('deprecated', ordinal: 2);

  final String name;
  final int ordinal;

  factory Maturity(String name, {required int ordinal}) {
    switch (name.toLowerCase()) {
      case 'stable':
        return stable;
      case 'experimental':
        return experimental;
      case 'deprecated':
        return deprecated;
      default:
        return Maturity._(name, ordinal: ordinal);
    }
  }

  const Maturity._(this.name, {required this.ordinal});

  @override
  int compareTo(Maturity other) => ordinal - other.ordinal;

  @override
  String toString() => name;

  /// A list containing all of the enum values that are defined.
  static const List<Maturity> VALUES = <Maturity>[
    stable,
    experimental,
    deprecated,
  ];
}
