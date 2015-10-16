library web_skin_dart.transformer.generation_util;

String commentBanner(String bannerText, {
    int bannerWidth: 80, int textIndent: 2, bool topBorder: true, bool bottomBorder: true
}) {
  const String bannerLead = '// ';

  String bannerBorder = ('$bannerLead${'-' * (bannerWidth - bannerLead.length)}\n') * 2;

  return
      '\n' +
      (topBorder ? bannerBorder : '') +
      '$bannerLead\n' +
      bannerText.split('\n').map((line) => bannerLead + (' ' * textIndent) + line).join('\n') + '\n' +
      '$bannerLead\n' +
      (bottomBorder ? bannerBorder : '') +
      '\n';
}
