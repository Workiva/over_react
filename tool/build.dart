import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:built_redux/generator.dart';

Future main(List<String> args) async {
  // TODO: This is not compatible with the latest version(s) of the build / build_runner packages.
//  await build([
//    new BuildAction(
//        new PartBuilder([
//          new BuiltValueGenerator(),
//          new BuiltReduxGenerator(),
//        ]),
//        'over_react',
//        inputs: const ['test/over_react/component_declaration/redux_component_test/**'])
//  ], deleteFilesByDefault: true);
}
