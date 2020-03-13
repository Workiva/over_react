import 'package:over_react/over_react.dart';

import 'package:todo_client/src/models/base_model.dart';

export 'package:todo_client/src/components/shared/list_item_component_mixin.dart';

// ignore: uri_has_not_been_generated
part 'list_item_mixin.over_react.g.dart';


 mixin ListItemPropsMixin on UiProps {
  

  

  covariant BaseModel model;

  @requiredProp bool isSelected;
  @requiredProp bool isEditable;
  @requiredProp bool isHighlighted;
  @requiredProp Function(String id) onSelect;
  @requiredProp Function(String id) onDeselect;
  @requiredProp Function(String id) onBeginEdit;
  @requiredProp Function(String id) onFinishEdit;
  @requiredProp Function(BaseModel updatedModel) onModelUpdate;
  @requiredProp Function(String id) onRemove;
}


 mixin ListItemStateMixin on UiState {
  

  

  covariant BaseModel localModel;
}
