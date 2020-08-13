import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'container.over_react.g.dart'; // ignore: uri_has_not_been_generated

final useStyles = makeStyles({
  'newRoot': {
    'backgroundColor': 'gray',
    'width': '100%',
    'height': 500,
  }
});

mixin ContainerWrapperProps on UiProps {}

UiFactory<ContainerWrapperProps> ContainerWrapper = uiFunction((props) {
  final styles = useStyles();

  return (Container()..classes = JsBackedMap.from({
    'root': styles['newRoot'],
  }))(props.children);
},
  $ContainerWrapperConfig, // ignore: undefined_identifier
);

