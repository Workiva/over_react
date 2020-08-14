import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'container.over_react.g.dart'; // ignore: uri_has_not_been_generated

final useStyles = makeStyles({
  'newRoot': (ContainerWrapperProps props) => ({
    // Note that the null aware here is essentially serving the purpose of default props
    // Do we want a better interface for that?
    'backgroundColor': props.backgroundColor ?? 'gray',
    'height': 500,
  })
},
  config: $ContainerWrapperConfig, // ignore: undefined_identifier
);

mixin ContainerWrapperProps on UiProps {
  String backgroundColor;
}

UiFactory<ContainerWrapperProps> ContainerWrapper = uiFunction((props) {
  final styles = useStyles(props);

  return (Container()..classes = JsBackedMap.from({
    'root': styles['newRoot'],
  }))(props.children);
},
  $ContainerWrapperConfig, // ignore: undefined_identifier
);

