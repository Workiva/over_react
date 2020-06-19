import 'package:dart_dev/dart_dev.dart';

final config = {
  ...coreConfig,
  'format': FormatTool()..formatterArgs = ['--line-length=120'],
};
