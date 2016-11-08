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

library dart_dev.src.util;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dart_dev/util.dart' show TaskProcess;

void copyDirectory(Directory source, Directory dest) {
  if (!dest.existsSync()) {
    dest.createSync(recursive: true);
  }

  source.listSync(recursive: true).forEach((entity) {
    if (FileSystemEntity.isDirectorySync(entity.path)) {
      Directory orig = entity;
      String p = path.relative(orig.path, from: source.path);
      p = path.join(dest.path, p);
      Directory copy = new Directory(p);
      if (!copy.existsSync()) {
        copy.createSync(recursive: true);
      }
    } else if (FileSystemEntity.isFileSync(entity.path)) {
      File orig = entity;
      String p = path.relative(orig.path, from: source.path);
      p = path.join(dest.path, p);
      File copy = new File(p);
      copy.createSync(recursive: true);
      copy.writeAsBytesSync(orig.readAsBytesSync());
    }
  });
}

/// Checks if an [executable] exists and is in the current path via `which`.
Future<bool> executableExists(String executable) async {
  var check = new TaskProcess('which', [executable]);
  return (await check.exitCode) == 0;
}

/// Returns an open port by creating a temporary Socket.
/// Borrowed from coverage package https://github.com/dart-lang/coverage/blob/master/lib/src/util.dart#L49-L66
Future<int> getOpenPort() async {
  ServerSocket socket;

  try {
    socket = await ServerSocket.bind(InternetAddress.LOOPBACK_IP_V4, 0);
  } catch (_) {
    // try again v/ V6 only. Slight possibility that V4 is disabled
    socket = await ServerSocket.bind(InternetAddress.LOOPBACK_IP_V6, 0,
        v6Only: true);
  }

  try {
    return socket.port;
  } finally {
    await socket.close();
  }
}

Future<bool> isPortBound(int port) async {
  if (port == 0) {
    return false;
  }

  ServerSocket socket;
  try {
    socket = await ServerSocket.bind('localhost', port);
    return false;
  } on SocketException {
    return true;
  } finally {
    await socket?.close();
  }
}

String parseExecutableFromCommand(String command) {
  return command.split(' ').first;
}

List<String> parseArgsFromCommand(String command) {
  var parts = command.split(' ');
  if (parts.length <= 1) return [];
  return parts.getRange(1, parts.length).toList();
}
