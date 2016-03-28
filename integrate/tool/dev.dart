library tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  config.analyze
    ..strong = true
    ..fatalWarnings = true
    ..entryPoints = ['web/'];

  config.test
    ..pubServe = true
    ..platforms = [
      'content-shell'
    ]
    ..unitTests = [
      'test/test_runtime_import.dart',
    ];

  await dev(args);
}
