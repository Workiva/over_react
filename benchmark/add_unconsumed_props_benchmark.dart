import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:over_react/over_react.dart' as over_react;

// ============================================================================
// Benchmark Configuration
// ============================================================================

/// Configuration for an addUnconsumedProps benchmark.
class BenchmarkConfig {
  final String name;
  final int propsCount;
  final int keysToOmitCount;
  final int keySetsCount;
  final int keysPerSetCount;
  final Map Function()? customPropsGenerator;

  BenchmarkConfig({
    required this.name,
    required this.propsCount,
    this.keysToOmitCount = 0,
    this.keySetsCount = 0,
    this.keysPerSetCount = 0,
    this.customPropsGenerator,
  });
}

/// Configurable benchmark for addUnconsumedProps.
class AddUnconsumedPropsBenchmark extends BenchmarkBase {
  final BenchmarkConfig config;

  AddUnconsumedPropsBenchmark(this.config) : super(config.name);

  late TestComponent2Component component;
  late Map propsToUpdate;

  @override
  void setup() {
    // Generate props using custom generator or default
    Map componentProps;
    if (config.customPropsGenerator != null) {
      componentProps = config.customPropsGenerator!();
    } else {
      componentProps = over_react.JsBackedMap();
      for (var i = 0; i < config.propsCount; i++) {
        componentProps['prop$i'] = 'value$i';
      }
    }

    // Generate consumed props based on configuration
    List<over_react.ConsumedProps>? consumedPropsList;
    
    // Single set of keys to omit
    if (config.keysToOmitCount > 0) {
      final keysToOmit = <String>[];
      final propKeys = componentProps.keys.toList();
      for (var i = 0; i < config.keysToOmitCount && i < propKeys.length; i++) {
        // Distribute omissions evenly across the props
        final index = (i * propKeys.length / config.keysToOmitCount).floor();
        keysToOmit.add(propKeys[index].toString());
      }
      consumedPropsList = [over_react.ConsumedProps([], keysToOmit)];
    }

    // Multiple key sets to omit
    if (config.keySetsCount > 0 && config.keysPerSetCount > 0) {
      consumedPropsList = [];
      final propKeys = componentProps.keys.toList();

      for (var setIdx = 0; setIdx < config.keySetsCount; setIdx++) {
        final keySet = <String>[];
        for (var keyIdx = 0; keyIdx < config.keysPerSetCount && propKeys.isNotEmpty; keyIdx++) {
          // Distribute keys across different regions of the prop list
          final baseIndex = (setIdx * config.keysPerSetCount + keyIdx) % propKeys.length;
          keySet.add(propKeys[baseIndex].toString());
        }
        consumedPropsList.add(over_react.ConsumedProps([], keySet));
      }
    }

    component = TestComponent2Component(testConsumedProps: consumedPropsList);

    // Set the component's props
    component.props = componentProps;
  }

  @override
  void run() {
    propsToUpdate = over_react.JsBackedMap();
    component.addUnconsumedProps(propsToUpdate);
  }
}

// ============================================================================
// Custom Props Generators
// ============================================================================

Map _generateMixedProps() {
  return over_react.JsBackedMap()
    ..addAll({
      // Mix of different prop types
      'id': 'test-id',
      'className': 'test-class',
      'title': 'Test Title',
      'style': {'color': 'red'},
      'onClick': () {},
      'aria-label': 'Test Label',
      'data-test': 'test-value',
      'customProp1': 'custom1',
      'customProp2': 'custom2',
      'customProp3': 'custom3',
      'onCustomEvent': () {},
    });
}

Map _generateManyMixedProps() {
  final props = _generateMixedProps();
  // Add more props
  for (var i = 0; i < 40; i++) {
    props['customProp${i + 10}'] = 'value$i';
  }
  return props;
}

// ============================================================================
// Benchmark Configurations
// ============================================================================

