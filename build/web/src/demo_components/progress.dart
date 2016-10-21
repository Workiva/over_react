part of over_react.web.demo_components;

/// Bootstrap's `Progress` component stylizes the HTML5 `<progress>` element with a
/// few extra CSS classes and some crafty browser-specific CSS.
///
/// See: <http://v4-alpha.getbootstrap.com/components/progress/>
@Factory()
UiFactory<ProgressProps> Progress = ([Map backingProps]) => new _$ProgressPropsImpl(backingProps);

@Props()
class ProgressProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__value = const PropDescriptor(_$key__value), _$prop__min = const PropDescriptor(_$key__min), _$prop__max = const PropDescriptor(_$key__max), _$prop__skin = const PropDescriptor(_$key__skin), _$prop__isStriped = const PropDescriptor(_$key__isStriped), _$prop__isAnimated = const PropDescriptor(_$key__isAnimated), _$prop__caption = const PropDescriptor(_$key__caption), _$prop__captionProps = const PropDescriptor(_$key__captionProps), _$prop__showCaption = const PropDescriptor(_$key__showCaption), _$prop__showPercentComplete = const PropDescriptor(_$key__showPercentComplete), _$prop__rootNodeProps = const PropDescriptor(_$key__rootNodeProps); static const List<PropDescriptor> $props = const [_$prop__value, _$prop__min, _$prop__max, _$prop__skin, _$prop__isStriped, _$prop__isAnimated, _$prop__caption, _$prop__captionProps, _$prop__showCaption, _$prop__showPercentComplete, _$prop__rootNodeProps]; static const String _$key__value = 'ProgressProps.value', _$key__min = 'ProgressProps.min', _$key__max = 'ProgressProps.max', _$key__skin = 'ProgressProps.skin', _$key__isStriped = 'ProgressProps.isStriped', _$key__isAnimated = 'ProgressProps.isAnimated', _$key__caption = 'ProgressProps.caption', _$key__captionProps = 'ProgressProps.captionProps', _$key__showCaption = 'ProgressProps.showCaption', _$key__showPercentComplete = 'ProgressProps.showPercentComplete', _$key__rootNodeProps = 'ProgressProps.rootNodeProps'; static const List<String> $propKeys = const [_$key__value, _$key__min, _$key__max, _$key__skin, _$key__isStriped, _$key__isAnimated, _$key__caption, _$key__captionProps, _$key__showCaption, _$key__showPercentComplete, _$key__rootNodeProps]; 
  /// The id for the [Progress] component.
  ///
  /// If left unspecified one will be auto-generated for you to ensure
  /// that the [caption] element is properly linked for accessibility purposes.
  @override
  String get id;

  /// The current value of the [Progress] component.
  ///
  /// This value should be between the [min] and [max] values.
  ///
  /// Default: `0.0`
  double get value => props[_$key__value];  set value(double value) => props[_$key__value] = value;

  /// The min value of the [Progress] component.
  ///
  /// Default: `0.0`
  double get min => props[_$key__min];  set min(double value) => props[_$key__min] = value;

  /// The max value of the [Progress] component.
  ///
  /// Default: `100.0`
  double get max => props[_$key__max];  set max(double value) => props[_$key__max] = value;

  /// The skin / "context" for the [Progress] component.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/progress/#contextual-alternatives>.
  ///
  /// Default: [ProgressSkin.DEFAULT]
  ProgressSkin get skin => props[_$key__skin];  set skin(ProgressSkin value) => props[_$key__skin] = value;

  /// Whether to render a "Barber Pole" gradient stripe effect in the [Progress] component.
  ///
  /// Default: false
  bool get isStriped => props[_$key__isStriped];  set isStriped(bool value) => props[_$key__isStriped] = value;

  /// Whether to animate the "Barber Pole" gradient stripe effect in the [Progress] component.
  ///
  /// __Note:__ Has no effect if [isStriped] is `false`.
  ///
  /// Default: false
  bool get isAnimated => props[_$key__isAnimated];  set isAnimated(bool value) => props[_$key__isAnimated] = value;

  /// Optionally add a caption that describes the context of the [Progress] component.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/progress/#example>.
  ///
  /// Default: [ProgressComponent._getPercentComplete]%
  String get caption => props[_$key__caption];  set caption(String value) => props[_$key__caption] = value;

  /// Additional props to be added to the [caption] element _(if specified)_.
  Map get captionProps => props[_$key__captionProps];  set captionProps(Map value) => props[_$key__captionProps] = value;

  /// Whether the [caption] should be visible.
  ///
  /// Default: false
  bool get showCaption => props[_$key__showCaption];  set showCaption(bool value) => props[_$key__showCaption] = value;

  /// Whether the [caption] should be appended with the value of [value].
  ///
  /// Default: true
  bool get showPercentComplete => props[_$key__showPercentComplete];  set showPercentComplete(bool value) => props[_$key__showPercentComplete] = value;

  /// Additional props to be added to the [Dom.div] that wraps around the [caption] element and `<progress>` element.
  Map get rootNodeProps => props[_$key__rootNodeProps];  set rootNodeProps(Map value) => props[_$key__rootNodeProps] = value;
}

