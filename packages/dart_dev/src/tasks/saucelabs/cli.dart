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

library dart_dev.src.tasks.saucelabs.cli;

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';

import 'package:dart_dev/util.dart' show reporter, TaskProcess;

import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';
import 'package:dart_dev/src/tasks/saucelabs/api.dart';
import 'package:dart_dev/src/tasks/saucelabs/sauce_runner.dart' as sauceRunner;
import 'package:dart_dev/src/tasks/saucelabs/xml_reporter.dart';

class SauceRunnerCli extends TaskCli {
  final ArgParser argParser = new ArgParser()
    ..addOption('build-name',
        abbr: 'b', defaultsTo: 'saucelabs', help: 'Build name for the run.')
    ..addFlag('new-sauce-tunnel',
        defaultsTo: true,
        negatable: true,
        help: 'Create a new sauce-connect tunnel.')
    ..addOption('sauce-tunnel-identifier',
        abbr: 'i', help: 'Identifier to use in sauce tunnel creation.');

  final String command = 'saucelabs';

  final String sauceAccessKey = env['SAUCE_ACCESS_KEY'];
  final String sauceUserName = env['SAUCE_USERNAME'];

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    if (sauceUserName == null || sauceAccessKey == null) {
      return new CliResult.fail('Sauce Labs credentials must be available via '
          'the `SAUCE_ACCESS_KEY` and `SAUCE_USERNAME` environment variables.');
    }

    if (config.saucelabs.filesToTest.isEmpty) {
      return new CliResult.fail('You must specify files to test.');
    }

    List<sauceRunner.SauceTest> sauceTests = [];

    for (String file in config.saucelabs.filesToTest) {
      sauceTests.add(new sauceRunner.SauceTest(file, file));
    }

    var autoSauceConnect =
        TaskCli.valueOf('new-sauce-tunnel', parsedArgs, true);
    var buildName =
        TaskCli.valueOf('build-name', parsedArgs, config.saucelabs.buildName);
    var tunnelIdentifier = TaskCli.valueOf('sauce-tunnel-identifier',
        parsedArgs, config.saucelabs.sauceConnectTunnelIdentifier);

    final int pubServePort = config.saucelabs.pubServePort ?? 0;

    if (tunnelIdentifier == null) {
      tunnelIdentifier = generateTunnelIdentifier();
    }

    var results = await sauceRunner.run(
        sauceTests, config.saucelabs.platforms, sauceUserName, sauceAccessKey,
        autoSauceConnect: autoSauceConnect,
        tunnelIdentifier: tunnelIdentifier,
        options: getSauceBuildOptions(buildName),
        pubServePort: pubServePort);

    var failed = false;

    for (var i = 0; i < results['js tests'].length; i++) {
      if (results['js tests'][i]['result'] != null) {
        if (results['js tests'][i]['result']['failed'] > 0) {
          failed = true;
        }
      } else {
        failed = true;
      }
    }

    reporter.log('');
    reporter.log(
        'Writing xUnit test report to ${config.saucelabs.testReportPath}.');
    var reportXml = sauceResultsToXunitXml(results);
    var reportOutput = new File(config.saucelabs.testReportPath);
    await reportOutput.create(recursive: true);
    await reportOutput.writeAsString(reportXml);

    if (failed) {
      return new CliResult.fail('Fail, there was an error in running your tests'
          ' please review the output above and the test report located at'
          ' ${config.saucelabs.testReportPath}.');
    } else {
      return new CliResult.success('Success, your tests completed successfully'
          ' on saucelabs.');
    }
  }
}