final benchmarkConfigs = [
  // Small props map (10 props) - single consumed prop set
  BenchmarkConfig(name: 'SmallPropsNoConsumed', propsCount: 10),
  BenchmarkConfig(name: 'SmallPropsFewConsumed', propsCount: 10, keysToOmitCount: 3),
  BenchmarkConfig(name: 'SmallPropsManyConsumed', propsCount: 10, keysToOmitCount: 7),

  // Medium props map (50 props) - single consumed prop set
  BenchmarkConfig(name: 'MediumPropsNoConsumed', propsCount: 50),
  BenchmarkConfig(name: 'MediumPropsFewConsumed', propsCount: 50, keysToOmitCount: 5),
  BenchmarkConfig(name: 'MediumPropsManyConsumed', propsCount: 50, keysToOmitCount: 30),

  // Large props map (200 props) - single consumed prop set
  BenchmarkConfig(name: 'LargePropsNoConsumed', propsCount: 200),
  BenchmarkConfig(name: 'LargePropsFewConsumed', propsCount: 200, keysToOmitCount: 10),
  BenchmarkConfig(name: 'LargePropsManyConsumed', propsCount: 200, keysToOmitCount: 100),

  // Mixed prop types (realistic scenario)
  BenchmarkConfig(
    name: 'MixedPropsFewConsumed',
    propsCount: 12, // Will be overridden by customPropsGenerator
    keysToOmitCount: 3,
    customPropsGenerator: _generateMixedProps,
  ),
  BenchmarkConfig(
    name: 'MixedPropsManyConsumed',
    propsCount: 50, // Will be overridden by customPropsGenerator
    keysToOmitCount: 10,
    customPropsGenerator: _generateManyMixedProps,
  ),

  // Edge cases
  BenchmarkConfig(name: 'AllPropsConsumed', propsCount: 50, keysToOmitCount: 50),
  BenchmarkConfig(name: 'EmptyProps', propsCount: 0),

  // ConsumedProps (keySets): Few prop mixins, few keys per mixin (2 mixins, 3 keys each)
  BenchmarkConfig(
    name: 'ConsumedPropsFewMixinsFewKeys',
    propsCount: 50,
    keySetsCount: 2,
    keysPerSetCount: 3,
  ),

  // ConsumedProps (keySets): Few prop mixins, many keys per mixin (2 mixins, 15 keys each)
  BenchmarkConfig(
    name: 'ConsumedPropsFewMixinsManyKeys',
    propsCount: 50,
    keySetsCount: 2,
    keysPerSetCount: 15,
  ),

  // ConsumedProps (keySets): Many prop mixins, few keys per mixin (10 mixins, 3 keys each)
  BenchmarkConfig(
    name: 'ConsumedPropsManyMixinsFewKeys',
    propsCount: 50,
    keySetsCount: 10,
    keysPerSetCount: 3,
  ),

  // ConsumedProps (keySets): Many prop mixins, many keys per mixin (10 mixins, 10 keys each)
  BenchmarkConfig(
    name: 'ConsumedPropsManyMixinsManyKeys',
    propsCount: 100,
    keySetsCount: 10,
    keysPerSetCount: 10,
  ),

  // ConsumedProps with large props map: Few mixins, few keys per mixin
  BenchmarkConfig(
    name: 'ConsumedPropsLargePropsFewMixinsFewKeys',
    propsCount: 200,
    keySetsCount: 3,
    keysPerSetCount: 5,
  ),

  // ConsumedProps with large props map: Many mixins, many keys per mixin
  BenchmarkConfig(
    name: 'ConsumedPropsLargePropsManyMixinsManyKeys',
    propsCount: 200,
    keySetsCount: 15,
    keysPerSetCount: 12,
  ),
];

// ============================================================================
// Main runner
// ============================================================================

void main() {
  print('Running addUnconsumedProps benchmarks...\n');

  // Group benchmarks by category
  final smallConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Small')).toList();
  final mediumConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Medium')).toList();
  final largeConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Large')).toList();
  final mixedConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Mixed')).toList();
  final consumedPropsConfigs = benchmarkConfigs.where((c) => c.name.startsWith('ConsumedProps')).toList();
  final edgeConfigs =
      benchmarkConfigs.where((c) => c.name == 'AllPropsConsumed' || c.name == 'EmptyProps').toList();

  print('=== Small Props Map (10 props) ===');
  for (final config in smallConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Medium Props Map (50 props) ===');
  for (final config in mediumConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Large Props Map (200 props) ===');
  for (final config in largeConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Mixed Props (Realistic Scenario) ===');
  for (final config in mixedConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Multiple Consumed Props (Prop Mixins) ===');
  for (final config in consumedPropsConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Edge Cases ===');
  for (final config in edgeConfigs) {
    AddUnconsumedPropsBenchmark(config).report();
  }
}

over_react.UiFactory<TestComponentProps> TestComponent = ([props]) => TestComponentProps(props);

class TestComponentProps extends over_react.UiProps {
  @override final over_react.ReactComponentFactoryProxy componentFactory = _TestComponentComponentFactory;
  @override final Map props;

  TestComponentProps([Map? props]) : this.props = props ?? ({});
}

final _TestComponentComponentFactory = over_react.registerComponent(() => TestComponentComponent());
class TestComponentComponent extends over_react.UiComponent<TestComponentProps> {
  @override
  final List<over_react.ConsumedProps>? consumedProps;

  TestComponentComponent({List<over_react.ConsumedProps>? testConsumedProps}) : consumedProps = testConsumedProps;

  @override
  render() => (over_react.Dom.div()..ref = 'foo')();

  @override
  TestComponentProps typedPropsFactory(Map propsMap) => TestComponentProps(propsMap);

  @override
  void validateProps(Map appliedProps) {
    super.validateProps(appliedProps);

    if (props['onValidateProps'] != null) props['onValidateProps'](appliedProps);
  }
}

over_react.UiFactory<TestComponent2Props> TestComponent2 = ([props]) => TestComponent2Props(props as over_react.JsBackedMap?);

class TestComponent2Props extends over_react.UiProps {
  @override final over_react.ReactComponentFactoryProxy componentFactory = TestComponent2ComponentFactory;
  TestComponent2Props(over_react.JsBackedMap? backingMap)
      : this._props = over_react.JsBackedMap() {
    this._props = backingMap ?? over_react.JsBackedMap();
  }

  @override
  over_react.JsBackedMap get props => _props;
  over_react.JsBackedMap _props;

  @override
  bool get $isClassGenerated => true;

  @override
  String? get propKeyNamespace => null;
}

final TestComponent2ComponentFactory = over_react.registerComponent2(() => TestComponent2Component());
class TestComponent2Component extends over_react.UiComponent2<TestComponent2Props> {
  @override
  final List<over_react.ConsumedProps>? consumedProps;

  late TestComponent2Props _props;

  @override
  TestComponent2Props get props => _props;

  @override
  set props(Map value) => _props = typedPropsFactory(value);

  TestComponent2Component({List<over_react.ConsumedProps>? testConsumedProps}) :
        consumedProps = testConsumedProps;

  @override
  render() => (over_react.Dom.div()..ref = 'foo')();

  @override
  TestComponent2Props typedPropsFactory(Map propsMap) => TestComponent2Props(propsMap as over_react.JsBackedMap);

  @override
  TestComponent2Props typedPropsFactoryJs(Map propsMap) => TestComponent2Props(propsMap as over_react.JsBackedMap);
}

