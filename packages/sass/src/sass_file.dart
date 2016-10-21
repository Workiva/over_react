part of sass.transformer;

final RegExp _importRegex = new RegExp(r"""@import\s+('(.+?)'|"(.+?)")\s*;""");

class SassFile {
  final String contents;

  Iterable<_SassImport> get imports => _importRegex
      .allMatches(contents)
      .map((match) => new _SassImport(match.start, match.end, match[1].substring(1, match[1].length - 1)));

  SassFile(this.contents);
}

class _SassImport {
  final int start;
  final int end;
  final String path;

  _SassImport(this.start, this.end, this.path);
}
