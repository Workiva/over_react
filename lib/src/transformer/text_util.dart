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

library over_react.transformer.text_util;

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
