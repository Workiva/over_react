// Copyright 2015 Workiva Inc.
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

library transformer_utils.src.text_util;

/// Returns [content] escaped and optionally quoted for use as a string literal
/// in Dart source code.
///
/// If [content] is null, a string version of the the `null` literal will be
/// returned instead.
String stringLiteral(String content,
    {bool quote: true, bool useSingleQuote: true}) {
  // Adapted from dart.convert library's JSON encoder:
  // https://github.com/dart-lang/sdk/blob/1.12.0/sdk/lib/convert/json.dart#L565
  //
  //
  // Copyright 2012, the Dart project authors. All rights reserved.
  // Redistribution and use in source and binary forms, with or without
  // modification, are permitted provided that the following conditions are
  // met:
  //     * Redistributions of source code must retain the above copyright
  //       notice, this list of conditions and the following disclaimer.
  //     * Redistributions in binary form must reproduce the above
  //       copyright notice, this list of conditions and the following
  //       disclaimer in the documentation and/or other materials provided
  //       with the distribution.
  //     * Neither the name of Google Inc. nor the names of its
  //       contributors may be used to endorse or promote products derived
  //       from this software without specific prior written permission.
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

  if (content == null) {
    return 'null';
  }

  const int BACKSPACE = 0x08;
  const int TAB = 0x09;
  const int NEWLINE = 0x0a;
  const int CARRIAGE_RETURN = 0x0d;
  const int FORM_FEED = 0x0c;
  const int DOLLAR_SIGN = 0x24;
  const int SINGLE_QUOTE = 0x27;
  const int DOUBLE_QUOTE = 0x22;
  const int CHAR_0 = 0x30;
  const int BACKSLASH = 0x5c;
  const int CHAR_b = 0x62;
  const int CHAR_f = 0x66;
  const int CHAR_n = 0x6e;
  const int CHAR_r = 0x72;
  const int CHAR_t = 0x74;
  const int CHAR_u = 0x75;

  int quoteChar = useSingleQuote ? SINGLE_QUOTE : DOUBLE_QUOTE;

  var buffer = new StringBuffer();

  void writeStringSlice(String string, int start, int end) {
    buffer.write(string.substring(start, end));
  }

  void writeCharCode(int charCode) {
    buffer.writeCharCode(charCode);
  }

  void writeString(String string) {
    buffer.write(string);
  }

  // ('0' + x) or ('a' + x - 10)
  int hexDigit(int x) => x < 10 ? 48 + x : 87 + x;

  if (quote) {
    writeCharCode(quoteChar);
  }

  int offset = 0;
  final int length = content.length;
  for (int i = 0; i < length; i++) {
    int charCode = content.codeUnitAt(i);
    if (charCode > BACKSLASH) continue;
    if (charCode < 32) {
      if (i > offset) writeStringSlice(content, offset, i);
      offset = i + 1;
      writeCharCode(BACKSLASH);
      switch (charCode) {
        case BACKSPACE:
          writeCharCode(CHAR_b);
          break;
        case TAB:
          writeCharCode(CHAR_t);
          break;
        case NEWLINE:
          writeCharCode(CHAR_n);
          break;
        case FORM_FEED:
          writeCharCode(CHAR_f);
          break;
        case CARRIAGE_RETURN:
          writeCharCode(CHAR_r);
          break;
        default:
          writeCharCode(CHAR_u);
          writeCharCode(CHAR_0);
          writeCharCode(CHAR_0);
          writeCharCode(hexDigit((charCode >> 4) & 0xf));
          writeCharCode(hexDigit(charCode & 0xf));
          break;
      }
    } else if (charCode == quoteChar ||
        charCode == BACKSLASH ||
        charCode == DOLLAR_SIGN) {
      if (i > offset) writeStringSlice(content, offset, i);
      offset = i + 1;
      writeCharCode(BACKSLASH);
      writeCharCode(charCode);
    }
  }

  if (offset == 0) {
    writeString(content);
  } else if (offset < length) {
    writeStringSlice(content, offset, length);
  }

  if (quote) {
    writeCharCode(quoteChar);
  }

  return buffer.toString();
}
