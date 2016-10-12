library tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  config.test
    ..pubServe = true
    ..platforms = [
      'vm',
      'content-shell'
    ]
    // Prevent test load timeouts on Smithy.
    ..concurrency = 1
    ..unitTests = [
      'test/vm_tests/',
      'test/test_util_test.dart',
      'test/ui_core_test.dart',
    ];

  config.coverage
    ..html = false
    ..pubServe = true
    ..reportOn = [
      'lib/'
    ];

  await dev(args);
}
