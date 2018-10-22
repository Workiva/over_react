import 'dart:mirrors';

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

String getName(Type type) {
  return MirrorSystem.getName(reflectType(type).simpleName);
}

const outputExtension = '.overReactBuilder.g.dart';
//const targetLibAlias = 'target_lib';


/// Returns the uri path for [unit].
///
/// If [isGeneratedLib] is set to `true`, the returned library uri path will
/// have '.dart' replaced with [outputExtension]
String getLibraryUriPathFromCompilationUnit(CompilationUnitMember unit, {bool isGeneratedLib: false}) {
  var libPath = unit?.declaredElement?.library?.source?.uri?.path;
  return isGeneratedLib ? libPath.replaceAll('.dart', outputExtension) : libPath;
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

T getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
  return member.metadata.any((annotation) => annotation.name?.name == name)
      ? value
      : null;
}
//
//void addImportAliasToMap(Element element, Map<String, String> libUriPathToImportAlias, ImportCounter importCounter) {
//  var libUriPath = element.library.source.uri.path;
//  if (!libUriPathToImportAlias.containsKey(libUriPath)) {
//    var importAlias = getLibAlias(importCounter.count++);
//    libUriPathToImportAlias[libUriPath] = importAlias;
//  }
//}
