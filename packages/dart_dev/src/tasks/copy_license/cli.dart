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

library dart_dev.src.tasks.copy_license.cli;

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';

import 'package:dart_dev/src/tasks/copy_license/api.dart';
import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';

class CopyLicenseCli extends TaskCli {
  final ArgParser argParser = new ArgParser();

  final String command = 'copy-license';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    List<String> directories = config.copyLicense.directories;
    String licensePath = config.copyLicense.licensePath;

    if (!(new File(licensePath)).existsSync())
      return new CliResult.fail('License file "$licensePath" does not exist.');

    CopyLicenseTask task =
        copyLicense(directories: directories, licensePath: licensePath);
    await task.done;
    if (task.successful) {
      int numFiles = task.affectedFiles.length;
      String fileSummary = '\n  ${task.affectedFiles.join('\n  ')}';
      String result = numFiles == 0
          ? 'License already exists on all files.'
          : 'License successfully applied to $numFiles files:$fileSummary';
      return new CliResult.success(result);
    } else {
      return new CliResult.fail('License application failed.');
    }
  }
}
