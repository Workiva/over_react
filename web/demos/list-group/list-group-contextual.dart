part of over_react.web.demos;

ReactElement listGroupContextualSkinDemo() =>
  ListGroup()(
    (ListGroupItem()
      ..onClick = (_) {}
      ..skin = ListGroupItemSkin.SUCCESS
    )('Dapibus ac facilisis in'),
    (ListGroupItem()
      ..onClick = (_) {}
      ..skin = ListGroupItemSkin.INFO
    )('Cras sit amet nibh libero'),
    (ListGroupItem()
      ..onClick = (_) {}
      ..skin = ListGroupItemSkin.WARNING
    )('Porta ac consectetur ac'),
    (ListGroupItem()
      ..onClick = (_) {}
      ..skin = ListGroupItemSkin.DANGER
    )('Vestibulum at eros')
  );
