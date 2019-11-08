// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement listGroupBasicDemo() =>
  ListGroup()(
    ListGroupItem()('Dapibus ac facilisis in'),
    ListGroupItem()('Cras sit amet nibh libero'),
    ListGroupItem()('Porta ac consectetur ac'),
    ListGroupItem()('Vestibulum at eros')
  );
