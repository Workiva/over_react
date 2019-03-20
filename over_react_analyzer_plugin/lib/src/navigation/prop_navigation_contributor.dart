import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as protocol;
import 'package:analyzer_plugin/utilities/navigation/navigation.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

/// Provides navigation regions from props to their non-generated definitions.
///
/// NOTE: when developing in JetBrains IDEs, clear caches after reloading this
/// plugin, or it may not request the latest navigation regions from this plugin.
class PropNavigationContributor implements NavigationContributor {
  @override
  void computeNavigation(NavigationRequest request, NavigationCollector collector) {
    if (request is DartNavigationRequest) {

      final lineInfo = request.result.unit.lineInfo;

      // TODO also visit usages of props outside of fluent interface (e.g., within components, in MapViews, etc,)?
      var astVisitor = new ComponentUsageVisitor((usage) {
        // TODO potentially implement caching if this is slow
        final type = usage.builder.staticType;
        if (type is InterfaceType) {
          forEachCascadedProp(usage, (lhs, rhs) {
            final propName = lhs.propertyName.name;

            Element nonSyntheticTarget;
            protocol.ElementKind targetKind;
            {
              PropertyAccessorElement target;
              // todo can we rely on this traversing types upwards?
              for (var type in type.element.allSupertypes) {
                if (!type.element.source.fullName.endsWith('.g.dart')) {
                  target = type.getGetter(propName);
                }
              }
              if (target != null) {
                if (!target.isSynthetic) {
                  // Getter
                  nonSyntheticTarget = target;
                  targetKind = protocol.ElementKind.GETTER;
                } else if (!target.variable.isSynthetic) { // todo is this check needed?
                  // Getter declared synthetically via field
                  nonSyntheticTarget = target.variable;
                  targetKind = protocol.ElementKind.FIELD;
                }
              }
            }

            if (nonSyntheticTarget != null) {
              final offset = nonSyntheticTarget.nameOffset;
              final length = nonSyntheticTarget.nameLength;

              final location = lineInfo.getLocation(offset);
              collector.addRegion(
                lhs.propertyName.offset,
                lhs.propertyName.length,
                targetKind,
                new protocol.Location(
                  nonSyntheticTarget.source.fullName,
                  offset,
                  length,
                  location.lineNumber,
                  location.columnNumber,
                ),
              );
            }
          });
        } {
          // TODO TypeParameterType
        }
      });

      request.result.unit.accept(astVisitor);
    }
  }
}
