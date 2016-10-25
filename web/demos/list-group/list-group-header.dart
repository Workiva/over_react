part of over_react.web.demos;

ReactElement listGroupHeaderDemo() =>
  ListGroup()(
    (ListGroupItem()
      ..header = 'List group item heading'
      ..onClick = (_) {}
      ..isActive = true
    )(
      'Donec id elit non mi porta gravida at eget metus. '
      'Maecenas sed diam eget risus varius blandit.'
    ),
    (ListGroupItem()
      ..header = 'List group item heading'
      ..headerSize = ListGroupItemHeaderElementSize.H4
      ..onClick = (_) {}
    )(
      'Donec id elit non mi porta gravida at eget metus. '
      'Maecenas sed diam eget risus varius blandit.'
    ),
    (ListGroupItem()
      ..header = 'List group item heading'
      ..headerSize = ListGroupItemHeaderElementSize.H3
      ..onClick = (_) {}
    )(
      'Donec id elit non mi porta gravida at eget metus. '
      'Maecenas sed diam eget risus varius blandit.'
    )
  );
