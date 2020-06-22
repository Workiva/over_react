import 'package:dart_dev/dart_dev.dart';
import 'package:glob/glob.dart';

final config = {
  ...coreConfig,
  'format': FormatTool()
    ..exclude = [Glob('playground/**')]
    ..formatterArgs = ['--line-length=120'],
};
