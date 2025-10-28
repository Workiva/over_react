import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/map_util.dart';

// ============================================================================
// Benchmark Configuration
// ============================================================================

/// Configuration for a forwardUnconsumedPropsV2 benchmark.
class BenchmarkConfig {
  final String name;
  final int propsCount;
  final int keysToOmitCount;
  final int keySetsCount;
  final int keysPerSetCount;
  final bool omitReactProps;
  final bool onlyCopyDomProps;
  final Map Function()? customPropsGenerator;

  BenchmarkConfig({
    required this.name,
    required this.propsCount,
    this.keysToOmitCount = 0,
    this.keySetsCount = 0,
    this.keysPerSetCount = 0,
    this.omitReactProps = true,
    this.onlyCopyDomProps = false,
    this.customPropsGenerator,
  });
}

/// Configurable benchmark for forwardUnconsumedPropsV2.
class ForwardUnconsumedPropsBenchmark extends BenchmarkBase {
  final BenchmarkConfig config;

  ForwardUnconsumedPropsBenchmark(this.config) : super(config.name);

  late Map props;
  late Map propsToUpdate;
  List<String>? keysToOmit;
  List<List<String>>? keySetsToOmit;

  @override
  void setup() {
    // Generate props using custom generator or default
    if (config.customPropsGenerator != null) {
      props = config.customPropsGenerator!();
    } else {
      props = JsBackedMap();
      for (var i = 0; i < config.propsCount; i++) {
        props['prop$i'] = 'value$i';
      }
    }

    // Generate keys to omit
    if (config.keysToOmitCount > 0) {
      keysToOmit = [];
      final propKeys = props.keys.toList();
      for (var i = 0; i < config.keysToOmitCount && i < propKeys.length; i++) {
        // Distribute omissions evenly across the props
        final index = (i * propKeys.length / config.keysToOmitCount).floor();
        keysToOmit!.add(propKeys[index].toString());
      }
    }

    // Generate key sets to omit
    if (config.keySetsCount > 0 && config.keysPerSetCount > 0) {
      keySetsToOmit = [];
      final propKeys = props.keys.toList();

      for (var setIdx = 0; setIdx < config.keySetsCount; setIdx++) {
        final keySet = <String>[];
        for (var keyIdx = 0; keyIdx < config.keysPerSetCount && propKeys.isNotEmpty; keyIdx++) {
          // Distribute keys across different regions of the prop list
          final baseIndex = (setIdx * config.keysPerSetCount + keyIdx) % propKeys.length;
          keySet.add(propKeys[baseIndex].toString());
        }
        keySetsToOmit!.add(keySet);
      }
    }
  }

  @override
  void run() {
    propsToUpdate = {};
    forwardUnconsumedPropsV2(
      props,
      omitReactProps: config.omitReactProps,
      onlyCopyDomProps: config.onlyCopyDomProps,
      keysToOmit: keysToOmit,
      keySetsToOmit: keySetsToOmit,
      propsToUpdate: propsToUpdate,
    );
  }
}

// ============================================================================
// Custom Props Generators
// ============================================================================

Map _generateDomProps() {
  return JsBackedMap()
    ..addAll({
      // Valid DOM props
      'id': 'test-id',
      'className': 'test-class',
      'title': 'Test Title',
      'style': {'color': 'red'},
      'onClick': () {},
      'aria-label': 'Test Label',
      'data-test': 'test-value',
      // Non-DOM props (should be filtered out)
      'customProp1': 'custom1',
      'customProp2': 'custom2',
      'customProp3': 'custom3',
      'onCustomEvent': () {},
    });
}

Map _generateDomPropsWithMany() {
  final props = _generateDomProps();
  // Add more props
  for (var i = 0; i < 40; i++) {
    props['customProp${i + 10}'] = 'value$i';
  }
  return props;
}

Map _generateReactProps() {
  return JsBackedMap()
    ..addAll({
      'key': 'test-key',
      'ref': 'test-ref',
      'children': ['child1', 'child2'],
      'prop1': 'value1',
      'prop2': 'value2',
      'prop3': 'value3',
      'prop4': 'value4',
      'prop5': 'value5',
    });
}

// ============================================================================
// Benchmark Configurations
// ============================================================================

