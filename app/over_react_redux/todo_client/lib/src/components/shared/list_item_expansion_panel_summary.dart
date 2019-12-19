import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/hoverable_item_mixin.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'list_item_expansion_panel_summary.over_react.g.dart';

@Factory()
UiFactory<ListItemExpansionPanelSummaryProps> ListItemExpansionPanelSummary =
    // ignore: undefined_identifier
    _$ListItemExpansionPanelSummary;

@Props()
class _$ListItemExpansionPanelSummaryProps extends UiProps {
  @requiredProp
  String modelId;
  @requiredProp
  bool allowExpansion;
  @requiredProp
  bool isEditable;
  @requiredProp
  Function() onToggleEditable;
}

@State()
class _$ListItemExpansionPanelSummaryState extends UiState
    with HoverableItemStateMixin,
         // ignore: mixin_of_non_class, undefined_class
         $HoverableItemStateMixin {}

@Component2()
class ListItemExpansionPanelSummaryComponent
    extends UiStatefulComponent2<ListItemExpansionPanelSummaryProps, ListItemExpansionPanelSummaryState>
    with HoverableItemMixin<ListItemExpansionPanelSummaryProps, ListItemExpansionPanelSummaryState> {
  @override
  render() {
    return ExpansionPanelSummary({
      'aria-controls': 'details_${props.modelId}',
      'id': 'summary_${props.modelId}',
      'expandIcon': ExpandMoreIcon(),
      'IconButtonProps': {
        'disabled': !props.allowExpansion,
        'style': props.allowExpansion ? null : {'color': 'transparent'},
      },
      'style': props.allowExpansion ? null : {'cursor': 'default'},
      'onMouseEnter': handleItemMouseEnter,
      'onMouseLeave': handleItemMouseLeave,
      'onMouseOver': handleItemMouseOver,
      'onFocus': handleChildFocus,
      'onBlur': handleChildBlur,
    },
      Grid({
        'container': true,
        'direction': 'row',
      },
        props.children,
        _renderEditButton(),
      ),
    );
  }

  ReactElement _renderEditButton() {
    return Box({
      ...shrinkToFitProps,
      'mr': -1,
      'alignSelf': 'center',
      'aria-hidden': !isHovered,
      'className': 'hide-using-aria',
    },
      Tooltip({
        'enterDelay': 500,
        'title': props.isEditable ? 'Save Changes' : 'Make Changes',
      },
        IconButton({
          'aria-label': props.isEditable ? 'Save Changes' : 'Make Changes',
          'className': 'todo-list__item__edit-btn',
          'onClick': (SyntheticMouseEvent event) {
            event.stopPropagation();
            props.onToggleEditable();
          },
          'color': props.isEditable ? 'primary' : 'default',
        },
          EditPencilIcon(),
        ),
      ),
    );
  }
}

// ignore: mixin_of_non_class, undefined_class
class ListItemExpansionPanelSummaryProps extends _$ListItemExpansionPanelSummaryProps with _$ListItemExpansionPanelSummaryPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForListItemExpansionPanelSummaryProps;
}

// ignore: mixin_of_non_class, undefined_class
class ListItemExpansionPanelSummaryState extends _$ListItemExpansionPanelSummaryState with _$ListItemExpansionPanelSummaryStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForListItemExpansionPanelSummaryState;
}
