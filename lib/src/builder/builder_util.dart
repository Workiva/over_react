import 'dart:mirrors';

import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';

String getName(Type type) {
  return MirrorSystem.getName(reflectType(type).simpleName);
}

const outputExtension = '.overReactBuilder.g.dart';

String getLibraryUriPathFromCompilationUnit(CompilationUnitMember unit) {
  return unit?.declaredElement?.library?.source?.uri?.path;
}

class ImportCounter {
  int count;
  ImportCounter(this.count);
}

class LibraryDatum {
  String libUriPath;
  String importDirective;
  CompilationUnitMember compUnit;

  LibraryDatum(this.libUriPath, this.compUnit, this.importDirective);
}

String getLibAlias(int count) {
  return 'lib_$count';
}


String getImportDirective(String libUriPath, importAlias) {
  return 'import \'package:${libUriPath.replaceFirst(
      '/lib/', '/')}\' as $importAlias;';
}

