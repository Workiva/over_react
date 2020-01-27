import 'package:dart_dev/dart_dev.dart';
import 'package:glob/glob.dart';

final config = {
  'analyze': AnalyzeTool(),
  'format': FormatTool()
    ..exclude = [
      Glob('**/*.dart'), // We don't format this repo with dartfmt at this time.
    ],
  'test': TestTool()
    ..buildArgs = [
      '--delete-conflicting-outputs',
    ],
};
