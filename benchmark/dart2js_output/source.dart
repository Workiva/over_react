String componentBenchmark({
  required int componentCount,
  required int propsCount,
}) {
  final fileSource = StringBuffer('''
      import 'package:over_react/over_react.dart';
      part '{{PART_PATH}}';''');

  final mainStatements = StringBuffer()..writeln(mainAntiTreeShakingStatements);
  for (var i = 0; i < componentCount; i++) {
    final componentName = 'Foo$i';
    final mixinName = '${componentName}Props';
    final propsName = mixinName;
    final propTypesByName = {
      for (final i in Iterable.generate(propsCount)) 'foo$i': 'String',
    };
    final propNames = propTypesByName.keys;

    fileSource.writeln('''
        mixin $mixinName on UiProps {
          ${propDeclarations(propTypesByName)}
        }
        UiFactory<$propsName> $componentName = uiFunction((props) {
          ${propReadStatements(propNames)}
          final consumedProps = props.staticMeta.forMixins({$mixinName});
          return (Dom.div()
            ..addUnconsumedProps(props, consumedProps)
            ..modifyProps(props.addPropsToForward())
          )();
        }, _\$${componentName}Config);
    ''');

    mainStatements.writeln('($componentName()${
        // Write each prop
        propNames.map((name) => '..$name = ""').join('')})();');
  }

  fileSource
    ..writeln('void main() {')
    ..write(mainStatements)
    ..writeln('}');

  return fileSource.toString();
}

const mainAntiTreeShakingStatements = '''
  (Dom.div()..id = '1')(); // Other props class, DomProps
  ResizeSensor()(); // class component, legacy component, PropsMeta used in propTypes
  ResizeSensor().getPropKey((p) => p.id); // getPropKey generated impls
''';

String propDeclarations(Map propTypesByName) {
  return propTypesByName
      .mapEntries((name, type) => 'late $type $name;')
      .join('\n');
}

String propReadStatements(Iterable<String> propNames) {
  // Put inside an array, as opposed to separate print statements, so that each
  // additional prop doesn't contain additional code outside of the read.
  return 'print([${propNames.map((name) => 'props.$name').join(', ')}]);';
}

extension<K, V> on Map<K, V> {
  Iterable<T> mapEntries<T>(T Function(K, V) mapper) =>
      entries.map((entry) => mapper(entry.key, entry.value));
}
