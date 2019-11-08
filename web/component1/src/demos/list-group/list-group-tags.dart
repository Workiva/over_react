// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement listGroupTagsDemo() =>
  ListGroup()(
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(14),
      'Cras justo odio'
    ),
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(2),
      'Dapibus ac facilisis in'
    ),
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(1),
      'Morbi leo risus'
    )
  );
