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

library over_react.transformer.util;

import 'package:analyzer/analyzer.dart';

String commentBanner(String bannerText, {
    int bannerWidth: 80, int textIndent: 2, bool topBorder: true, bool bottomBorder: true
}) {
  const String bannerLead = '// ';

  String bannerBorder = ('$bannerLead${'-' * (bannerWidth - bannerLead.length)}\n') * 2;

  return
      '\n' +
      (topBorder ? bannerBorder : '') +
      '${bannerLead.trimRight()}\n' +
      bannerText.split('\n').map((line) => bannerLead + (' ' * textIndent) + line).join('\n') + '\n' +
      '${bannerLead.trimRight()}\n' +
      (bottomBorder ? bannerBorder : '') +
      '\n';
}

/// Returns a [FieldDeclaration] for the meta field on a [ClassDeclaration] if
/// it exists, otherwise returns null.
FieldDeclaration getMetaField(ClassDeclaration cd) {
  bool isPropsOrStateMeta(ClassMember member) {
    if (member is! FieldDeclaration) return false;
    final FieldDeclaration fd = member;
    if (!fd.isStatic) return false;
    if (fd.fields.variables.length > 1) return false;
    if (fd.fields.variables.single.name.name != 'meta') return false;
    return true;
  }
  return cd.members.firstWhere(isPropsOrStateMeta, orElse: () => null);
}
