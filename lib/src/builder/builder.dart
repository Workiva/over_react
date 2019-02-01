import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import './util.dart';
import './generator.dart';

Builder overReactBuilder(BuilderOptions options) =>
    new PartBuilder([new OverReactGenerator()], outputExtension);