final benchmarkConfigs = [
  // Small props map (10 props)
  BenchmarkConfig(name: 'SmallPropsNoOmit', propsCount: 10),
  BenchmarkConfig(name: 'SmallPropsFewOmit', propsCount: 10, keysToOmitCount: 3),
  BenchmarkConfig(name: 'SmallPropsManyOmit', propsCount: 10, keysToOmitCount: 7),

  // Medium props map (50 props)
  BenchmarkConfig(name: 'MediumPropsNoOmit', propsCount: 50),
  BenchmarkConfig(name: 'MediumPropsFewOmit', propsCount: 50, keysToOmitCount: 5),
  BenchmarkConfig(name: 'MediumPropsManyOmit', propsCount: 50, keysToOmitCount: 30),

  // Large props map (200 props)
  BenchmarkConfig(name: 'LargePropsNoOmit', propsCount: 200),
  BenchmarkConfig(name: 'LargePropsFewOmit', propsCount: 200, keysToOmitCount: 10),
  BenchmarkConfig(name: 'LargePropsManyOmit', propsCount: 200, keysToOmitCount: 100),

  // DOM props filtering
  BenchmarkConfig(
    name: 'DomPropsOnly',
    propsCount: 12, // Will be overridden by customPropsGenerator
    onlyCopyDomProps: true,
    customPropsGenerator: _generateDomProps,
  ),
  BenchmarkConfig(
    name: 'DomPropsOnlyFewOmit',
    propsCount: 50, // Will be overridden by customPropsGenerator
    keysToOmitCount: 3,
    onlyCopyDomProps: true,
    customPropsGenerator: _generateDomPropsWithMany,
  ),

  // React props omission
  BenchmarkConfig(
    name: 'ReactPropsOmission',
    propsCount: 8, // Will be overridden by customPropsGenerator
    omitReactProps: true,
    customPropsGenerator: _generateReactProps,
  ),
  BenchmarkConfig(
    name: 'ReactPropsNotOmitted',
    propsCount: 8, // Will be overridden by customPropsGenerator
    omitReactProps: false,
    customPropsGenerator: _generateReactProps,
  ),

  // Edge cases
  BenchmarkConfig(name: 'AllPropsOmitted', propsCount: 50, keysToOmitCount: 50),
  BenchmarkConfig(name: 'EmptyProps', propsCount: 0),

  // KeySets: Few keysets, few keys per set (2 sets, 3 keys each)
  BenchmarkConfig(
    name: 'KeySetsFewSetsFewKeys',
    propsCount: 50,
    keySetsCount: 2,
    keysPerSetCount: 3,
  ),

  // KeySets: Few keysets, many keys per set (2 sets, 15 keys each)
  BenchmarkConfig(
    name: 'KeySetsFewSetsManyKeys',
    propsCount: 50,
    keySetsCount: 2,
    keysPerSetCount: 15,
  ),

  // KeySets: Many keysets, few keys per set (10 sets, 3 keys each)
  BenchmarkConfig(
    name: 'KeySetsManySets_FewKeys',
    propsCount: 50,
    keySetsCount: 10,
    keysPerSetCount: 3,
  ),

  // KeySets: Many keysets, many keys per set (10 sets, 10 keys each)
  BenchmarkConfig(
    name: 'KeySetsManySets_ManyKeys',
    propsCount: 100,
    keySetsCount: 10,
    keysPerSetCount: 10,
  ),

  // KeySets with large props map: Few keysets, few keys per set
  BenchmarkConfig(
    name: 'KeySetsLargePropsFewSetsFewKeys',
    propsCount: 200,
    keySetsCount: 3,
    keysPerSetCount: 5,
  ),

  // KeySets with large props map: Many keysets, many keys per set
  BenchmarkConfig(
    name: 'KeySetsLargePropsManySets_ManyKeys',
    propsCount: 200,
    keySetsCount: 15,
    keysPerSetCount: 12,
  ),
];

// ============================================================================
// Main runner
// ============================================================================

void main() {
  print('Running forwardUnconsumedPropsV2 benchmarks...\n');

  // Group benchmarks by category
  final smallConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Small')).toList();
  final mediumConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Medium')).toList();
  final largeConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Large')).toList();
  final domConfigs = benchmarkConfigs.where((c) => c.name.startsWith('Dom')).toList();
  final reactConfigs = benchmarkConfigs.where((c) => c.name.startsWith('React')).toList();
  final keySetsConfigs = benchmarkConfigs.where((c) => c.name.startsWith('KeySets')).toList();
  final edgeConfigs =
      benchmarkConfigs.where((c) => c.name == 'AllPropsOmitted' || c.name == 'EmptyProps').toList();

  print('=== Small Props Map (10 props) ===');
  for (final config in smallConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Medium Props Map (50 props) ===');
  for (final config in mediumConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Large Props Map (200 props) ===');
  for (final config in largeConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== DOM Props Filtering ===');
  for (final config in domConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== React Props Omission ===');
  for (final config in reactConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== KeySets To Omit ===');
  for (final config in keySetsConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }

  print('\n=== Edge Cases ===');
  for (final config in edgeConfigs) {
    ForwardUnconsumedPropsBenchmark(config).report();
  }
}
