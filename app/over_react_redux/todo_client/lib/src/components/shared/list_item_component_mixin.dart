import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react_material_ui/src/unstable_components.dart' as mui;

import 'package:todo_client/src/models/base_model.dart';
import 'package:todo_client/src/components/shared/list_item_mixin.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

mixin ListItemMixin<M extends BaseModel, T extends ListItemPropsMixin,
    S extends ListItemStateMixin> on UiStatefulComponent2<T, S> {
  @override
  @mustCallSuper
  get defaultProps => (newProps()
    ..isEditable = false
    ..isSelected = false);

  @override
  @mustCallSuper
  get initialState => (newState()..localModel = props.model);

  dynamic get sharedAccordionProps => (mui.Accordion()
    ..onChange_Accordion = handleAccordionExpandedStateChange
    ..expanded = props.isSelected
    ..style = highlightedItemStyle);

  @protected
  Map<String, dynamic> get highlightedItemStyle => {
        if (props.isHighlighted) 'backgroundColor': muiColors['yellow']['50'],
      };

  bool get hasDetails;

  bool get allowExpansion => hasDetails || props.isEditable;

  @protected
  void handleAccordionExpandedStateChange(SyntheticEvent event, _) {
    if (!allowExpansion) return;
    event?.stopPropagation();
    toggleSelect();
  }

  M get model => props.isEditable ? state.localModel : props.model;

  void _resetLocalModelToPersistedModel([Function() afterReset]) {
    setState(newState()..localModel = props.model, afterReset);
  }

  @protected
  void remove() {
    props.onRemove(model.id);
  }

  @protected
  void updateModel(M newModelValue) {
    if (props.isEditable) {
      // When user is doing a bulk edit, store it locally first so they can cancel their changes if they want to.
      setState(newState()..localModel = newModelValue);
    } else {
      props.onModelUpdate(newModelValue);
    }
  }

  @protected
  void enterEditable() {
    if (!props.isEditable) {
      _resetLocalModelToPersistedModel(() {
        props.onBeginEdit(model.id);
      });
    }
  }

  @protected
  void exitEditable({bool saveChanges = true}) {
    if (saveChanges) {
      props.onModelUpdate(state.localModel);
    } else {
      _resetLocalModelToPersistedModel();
    }

    if (props.isEditable) {
      props.onFinishEdit(model.id);
    }
  }

  @protected
  void toggleEditable() {
    if (props.isEditable) {
      exitEditable();
    } else {
      enterEditable();
    }
  }

  @protected
  void select() {
    props.onSelect(model.id);
  }

  @protected
  void deselect() {
    if (props.isEditable) {
      exitEditable(saveChanges: true);
    }

    props.onDeselect(model.id);
  }

  @protected
  void toggleSelect() {
    if (props.isSelected) {
      deselect();
    } else {
      select();
    }
  }
}
