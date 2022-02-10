import 'dart:convert';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:react_material_ui/react_material_ui.dart' as mui;
import 'package:react_material_ui/src/unstable_components.dart' as mui;

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/components/app_bar/save_as_menu_item.dart';
import 'package:todo_client/src/components/app_bar/saved_data_menu_item.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/menu_overlay.dart';

part 'app_bar_local_storage_menu.over_react.g.dart';

UiFactory<AppBarLocalStorageMenuProps> AppBarLocalStorageMenu =
    connect<AppState, AppBarLocalStorageMenuProps>(
  mapStateToProps: (state) {
    return (AppBarLocalStorageMenu()
      ..currentDataSetName = state.name
      ..currentDataHasBeenModified =
          json.encode(localTodoAppStorage[state.name]) !=
              json.encode(state.toJson()));
  },
)(castUiFactory(_$AppBarLocalStorageMenu)); // ignore: undefined_identifier

mixin AppBarLocalStorageMenuPropsMixin on UiProps {
  String currentDataSetName;
  List<String> savedLocalStorageStateNames;
  bool currentDataHasBeenModified;
}

class AppBarLocalStorageMenuProps = UiProps
    with MenuOverlayProps, AppBarLocalStorageMenuPropsMixin, ConnectPropsMixin;

class AppBarLocalStorageMenuComponent
    extends UiComponent2<AppBarLocalStorageMenuProps> {
  final _overlayRef = createRef<MenuOverlayComponent>();
  bool get _currentStateKeyIsReadOnly =>
      TodoAppLocalStorage.reservedStateKeys.contains(props.currentDataSetName);

  @override
  get consumedProps => propsMeta.allExceptForMixins({MenuOverlayProps});

  @override
  render() {
    return (MenuOverlay()
      ..modifyProps(addUnconsumedProps)
      ..trigger = (mui.Button()
        ..color = mui.ButtonColor.inherit)('Data: ${props.currentDataSetName}')
      ..useDerivedMaxWidth = true
      ..ref = _overlayRef)(
      _renderSaveMenuItem(),
      _renderSaveAsMenuItem(),
      (mui.MenuItem()
            ..onClick = (_) =>
                _loadFromLocalStorage(TodoAppLocalStorage.defaultStateKey))(
          'Load Default Data'),
      (mui.MenuItem()
            ..onClick = (_) =>
                _loadFromLocalStorage(TodoAppLocalStorage.emptyStateKey))(
          'Load Empty Data'),
      _renderSavedStateMenuItems(),
    );
  }

  ReactElement _renderSaveMenuItem() {
    if (!props.currentDataHasBeenModified || _currentStateKeyIsReadOnly)
      return null;

    return (mui.MenuItem()
      ..onClick = (SyntheticMouseEvent event) {
        event.stopPropagation(); // Don't close the menu
        _handleCurrentLocalStorageStateSaveAs(
            newStateName: props.currentDataSetName);
      })(
      'Save ${props.currentDataSetName}',
    );
  }

  ReactElement _renderSaveAsMenuItem() {
    return (SaveAsMenuItem()
      ..initialValue = _currentStateKeyIsReadOnly
          ? 'Copy of ${props.currentDataSetName}'
          : props.currentDataSetName
      ..onSave = (newStateName) {
        _handleCurrentLocalStorageStateSaveAs(newStateName: newStateName);
      })();
  }

  ReactElement _renderSavedStateMenuItem(String stateKey) {
    final json = localTodoAppStorage.mapOfCustomStatesJson[stateKey];
    return (SavedDataMenuItem()
      ..key = json['name']
      ..['selected'] = json['name'] == props.currentDataSetName
      ..localStorageKey = json['name']
      ..onSelect = _loadFromLocalStorage
      ..onRename = (newStateName) {
        _handleLocalStorageStateRename(newStateName, renamedFrom: json['name']);
      }
      ..onDelete = (stateName) {
        localTodoAppStorage.remove(stateName);
        forceUpdate();
      })();
  }

  List<ReactElement> _renderSavedStateMenuItems() {
    if (localTodoAppStorage.mapOfCustomStatesJson.isEmpty) return null;

    return [
      (mui.Divider()..key = 'divider')(),
      ListSubheader({}, 'Custom Data Sets'),
      ...localTodoAppStorage.mapOfCustomStatesJson.keys
          .map(_renderSavedStateMenuItem),
    ];
  }

  void _handleLocalStorageStateRename(String newStateName,
      {String renamedFrom}) {
    props.dispatch(
        SaveLocalStorageStateAsAction(newStateName, previousName: renamedFrom));
  }

  void _handleCurrentLocalStorageStateSaveAs({String newStateName}) {
    props.dispatch(SaveLocalStorageStateAsAction(newStateName));
    _loadFromLocalStorage(newStateName);
    _overlayRef.current.close();
  }

  void _loadFromLocalStorage(String stateName) {
    props.dispatch(LoadStateFromLocalStorageAction(stateName));
    _overlayRef.current.close();
  }
}
