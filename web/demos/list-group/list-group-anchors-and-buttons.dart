part of over_react.web.demos;

ReactElement listGroupAnchorsAndButtonsDemo() =>
  ListGroup()(
    (ListGroupItem()
      ..isActive = true
      ..href = '#'
    )('Cras justo odio'),
    (ListGroupItem()
      ..onClick = (_) {}
    )('Dapibus ac facilisis in'),
    (ListGroupItem()
      ..onClick = (_) {}
    )('Morbi leo risus'),
    (ListGroupItem()
      ..onClick = (_) {}
    )('Porta ac consectetur ac'),
    (ListGroupItem()
      ..isDisabled = true
      ..onClick = (_) {}
    )('Vestibulum at eros')
  );
