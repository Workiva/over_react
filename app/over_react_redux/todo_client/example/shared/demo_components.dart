import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'demo_components.over_react.g.dart'; // ignore: uri_has_not_been_generated

final useStyles = makeThemedStyles((theme) => {
      'exampleGroupContainer': {
        'marginBottom': 20,
      },
      'exampleBlockStyles': {
        'backgroundColor': theme.palette.grey['400'],
        'height': '100%',
      },
      'exampleInnerContainer': {
        'padding': 20,
      },
      'exampleBlockHeader': {
        'marginBottom': 20,
      },
      'exampleHeading': {
        'marginBottom': 20,
      },
      'exampleContainer': {
        'padding': '0px 5px',
      }
    });

mixin ExampleGroupProps on UiProps {
  String groupTitle;
  String groupSubTitle;
}

UiFactory<ExampleGroupProps> ExampleGroup = uiFunction(
  (props) {
    final classes = useStyles();

    return ((Container()..className = classes['exampleGroupContainer'])(
      (Typography()..variant = TypographyVariant.H4)(
        props.groupTitle,
      ),
      (Typography()
        ..variant = TypographyVariant.SUBTITLE1
        ..className = classes['exampleBlockHeader']
      )(
        props.groupSubTitle,
      ),
      (Grid()
        ..container = true
        ..direction = GridDirection.ROW
        ..justify = GridJustify.SPACE_AROUND
        ..spacing = GridSpacing.THREE
      )(
        props.children,
      ),
    ));
  },
  $ExampleGroupConfig, // ignore: undefined_identifier
);

mixin ExampleBlockProps on UiProps {
  String exampleBlockTitle;
  String exampleBlockDescription;
}

UiFactory<ExampleBlockProps> ExampleBlock = uiFunction(
  (props) {
    final classes = useStyles();

    return ((Grid()
      ..item = true
      ..xs = GridNum.SIX
      ..alignItems = GridAlignItems.STRETCH
    )(
      Paper(
          {'elevation': 3, 'className': classes['exampleBlockStyles']},
          (Grid()
            ..container = true
            ..className = classes['exampleInnerContainer']
          )(
            (Grid()
              ..item = true
              ..className = classes['exampleHeading']
            )(
              (Typography()..variant = TypographyVariant.H5)(
                props.exampleBlockTitle,
              ),
              (Typography()..variant = TypographyVariant.SUBTITLE1)(
                props.exampleBlockDescription,
              ),
            ),
            (Grid()
              ..container = true
              ..direction = GridDirection.ROW
              ..justify = GridJustify.SPACE_AROUND
            )(
              props.children,
            ),
          )),
    ));
  },
  $ExampleBlockConfig, // ignore: undefined_identifier
);

mixin ExampleProps on UiProps {
  String exampleTitle;
}

UiFactory<ExampleProps> Example = uiFunction(
  (props) {
    final classes = useStyles();

    return ((Grid()
      ..item = true
      ..className = classes['exampleContainer']
    )(
      (Typography()..variant = TypographyVariant.H6)(props.exampleTitle),
      props.children,
    ));
  },
  $ExampleConfig, // ignore: undefined_identifier
);
