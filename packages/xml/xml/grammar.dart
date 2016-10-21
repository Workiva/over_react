part of xml;

/// XML grammar definition with [TNode] and [TName].
abstract class XmlGrammarDefinition<TNode, TName> extends GrammarDefinition {

  // name patterns
  static const NAME_START_CHARS =
      ':A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF'
      '\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001\uD7FF'
      '\uF900-\uFDCF\uFDF0-\uFFFD';
  static const NAME_CHARS =
      '-.0-9\u00B7\u0300-\u036F\u203F-\u2040$NAME_START_CHARS';
  static const CHAR_DATA = '^<';

  // basic tokens
  static const DOUBLE_QUOTE = '"';
  static const SINGLE_QUOTE = "'";
  static const EQUALS = '=';
  static const WHITESPACE = ' ';
  static const OPEN_COMMENT = '<!--';
  static const CLOSE_COMMENT = '-->';
  static const OPEN_CDATA = '<![CDATA[';
  static const CLOSE_CDATA = ']]>';
  static const OPEN_ELEMENT = '<';
  static const CLOSE_ELEMENT = '>';
  static const OPEN_END_ELEMENT = '</';
  static const CLOSE_END_ELEMENT = '/>';
  static const OPEN_DOCTYPE = '<!DOCTYPE';
  static const CLOSE_DOCTYPE = '>';
  static const OPEN_DOCTYPE_BLOCK = '[';
  static const CLOSE_DOCTYPE_BLOCK = ']';
  static const OPEN_PROCESSING = '<?';
  static const CLOSE_PROCESSING = '?>';

  // parser callbacks
  TNode createAttribute(TName name, String text);
  TNode createComment(String text);
  TNode createCDATA(String text);
  TNode createDoctype(String text);
  TNode createDocument(Iterable<TNode> children);
  TNode createElement(TName name, Iterable<TNode> attributes,
      Iterable<TNode> children);
  TNode createProcessing(String target, String text);
  TName createQualified(String name);
  TNode createText(String text);

  // productions
  start() => ref(document).end();

  attribute() => ref(qualified)
      .seq(ref(space_optional))
      .seq(char(EQUALS))
      .seq(ref(space_optional))
      .seq(ref(attributeValue))
      .map((each) => createAttribute(each[0] as TName, each[4]));
  attributeValue() => ref(attributeValueDouble)
      .or(ref(attributeValueSingle))
      .pick(1);
  attributeValueDouble() => char(DOUBLE_QUOTE)
      .seq(new _XmlCharacterDataParser(DOUBLE_QUOTE, 0))
      .seq(char(DOUBLE_QUOTE));
  attributeValueSingle() => char(SINGLE_QUOTE)
      .seq(new _XmlCharacterDataParser(SINGLE_QUOTE, 0))
      .seq(char(SINGLE_QUOTE));
  attributes() => ref(space)
      .seq(ref(attribute))
      .pick(1)
      .star();
  comment() => string(OPEN_COMMENT)
      .seq(any().starLazy(string(CLOSE_COMMENT)).flatten())
      .seq(string(CLOSE_COMMENT))
      .map((each) => createComment(each[1]));
  cdata() => string(OPEN_CDATA)
      .seq(any().starLazy(string(CLOSE_CDATA)).flatten())
      .seq(string(CLOSE_CDATA))
      .map((each) => createCDATA(each[1]));
  content() => ref(characterData)
      .or(ref(element))
      .or(ref(processing))
      .or(ref(comment))
      .or(ref(cdata))
      .star();
  doctype() => string(OPEN_DOCTYPE)
      .seq(ref(space))
      .seq(ref(nameToken)
          .or(ref(attributeValue))
          .or(any()
              .starLazy(char(OPEN_DOCTYPE_BLOCK))
              .seq(char(OPEN_DOCTYPE_BLOCK))
              .seq(any().starLazy(char(CLOSE_DOCTYPE_BLOCK)))
              .seq(char(CLOSE_DOCTYPE_BLOCK)))
          .separatedBy(ref(space))
          .flatten())
      .seq(ref(space_optional))
      .seq(char(CLOSE_DOCTYPE))
      .map((each) => createDoctype(each[2]));
  document() => ref(processing).optional()
      .seq(ref(misc))
      .seq(ref(doctype).optional())
      .seq(ref(misc))
      .seq(ref(element))
      .seq(ref(misc))
      .map((each) => createDocument([each[0], each[2], each[4]]
          .where((each) => each != null) as Iterable<TNode>));
  element() => char(OPEN_ELEMENT)
      .seq(ref(qualified))
      .seq(ref(attributes))
      .seq(ref(space_optional))
      .seq(string(CLOSE_END_ELEMENT).or(char(CLOSE_ELEMENT)
          .seq(ref(content))
          .seq(string(OPEN_END_ELEMENT))
          .seq(ref(qualified))
          .seq(ref(space_optional))
          .seq(char(CLOSE_ELEMENT))))
      .map((list) {
    if (list[4] == CLOSE_END_ELEMENT) {
      return createElement(list[1] as TName, list[2] as Iterable<TNode>, []);
    } else {
      if (list[1] == list[4][3]) {
        return createElement(list[1] as TName, list[2] as Iterable<TNode>, list[4][1] as Iterable<TNode>);
      } else {
        throw new ArgumentError('Expected </${list[1]}>, but found </${list[4][3]}>');
      }
    }
  });
  processing() => string(OPEN_PROCESSING)
      .seq(ref(nameToken))
      .seq(ref(space)
          .seq(any().starLazy(string(CLOSE_PROCESSING)).flatten())
          .pick(1)
          .optional(''))
      .seq(string(CLOSE_PROCESSING))
      .map((each) => createProcessing(each[1], each[2]));
  qualified() => ref(nameToken).map(createQualified);

  characterData() => new _XmlCharacterDataParser(OPEN_ELEMENT, 1).map(createText);
  misc() => ref(space).or(ref(comment)).or(ref(processing)).star();
  space() => whitespace().plus();
  space_optional() => whitespace().star();

  nameToken() => ref(nameStartChar).seq(ref(nameChar).star()).flatten();
  nameStartChar() => pattern(NAME_START_CHARS, 'Expected name');
  nameChar() => pattern(NAME_CHARS);
}
