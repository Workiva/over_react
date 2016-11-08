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

library dart_dev.src.tasks.test.cli;

import 'dart:async';

import 'package:args/args.dart';

import 'package:dart_dev/util.dart' show reporter, isPortBound;

import 'package:dart_dev/src/platform_util/api.dart' as platform_util;
import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';
import 'package:dart_dev/src/tasks/serve/api.dart';
import 'package:dart_dev/src/tasks/test/api.dart';
import 'package:dart_dev/src/tasks/test/config.dart';

class TestCli extends TaskCli {
  final ArgParser argParser = new ArgParser()
    ..addFlag('unit', defaultsTo: null, help: 'Includes the unit test suite.')
    ..addFlag('integration',
        defaultsTo: defaultIntegration,
        help: 'Includes the integration test suite.')
    ..addFlag('functional',
        defaultsTo: defaultFunctional,
        help: 'Includes the functional test suite.')
    ..addOption('concurrency',
        abbr: 'j',
        defaultsTo: '$defaultConcurrency',
        help: 'The number of concurrent test suites run.')
    ..addFlag('pub-serve',
        negatable: true,
        defaultsTo: defaultPubServe,
        help: 'Serves browser tests using a Pub server.')
    ..addOption('pub-serve-port',
        help:
            'Port used by the Pub server for browser tests. The default value will randomly select an open port to use.')
    ..addOption('platform',
        abbr: 'p',
        allowMultiple: true,
        help:
            'The platform(s) on which to run the tests.\n[vm (default), dartium, content-shell, chrome, phantomjs, firefox, safari]')
    ..addOption('name',
        abbr: 'n',
        help:
            'A substring of the name of the test to run.\nRegular expression syntax is supported.');

  final String command = 'test';

  bool isExplicitlyFalse(bool value) {
    return value != null && value == false;
  }

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    if (!platform_util.hasImmediateDependency('test'))
      return new CliResult.fail(
          'Package "test" must be an immediate dependency in order to run its executables.');

    List<String> additionalArgs = [];
    List<String> tests = [];

    if (!color) {
      additionalArgs.add('--no-color');
    }

    bool pubServe =
        TaskCli.valueOf('pub-serve', parsedArgs, config.test.pubServe);

    var pubServePort =
        TaskCli.valueOf('pub-serve-port', parsedArgs, config.test.pubServePort);
    if (pubServePort is String) {
      pubServePort = int.parse(pubServePort);
    }

    var concurrency =
        TaskCli.valueOf('concurrency', parsedArgs, config.test.concurrency);
    if (concurrency is String) {
      concurrency = int.parse(concurrency);
    }
    List<String> platforms =
        TaskCli.valueOf('platform', parsedArgs, config.test.platforms);

    // CLI user can specify individual test files to run.
    bool individualTestsSpecified = parsedArgs.rest.isNotEmpty;

    // The unit test suite should be run by default.
    bool unit = parsedArgs['unit'] ?? true;

    // The integration suite should only be run if the --integration is set.
    bool integration = parsedArgs['integration'] ?? false;

    // The functional suite should only be run if the --functional is set.
    bool functional = parsedArgs['functional'] ?? false;

    // CLI user can filter tests by name.
    bool testNamed = parsedArgs['name'] != null;

    if (!individualTestsSpecified && !unit && !integration && !functional) {
      return new CliResult.fail(
          'No tests were selected. Include at least one of --unit, '
          '--integration, --functional or pass in one or more test '
          'files/directories');
    }

    // Build the list of tests to run.
    if (individualTestsSpecified) {
      // Individual tests explicitly passed in should override the test suites.
      tests.addAll(parsedArgs.rest);
    } else {
      // Unit and/or integration suites should only run if individual tests
      // were not specified.
      if (unit) {
        tests.addAll(config.test.unitTests);
      }
      if (integration) {
        tests.addAll(config.test.integrationTests);
      }
      if (functional) {
        tests.addAll(config.test.functionalTests);
      }
    }

    if (tests.isEmpty) {
      if (unit && config.test.unitTests.isEmpty) {
        return new CliResult.fail(
            'This project does not specify any unit tests.');
      }
      if (integration && config.test.integrationTests.isEmpty) {
        return new CliResult.fail(
            'This project does not specify any integration tests.');
      }
      if (functional && config.test.functionalTests.isEmpty) {
        return new CliResult.fail(
            'This project does not specify any functional tests.');
      }
    }

    PubServeTask pubServeTask;

    if (pubServe) {
      bool isPubServeRunning = await isPortBound(pubServePort);

      if (!isPubServeRunning) {
        // Start `pub serve` on the `test` directory
        pubServeTask =
            startPubServe(port: pubServePort, additionalArgs: ['test']);

        var startupLogFinished = new Completer();
        reporter.logGroup(pubServeTask.command,
            outputStream:
                pubServeTask.stdOut.transform(until(startupLogFinished.future)),
            errorStream: pubServeTask.stdErr
                .transform(until(startupLogFinished.future)));

        var serveInfo = await pubServeTask.serveInfos.first;
        pubServePort = serveInfo.port;

        startupLogFinished.complete();
        pubServeTask.stdOut.join('\n').then((stdOut) {
          if (stdOut.isNotEmpty) {
            reporter.logGroup('`${pubServeTask.command}` (buffered stdout)',
                output: stdOut);
          }
        });
        pubServeTask.stdErr.join('\n').then((stdErr) {
          if (stdErr.isNotEmpty) {
            reporter.logGroup('`${pubServeTask.command}` (buffered stderr)',
                error: stdErr);
          }
        });
      }

      additionalArgs.add('--pub-serve=$pubServePort');
    }

    if (testNamed) {
      additionalArgs.addAll(['-n', '${parsedArgs['name']}']);
    }

    TestTask task = test(
        tests: tests,
        concurrency: concurrency,
        platforms: platforms,
        additionalArgs: additionalArgs);
    reporter.logGroup(task.testCommand, outputStream: task.testOutput);

    await task.done;

    if (pubServeTask != null) {
      pubServeTask.stop();
      // Wait for the task to finish to flush its output.
      await pubServeTask.done;
    }

    return task.successful
        ? new CliResult.success(task.testSummary)
        : new CliResult.fail(task.testSummary);
  }
}
