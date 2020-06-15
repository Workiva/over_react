import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension ReactTypes$DartType on DartType {
  bool get isComponentClass => element.isComponentClass;
  bool get isReactElement => element.isReactElement;
  bool get isPropsClass => element.isPropsClass;
}


extension ReactTypes$Element on Element/*?*/ {
  bool get isComponentClass => isOrIsSubtypeOfTypeFromPackage('Component', 'react');
  bool get isReactElement => isOrIsSubtypeOfTypeFromPackage('ReactElement', 'react');
  bool get isPropsClass => isOrIsSubtypeOfTypeFromPackage('UiProps', 'over_react');
}

/// Adapted from https://github.com/dart-lang/sdk/blob/279024d823707f1f4d5edc05c374ca813edbd73e/pkg/analysis_server/lib/src/utilities/flutter.dart#L279
extension on Element /*?*/ {
  bool isOrIsSubtypeOfTypeFromPackage(String typeName, String packageName) {
    final that = this;
    return that is ClassElement &&
        (that.isTypeFromPackage(typeName, packageName) ||
            that.allSupertypes.any((type) => type.element.isTypeFromPackage(typeName, packageName)));
  }

  bool isTypeFromPackage(String typeName, String packageName) =>
      this?.name == typeName && isDeclaredInPackage(packageName);
}

extension on Element {
  bool isDeclaredInPackage(String packageName) => isUriWithinPackage(source.uri, packageName);
}

bool isUriWithinPackage(Uri uri, String packageName) =>
    uri.isScheme('package') && uri.pathSegments.isNotEmpty && uri.pathSegments[0] == packageName;
