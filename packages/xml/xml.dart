/// Dart XML is a lightweight library for parsing, traversing, querying and
/// building XML documents.
library xml;

import 'dart:collection';

import 'package:petitparser/petitparser.dart';

part 'xml/iterators/ancestors.dart';
part 'xml/iterators/descendants.dart';
part 'xml/iterators/following.dart';
part 'xml/iterators/preceding.dart';

part 'xml/nodes/attribute.dart';
part 'xml/nodes/cdata.dart';
part 'xml/nodes/comment.dart';
part 'xml/nodes/data.dart';
part 'xml/nodes/doctype.dart';
part 'xml/nodes/document.dart';
part 'xml/nodes/document_fragment.dart';
part 'xml/nodes/element.dart';
part 'xml/nodes/node.dart';
part 'xml/nodes/parent.dart';
part 'xml/nodes/processing.dart';
part 'xml/nodes/text.dart';

part 'xml/utils/child.dart';
part 'xml/utils/entities.dart';
part 'xml/utils/name.dart';
part 'xml/utils/named.dart';
part 'xml/utils/type.dart';
part 'xml/utils/writable.dart';

part 'xml/visitors/transformer.dart';
part 'xml/visitors/visitable.dart';
part 'xml/visitors/visitor.dart';
part 'xml/visitors/writer.dart';

part 'xml/builder.dart';
part 'xml/grammar.dart';
part 'xml/parser.dart';

final Parser _parser = new XmlParserDefinition().build();

/// Return an [XmlDocument] for the given `input` string, or throws an
/// [ArgumentError] if the input is invalid.
XmlDocument parse(String input) {
  var result = _parser.parse(input);
  if (result.isFailure) {
    throw new ArgumentError(new ParserError(result).toString());
  }
  return result.value;
}
