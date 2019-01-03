import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import './builder_util.dart';
import './generator.dart';


Builder overReactBuilder(BuilderOptions options) =>
    new PartBuilder([new OverReactGenerator()], outputExtension);
