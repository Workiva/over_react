part of sass.transformer;

class InlinedSassFile extends SassFile {
  String _contents;
  String get contents {
    if (_contents == null) {
      _contents = _inline(_originalContent, _importedFiles);
    }
    return _contents;
  }

  String get _originalContent => super.contents;

  Map<_SassImport, InlinedSassFile> _importedFiles;

  InlinedSassFile(String contents, Map<_SassImport, InlinedSassFile> importedFiles) :
    _importedFiles = importedFiles,
    super(contents);

  String _inline(String contents, Map<_SassImport, InlinedSassFile> imports) {
    var sortedImports = imports.keys.toList()..sort(_byStartPosition);
    for (var import in sortedImports.reversed) {
      contents = _replaceImport(contents, import, imports[import]);
    }
    return contents;
  }

  String _replaceImport(String contents, _SassImport import, InlinedSassFile importedFile) {
    var before = contents.substring(0, import.start);
    var after = contents.substring(import.end);
    return before + importedFile.contents + after;
  }
}

final Comparator _byStartPosition = (_SassImport a, _SassImport b) => Comparable.compare(a.start, b.start);
