import 'package:dart_dev/dart_dev.dart';
import 'package:glob/glob.dart';

final config = {
  ...coreConfig,
  'analyze': AnalyzeTool()
    ..include = [
      Glob('lib/**.dart'),
      Glob('tool/**.dart'),
    ],
  'format': FormatTool()
    ..formatterArgs = ['--line-length=120']
    ..exclude = [
      Glob('playground/**'),
    ],
};
