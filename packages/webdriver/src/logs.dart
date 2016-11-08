// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of webdriver.core;

class Logs extends _WebDriverBase {
  Logs._(driver) : super(driver, 'log');

  Stream<LogEntry> get(String logType) async* {
    var entries = await _post('', {'type': logType});
    for (var entry in entries) {
      yield new LogEntry.fromMap(entry);
    }
  }

  @override
  String toString() => '$driver.logs';

  @override
  int get hashCode => driver.hashCode;

  @override
  bool operator ==(other) => other is Logs && other.driver == driver;
}

class LogEntry {
  final String message;
  final DateTime timestamp;
  final String level;

  const LogEntry(this.message, this.timestamp, this.level);

  LogEntry.fromMap(Map map)
      : this(
            map['message'],
            new DateTime.fromMillisecondsSinceEpoch(map['timestamp'].toInt(),
                isUtc: true),
            map['level']);

  @override
  String toString() => '$level[$timestamp]: $message';
}

class LogType {
  static const String browser = 'browser';
  static const String client = 'client';
  static const String driver = 'driver';
  static const String performance = 'performance';
  static const String profiler = 'profiler';
  static const String server = 'server';
}

class LogLevel {
  static const String off = 'OFF';
  static const String severe = 'SEVERE';
  static const String warning = 'WARNING';
  static const String info = 'INFO';
  static const String debug = 'DEBUG';
  static const String all = 'ALL';
}
