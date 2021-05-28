// // Copyright 2016 Workiva Inc.
// //
// // Licensed under the Apache License, Version 2.0 (the "License");
// // you may not use this file except in compliance with the License.
// // You may obtain a copy of the License at
// //
// //     http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing, software
// // distributed under the License is distributed on an "AS IS" BASIS,
// // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// // See the License for the specific language governing permissions and
// // limitations under the License.
//
// import 'package:dart_dev/dart_dev.dart';
// import 'package:glob/glob.dart';
//
// final config = {
//   'analyze': AnalyzeTool()
//     ..include = [
//       Glob('lib/**.dart'),
//       Glob('test/**.dart'),
//       Glob('tool/**.dart'),
//     ],
//   'format': FormatTool()
//     ..formatterArgs = ['--line-length=100']
//     ..exclude = [
//       // We don't format most of this repo with dartfmt, yet.
//       Glob('app/**'),
//       Glob('example/**'),
//       Glob('lib/*'),
//       Glob('lib/src/builder/builder.dart'),
//       Glob('lib/src/builder/util.dart'),
//       Glob('lib/src/component/**'),
//       Glob('lib/src/component_declaration/**'),
//       Glob('lib/src/over_react_redux/**'),
//       Glob('lib/src/util/**'),
//       Glob('test/**'),
//       Glob('tools/analyzer_plugin/**'),
//       Glob('test_fixtures/**'),
//       Glob('web/**'),
//     ],
//   'test': TestTool()
//     ..buildArgs = [
//       '--delete-conflicting-outputs',
//     ],
// };
