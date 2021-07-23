// Copyright 2016 Workiva Inc.
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

library over_react.string_util;

/// Allows the use of `'''` string blocks, without having to unindent them when used within
/// something like markdown's
/// [markdownToHtml](https://www.dartdocs.org/documentation/markdown/latest/markdown/markdownToHtml.html) function.
///
/// __Replace this:__
///
///     (Component()
///       ..description = markdownToHtml(
///     '''
///     Yuck... I'm indented all funky.
///     '''
///       )
///     )()
///
/// __With this:__
///
///     (Component()
///       ..description = markdownToHtml(unindent(
///           '''
///           Proper indentation is yummy...
///           '''
///       ))
///     )()
String unindent(String multilineString) {
  var indent = RegExp(r'^( *)').firstMatch(multilineString)![1];
  assert(indent != null && indent.isNotEmpty);
  return multilineString.trim().replaceAll('\n$indent', '\n');
}
