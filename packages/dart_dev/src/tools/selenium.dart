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

library dart_dev.src.tools.selenium;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

import 'package:dart_dev/src/task_process.dart';
import 'package:dart_dev/src/util.dart';

/// Initiates a standalone Selenium server.
///
/// Once constructed, the [start] and [stop] methods can be used as
/// before and after hooks for dart_dev tasks, respectively.
///
///     import 'package:dart_dev/dart_dev.dart';
///
///     main() async {
///       var seleniumHelper = new SeleniumHelper();
///       config.test
///         ..before = [seleniumHelper.start]
///         ..after = [seleniumHelper.stop];
///     }
class SeleniumHelper {
  /// The Selenium server executable name.
  static const String seleniumServerExecutable = 'selenium-server';

  /// Pattern that matches the logging from a chromium instance when outputting
  /// the port on which the observatory instance is listening.
  static final RegExp _observatoryPortPattern =
      new RegExp(r'Observatory listening (at|on) http:\/\/127\.0\.0\.1:(\d+)');

  /// List of ports where an observatory instance was (at one point) running.
  /// Using the webdriver to load pages in functional tests results in multiple
  /// observatory instances being spawned. The ports at which these instances
  /// are located will eventually be needed for coverage collection.
  static List<int> _observatoryPorts = [];

  /// Pattern that matches the error output from selenium when the required port
  /// is already bound.
  static final RegExp _seleniumPortBoundPattern =
      new RegExp(r'Failed to start.*\:([\d]{1,})');

  /// The selenium server process.
  static TaskProcess _seleniumProcess;

  /// Message logged when selenium server successfully starts.
  static final String _seleniumStartedPattern =
      'Selenium Server is up and running';

  /// UUID generator for sending RPCs to the observatory protocol.
  static final Uuid _uuidGenerator = new Uuid();

  /// Clears all previously detected ports on which an observatory instance was
  /// running.
  static void clearObservatoryPorts() {
    _observatoryPorts.clear();
  }

  /// Returns a `Future` that resolves with all of the ports on which active
  /// observatory instances are running.
  static Future<List<int>> getActiveObservatoryPorts() async {
    List<int> activePorts = [];
    List<int> inactivePorts = [];
    for (int port in _observatoryPorts) {
      if (await _isObservatoryPortActive(port)) {
        activePorts.add(port);
      } else {
        inactivePorts.add(port);
      }
    }
    for (int port in inactivePorts) {
      _observatoryPorts.remove(port);
    }
    return activePorts;
  }

  static Future<bool> killChildrenProcesses() async {
    if (_seleniumProcess == null) return true;
    return _seleniumProcess.killAllChildren();
  }

  /// Sends a `getVM` RPC to the observatory instance located at the given
  /// [port] in order to see if there are any isolates left.
  ///
  /// See https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md#getvm
  static Future<bool> _isObservatoryPortActive(int port) async {
    try {
      Completer<bool> c = new Completer();
      WebSocket ws = await WebSocket.connect('ws://127.0.0.1:$port/ws');
      var uuid = _uuidGenerator.v1();
      ws.listen((message) {
        var response = JSON.decode(message);
        c.complete(response['result'] != null &&
            response['result']['isolates'] is List &&
            response['result']['isolates'].isNotEmpty);
      });
      ws.add(JSON.encode({
        'jsonrpc': '2.0',
        'method': 'getVM',
        'params': {},
        'id': uuid,
      }));
      return c.future;
    } catch (e) {
      return false;
    }
  }

  /// The path to the Selenium server executable.
  final String _executablePath;

  /// Constructs a Selenium helper instance that will install and run a
  /// standalone Selenium server. This tool works as follows:
  ///
  /// If an [executablePath] is given, run it. Otherwise, assume the Selenium
  /// server executable is in the path and run `selenium-server`.
  SeleniumHelper({String executablePath})
      : _executablePath = executablePath ?? seleniumServerExecutable;

  Future<Null> start() async {
    if (!(await executableExists(_executablePath)))
      throw new Exception('Executable not found: $_executablePath');

    var isStarted = new Completer();
    _seleniumProcess = new TaskProcess(_executablePath, []);
    _seleniumProcess.stderr.listen((line) async {
      if (line.contains(_observatoryPortPattern)) {
        Match m = _observatoryPortPattern.firstMatch(line);
        _observatoryPorts.add(int.parse(m.group(2)));
      } else if (line.contains(_seleniumPortBoundPattern)) {
        var port = _seleniumPortBoundPattern.firstMatch(line).group(1);
        await _seleniumProcess.kill();
        throw new StateError(
            '$seleniumServerExecutable failed to start: port $port is already taken.');
      } else if (line.contains(_seleniumStartedPattern)) {
        isStarted.complete();
      }
    });
    return isStarted.future;
  }

  Future<Null> stop() async {
    _seleniumProcess?.kill();
  }
}
