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
