import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'safe_render_manager_helper.over_react.g.dart';

/// A component that allows for safe unmounting of its single child by waiting for state changes
/// sometimes queued by ReactJS to be applied.
@Factory()
UiFactory<SafeRenderManagerHelperProps> SafeRenderManagerHelper =
    // ignore: undefined_identifier
    _$SafeRenderManagerHelper;

typedef ReactElement _GetInitialContent();

@Props()
class _$SafeRenderManagerHelperProps extends UiProps {
  @requiredProp
  _GetInitialContent getInitialContent;

  CallbackRef contentRef;
}

@State()
class _$SafeRenderManagerHelperState extends UiState {
  ReactElement content;
}

@Component()
class SafeRenderManagerHelperComponent extends UiStatefulComponent<SafeRenderManagerHelperProps, SafeRenderManagerHelperState> {
  @override
  getInitialState() => (newState()..content = props.getInitialContent());

  void renderContent(ReactElement content) {
    setState(newState()..content = content);
  }

  void tryUnmountContent({void onMaybeUnmounted(bool isUnmounted)}) {
    setState(newState()..content = null, () {
      onMaybeUnmounted?.call(state.content == null);
    });
  }

  bool get hasContent => state.content != null;

  @override
  render() {
    if (state.content == null) return null;

    return cloneElement(state.content, domProps()..ref = chainRef(state.content, _contentRef));
  }

  void _contentRef(ref) {
    props.contentRef?.call(ref);
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class SafeRenderManagerHelperProps extends _$SafeRenderManagerHelperProps with _$SafeRenderManagerHelperPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForSafeRenderManagerHelperProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class SafeRenderManagerHelperState extends _$SafeRenderManagerHelperState with _$SafeRenderManagerHelperStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForSafeRenderManagerHelperState;
}
