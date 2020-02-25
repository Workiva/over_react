import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing/declarations.dart';
import 'package:over_react/src/builder/generation/parsing/members.dart';
import 'package:source_span/source_span.dart';

main() {
  final sourceFile = SourceFile.fromString(r'''
    
UiFactory<BasicPropsMixin> Basic = _$Basic;

mixin BasicPropsMixin on UiProps {
  @deprecated
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

class BasicComponent extends UiComponent2<BasicPropsMixin> {
  @override
  get defaultProps => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'; // ignore: deprecated_member_use_from_same_package

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use_from_same_package
        Dom.div()('default prop testing: ${props.basic1}'),
        Dom.div()(null, props.basic4, 'children: ${props.children}' ),
    );
  }
}
  ''');

  final errorCollector = ConsoleValidationErrorCollector(sourceFile);
  final unit = parseString(content: sourceFile.getText(0)).unit;

  final members = BoilerplateMemberDetector();
  unit.accept(members);
  print(members);

  final declarations = getBoilerplateDeclarations(members, errorCollector);
  print(declarations);
}