@State()
class ProgressState extends UiState {    /* GENERATED CONSTANTS */ static const StateDescriptor _$prop__id = const StateDescriptor(_$key__id); static const List<StateDescriptor> $state = const [_$prop__id]; static const String _$key__id = 'ProgressState.id'; static const List<String> $stateKeys = const [_$key__id]; 
  /// An autogenerated GUID, used as a fallback when [ProgressProps.id] is unspecified, and
  /// saved on the state so it will persist across remounts.
  ///
  /// HTML id attributes are needed on `<progress>` elements for proper accessibility support,
  /// so this state value ensures there's always a valid ID value to use.
  String get id => state[_$key__id];  set id(String value) => state[_$key__id] = value;
}

@Component()
class ProgressComponent extends UiStatefulComponent<ProgressProps, ProgressState> with _$ProgressComponentImplMixin {
  @override
  Map getDefaultProps() => (newProps()
    ..value = 0.0
    ..min = 0.0
    ..max = 100.0
    ..skin = ProgressSkin.DEFAULT
    ..isStriped = false
    ..isAnimated = false
    ..showCaption = false
    ..showPercentComplete = true
  );

  @override
  Map getInitialState() => (newState()
    ..id = 'progress_' + generateGuid(4)
  );

  @override
  render() {
    return (Dom.div()..addProps(props.rootNodeProps))(
      renderCaptionNode(),
      renderProgressNode(),
      props.children
    );
  }

  ReactElement renderProgressNode() {
    return (Dom.progress()
      ..addProps(copyUnconsumedDomProps())
      ..addProps(ariaProps()
        ..labelledby = captionId
      )
      ..className = _getProgressNodeClasses().toClassName()
      ..id = id
      ..value = currentValue
      ..max = props.max
    )();
  }

  ReactElement renderCaptionNode() {
    var captionClasses = new ClassNameBuilder.fromProps(props.captionProps)
      ..add('sr-only', !props.showCaption);

    var captionText = props.caption  ?? '';

    if (props.showPercentComplete) {
      captionText += ' ${_getPercentComplete()}%';
    }

    return (Dom.div()
      ..addProps(props.captionProps)
      ..id = captionId
      ..className = captionClasses.toClassName()
    )(captionText);
  }

  ClassNameBuilder _getProgressNodeClasses() {
    return new ClassNameBuilder()
      ..add('progress')
      ..add('progress-striped', props.isStriped)
      ..add('progress-animated', props.isAnimated)
      ..add(props.skin.className);
  }

  /// Get the percentage complete based on [ProgressProps.min], [ProgressProps.max] and [ProgressProps.value].
  double _getPercentComplete() {
    return (props.value - props.min) / (props.max - props.min) * 100;
  }

  /// Returns the value that determines the width of the progress bar
  /// within the rendered [Progress] component via [DomPropsMixin.value].
  ///
  /// Note that the value of the HTML `<progress>` element's value
  /// attribute will never be less than the value of [ProgressProps.min].
  double get currentValue => max(props.min, props.value);

  String get id => props.id ?? state.id;

  String get captionId => '${id}_caption';
}

/// Contextual skin options for a [Progress] component.
class ProgressSkin extends ClassNameConstant {
  const ProgressSkin._(String name, String className) : super(name, className);

  /// [className] value: ''
  static const ProgressSkin DEFAULT =
      const ProgressSkin._('DEFAULT', '');

  /// [className] value: 'progress-danger'
  static const ProgressSkin DANGER =
      const ProgressSkin._('DANGER', 'progress-danger');

  /// [className] value: 'progress-success'
  static const ProgressSkin SUCCESS =
      const ProgressSkin._('SUCCESS', 'progress-success');

  /// [className] value: 'progress-warning'
  static const ProgressSkin WARNING =
      const ProgressSkin._('WARNING', 'progress-warning');

  /// [className] value: 'progress-info'
  static const ProgressSkin INFO =
      const ProgressSkin._('INFO', 'progress-info');
}



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ProgressComponentFactory = registerComponent(() => new ProgressComponent(),
    builderFactory: Progress,
    componentClass: ProgressComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Progress'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$ProgressPropsImpl extends ProgressProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$ProgressPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $ProgressComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ProgressProps.';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$ProgressStateImpl extends ProgressState {
  /// The backing state map proxied by this class.
  @override
  final Map state;

  _$ProgressStateImpl(Map backingMap) : this.state = backingMap ?? ({});

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ProgressComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ProgressProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [ProgressProps.$consumedProps];
  @override
  ProgressProps typedPropsFactory(Map backingMap) => new _$ProgressPropsImpl(backingMap);
  @override
  ProgressState typedStateFactory(Map backingMap) => new _$ProgressStateImpl(backingMap);
}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

