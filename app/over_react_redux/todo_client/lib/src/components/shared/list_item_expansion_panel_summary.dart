import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/hoverable_item_mixin.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

part 'list_item_expansion_panel_summary.over_react.g.dart';

UiFactory<ListItemExpansionPanelSummaryProps> ListItemExpansionPanelSummary =
    _$ListItemExpansionPanelSummary; // ignore: undefined_identifier

mixin ListItemExpansionPanelSummaryProps on UiProps {
  @requiredProp
  String modelId;
  @requiredProp
  bool allowExpansion;
  @requiredProp
  bool isEditable;
  @requiredProp
  Function() onToggleEditable;
}

class ListItemExpansionPanelSummaryState = UiState with HoverableItemStateMixin;

class ListItemExpansionPanelSummaryComponent
    extends UiStatefulComponent2<ListItemExpansionPanelSummaryProps, ListItemExpansionPanelSummaryState>
    with HoverableItemMixin<ListItemExpansionPanelSummaryProps, ListItemExpansionPanelSummaryState> {
  @override
  get itemNodeRef => createRef<Element>();

  @override
  render() {
    return ExpansionPanelSummary({
      'ref': itemNodeRef,
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

