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

library dart_dev.src.tasks.copy_license.api;

import 'dart:async';
import 'dart:io';

import 'package:dart_dev/src/tasks/copy_license/config.dart';
import 'package:dart_dev/src/tasks/task.dart';

CopyLicenseTask copyLicense(
    {List<String> directories: defaultDirectories,
    String licensePath: defaultLicensePath}) {
  CopyLicenseTask task = new CopyLicenseTask();

  File license = new File(licensePath);
  if (!license.existsSync())
    throw new Exception('License file "$licensePath" does not exist.');

  String licenseContents = license.readAsStringSync();
  licenseContents = trimLeadingAndTrailingEmptyLines(licenseContents);

  directories.forEach((path) {
    Directory dir = new Directory(path);
    if (!dir.existsSync()) return;
    Iterable<File> files =
        dir.listSync(recursive: true).where((e) => e is File);
    files.forEach((file) {
      // Skip files in packages/ directory
      if (file.path.contains('/packages/')) return;

      try {
        if (applyLicense(file, licenseContents)) {
          task.affectedFiles.add(file.path);
        }
      } on NonUtf8EncodedFileException {
        // Ignore files that could not be read.
      }
    });
  });

  task.successful = true;
  return task;
}

bool applyLicense(File file, String license) {
  if (hasLicense(file, license)) return false;

  String fileLicense;
  try {
    fileLicense = licenseForFileType(file, license);
  } catch (e) {
    return false;
  }

  String fileContents = file.readAsStringSync();
  file.writeAsStringSync('$fileLicense\n$fileContents');
  return true;
}

bool hasLicense(File file, String license) {
  String fileContents;
  try {
    fileContents = file.readAsStringSync();
  } catch (e) {
    // File could not be read (probably not UTF8-encoded). Ignore this file.
    throw new NonUtf8EncodedFileException(file.path);
  }

  String licenseHeader = license.split('\n').first;
  Iterable<String> lines = fileContents.split('\n');
  if (lines.isEmpty) return false;
  if (lines.first.contains(licenseHeader)) return true;
  if (lines.length <= 1) return false;
  if (lines.elementAt(1).contains(licenseHeader)) return true;
  return false;
}

String licenseForFileType(File file, String license) {
  String opening = '';
  String closing = '';
  String linePrefix = '';

  if (file.path.endsWith('.css')) {
    opening = '/**\n';
    linePrefix = ' * ';
    closing = '\n */';
  } else if (file.path.endsWith('.dart')) {
    linePrefix = '// ';
  } else if (file.path.endsWith('.html')) {
    opening = '<!--\n';
    closing = '\n-->';
  } else if (file.path.endsWith('.js')) {
    linePrefix = '// ';
  } else {
    throw new ArgumentError('Unsupported file type: ${file.path}');
  }

  String l =
      license.split('\n').map((l) => '$linePrefix$l'.trimRight()).join('\n');
  return '$opening$l$closing\n';
}

String trimLeadingAndTrailingEmptyLines(String input) {
  var lines = input.split('\n');
  while (lines.first.trim().isEmpty) {
    lines.removeAt(0);
  }
  while (lines.last.trim().isEmpty) {
    lines.removeLast();
  }
  return lines.join('\n');
}

class CopyLicenseTask extends Task {
  List<String> affectedFiles = [];
  final Future done = new Future.value();
  CopyLicenseTask();
}

class NonUtf8EncodedFileException implements Exception {
  final String filename;
  NonUtf8EncodedFileException(this.filename);
  @override
  String toString() => 'File is not UTF8-encoded: $filename';
}
