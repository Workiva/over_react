library generate_code;

import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart' as source_gen;
import 'package:web_skin_dart/code_generation/code_generation.dart';

main(List<String> args) async {
 const List<String> librarySearchPaths = const ['lib/'];
 const List generators = const [
   const ConstantsGenerator(),
   const PropsGenerator(),
   const StateGenerator()
 ];

 print('-' * 60);
 print('web_skin_dart Code Generation\n');
 print(' Generates getters/setters for strongly-typed props/state');
 print(' and enumeration-like constants that hold data.');
 print('-' * 60);

 print('\nUsing library search paths $librarySearchPaths.');

 /// Build using the specified list of generators, and log using reformatted output.
 generate({String message: ''}) async {
   print('\n\n${message}Generating using $generators...');
   var result = await source_gen.generate(path.current, generators, librarySearchPaths: librarySearchPaths, omitGenerateTimestamp: true);
   print('\n' + formatResultMessage(result));
 }

 // Generate twice so that constant classes are available on the second pass for analysis during props/state generation.
 // If they're not available, props/state generation code will resolve them as type 'dynamic'.
 // TODO: utilize incremental generation or separate generation outputs for constants and props/state (once source_gen supports it)
 // See source_gen issue on incremental generation: https://github.com/dart-lang/source_gen/issues/33
 await generate(message: 'First pass: ');
 await generate(message: 'Final pass: ');

 print('\n\nDone.');
}
