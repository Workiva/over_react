library dart_dev.dev;

import 'package:dart_dev/dart_dev.dart';

main(args) async {
  const directories = const [
    'tool/',
  ];

  config.analyze.entryPoints = directories;
  config.format
    ..paths = directories;

  config.coverage
    ..checkedMode = true
    ..pubServe = true
    ..reportOn = ['lib/'];

  await dev(args);
}