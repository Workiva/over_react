// Copyright 2022 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart' as cu;
import 'package:over_react_analyzer_plugin/src/diagnostic/style_value_diagnostic.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:over_react_analyzer_plugin/src/over_react_builder_parsing.dart' as orbp;
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:source_span/source_span.dart';
import 'package:path/path.dart' as p;

import 'package_info.dart';

Future<void> main(List<String> args) async {
  final argParser = ArgParser()..addMultiOption('ignore-package')..addMultiOption('ignore-component');

  final parsed = argParser.parse(args);
  final componentIgnorePatterns = (parsed['ignore-component'] as List<String>).map((p) => RegExp(p));
  final packageIgnorePatterns = (parsed['ignore-package'] as List<String>).map((p) => RegExp(p));

  final paths = [...parsed.rest];
  if (paths.isEmpty) paths.add('lib');

  // GraphViz reference: https://graphviz.org/doc/info/lang.html
  final dotNodeLinesById = <String, String>{};
  final dotEdgeLines = <String>[];

  await for (final tuple in getUnits(paths)) {
    final unitResult = tuple.item1;
    for (final usage in processUnit(unitResult, tuple.item2)) {
      if (usage.component.label == 'Block' ||
          usage.component.label == 'VBlock' ||
          usage.component.label == 'ErrorBoundary') {
        continue;
      }
      if (componentIgnorePatterns.any((p) => p.hasMatch(usage.component.label))) {
        continue;
      }
      if (componentIgnorePatterns.any((p) => p.hasMatch(usage.owner.label))) {
        continue;
      }
      {
        final uri = usage.component.tryCast<ResolvedComponentReference>()?.factory.source?.uri;
        final packageName = uri == null ? null : getPackageName(uri);
        if (packageName != null && packageIgnorePatterns.any((p) => p.hasMatch(packageName))) {
          continue;
        }
      }

      dotEdgeLines.add([
        // TODO sanitize IDs here instead?
        '${usage.owner.id} -> ${usage.component.id}',
        '[penwidth=2.0]',
        if (usage.location.url != null) ...[
          '[color="#0f4cc5"]',
          '[URL=${stringLiteral(usage.location.url, useSingleQuote: false)}]',
        ],
      ].join(' '));
      void addNodeForReference(Node node) {
        dotNodeLinesById.putIfAbsent(node.id, () {
          return [
            '${node.id}',
            ' [label=${stringLiteral(node.label, useSingleQuote: false)}]',
            ' [shape=${node.shape}]',
            // ' [URL=${stringLiteral(node.url, useSingleQuote: false)}]',
          ].join(' ');
        });
      }

      addNodeForReference(usage.owner);
      addNodeForReference(usage.component);
    }
  }

  File('react_component_graph.dot').writeAsStringSync([
    'digraph {\n',
    ...dotNodeLinesById.values,
    ...dotEdgeLines,
    '\n}',
  ].join('\n'));

  print('Done');
}

Stream<Tuple2<ResolvedUnitResult, ScrapedPackageInfo?>> getUnits(List<String> paths) async* {
  paths = paths.map(p.canonicalize).toList();

  final contextCollection = AnalysisContextCollection(
    includedPaths: paths,
  );

  print('Starting to resolve files...');
  final dartFiles = paths.expand((path) => Glob('**.dart').listSync(root: path, followLinks: false));
  for (final file in dartFiles) {
    print('- ${p.relative(file.path)}');
    final filePath = p.normalize(p.absolute(file.path));
    final context = contextCollection.contextFor(filePath);
    final unitResult = await context.currentSession.getResolvedUnit2(filePath);
    if (unitResult is ResolvedUnitResult) {
      yield Tuple2(
          unitResult, scrapePackageInfoForUriFromContextRoot(unitResult.uri, context.contextRoot.workspace.root));
    } else {
      throw Exception('Invalid result: $unitResult');
    }
  }
}

Iterable<Usage> processUnit(ResolvedUnitResult result, ScrapedPackageInfo? packageInfo) sync* {
  late final componentDeclarations = orbp.parseDeclarations(
      result.unit,
      // TODO make a noop ErrorCollector
      orbp.ErrorCollector.callback(SourceFile.fromString(result.content!)));

  late final classComponentDeclarations = componentDeclarations.whereType<orbp.ClassComponentDeclaration>().toList();

  orbp.ClassComponentDeclaration? getClosestClassComponent(AstNode node) =>
      classComponentDeclarations.firstWhereOrNull((d) => d.component.node.containsRangeOf(node));

  for (final usage in cu.getAllComponentUsages(result.unit!)) {
    if (usage.isDom || usage.isFragment) continue;

    Node getOwner() {
      {
        final closestFunctionComponent = getClosestFunctionComponent(usage.node);
        if (closestFunctionComponent != null) {
          final factoryElement = closestFunctionComponent.factoryVariable?.declaredElement;
          return factoryElement != null
              ? ResolvedComponentReference(factory: factoryElement)
              : UnresolvableComponentReference(
                  closestFunctionComponent.factoryName?.toSource() ?? closestFunctionComponent.body.toSource(),
                );
        }
      }
      {
        final closestClassComponent = getClosestClassComponent(usage.node);
        if (closestClassComponent != null) {
          final factoryElement = closestClassComponent.factory.node.firstVariable.declaredElement;
          return factoryElement != null
              ? ResolvedComponentReference(factory: factoryElement)
              : UnresolvableComponentReference(
                  (closestClassComponent.factory?.name.name ?? closestClassComponent.component?.name.name)!,
                );
        }
      }
      final closestClassElement =
          usage.node.thisOrAncestorOfType<CompilationUnitMember>()?.declaredElement?.tryCast<ClassElement>();
      if (closestClassElement != null) {
        final closestMember = usage.node.thisOrAncestorOfType<ClassMember>()?.declaredElement;
        return NonComponentClassOwner(closestClassElement, closestMember.tryCast());
      }

      return OtherOwner.fromNode(usage.node);
    }

    var factoryElement = usage.factoryTopLevelVariableElement;
    // If it's not a factory, it might be a builder variable.
    //   var builder = Foo()..bar;
    //   return builder();
    // Try to get the factory from the builder initializer.
    // TODO use propsType reference instead?
    if (factoryElement == null && usage.factory == null) {
      final builder = usage.builder;
      if (builder is Identifier) {
        final initializer = lookUpVariable(builder.staticElement, builder.root)?.initializer;
        if (initializer != null) {
          final builderInInitializer = initializer.unParenthesized.tryCast<CascadeExpression>()?.target;
          final factory = builderInInitializer.tryCast<InvocationExpression>()?.function;
          if (factory is Identifier) {
            final staticElement = factory.staticElement;
            VariableElement? variable;
            if (staticElement is VariableElement) {
              variable = staticElement;
            } else if (staticElement is PropertyAccessorElement) {
              variable = staticElement.variable;
            }
            if (variable is TopLevelVariableElement) {
              factoryElement = variable;
            }
          }
        }
      }
    }

    final location = result.lineInfo.getLocation(usage.node.offset);
    yield Usage(
      component: factoryElement != null
          ? ResolvedComponentReference(factory: factoryElement)
          : UnresolvableComponentReference(usage.builder.toSource()),
      usageType: UsageType.render,
      // destination: getDestinationOfExpression(usage.node, context),
      owner: getOwner(),
      location: SourceLocation(result.uri, location.lineNumber, location.columnNumber,
          uriAsLink(packageInfo, result.uri, lineNumber: location.lineNumber)),
    );
  }
}

Destination? getDestinationOfExpression(InvocationExpression node, Context context) {}

class Usage {
  final ComponentReference component;
  final UsageType usageType;

  // FIXME make non-nullable, implement
  final Destination? destination;
  final Node owner;
  final SourceLocation location;

  Usage({
    required this.component,
    required this.usageType,
    this.destination,
    required this.owner,
    required this.location,
  });
}

class SourceLocation {
  final Uri uri;

  /// The one-based index of the line.
  final int lineNumber;

  /// The one-based index of the column.
  final int columnNumber;

  final String? url;

  SourceLocation(this.uri, this.lineNumber, this.columnNumber, this.url);
}

class Context {
  // final Map<TopLevelVariableElement, ResolvedComponent> componentsByFactory;
  //
  // Context(this.componentsByFactory);
  //
  // ResolvedComponent? lookUpComponentFromFluentUsage(cu.FluentComponentUsage usage) {
  //   final element = usage.factoryTopLevelVariableElement;
  //   return element == null ? null : lookUpComponentFromFactoryElement(element);
  // }
  //
  // ResolvedComponent? lookUpComponentFromFactoryElement(VariableElement factoryVariableElement) =>
  //     componentsByFactory[factoryVariableElement];
}

abstract class Node {
  String get id;

  String get label;

  String get shape;
//
// Uri get uri;
}

mixin ElementBasedNode on Node {
  Element get element;

  @override
  String get id => elementId(element);

  @override
  String get label => element.name!;

  @override
  String get shape => getShapeForElement(element);

  Uri? get uri => element.source?.uri;
}

mixin MaybeElementBasedNode on Node {
  Element? get element;

  String get fallbackId;

  String get fallbackName;

  @override
  String get id => element == null ? sanitizeId(fallbackId) : elementId(element!);

  @override
  String get label => fallbackName;

  @override
  String get shape => element == null ? 'box' : getShapeForElement(element!);

  Uri? get uri => element?.source?.uri;
}

String getShapeForElement(Element e) {
  if (e is TopLevelVariableElement) return 'ellipse';
  if (e is ClassElement) return 'box';
  if (e is ExecutableElement) return 'cds';

  return 'box';
}

abstract class Owner implements Node {
// @override
// Uri? get uri => element?.source.uri;
}

class NonComponentClassOwner extends Owner with ElementBasedNode {
  @override
  final ClassElement element;
  final ClassMemberElement? member;

  NonComponentClassOwner(this.element, this.member);
}

// class TopLevelFunctionOwner extends Owner {
//   final FunctionElement functionElement;
//
//   TopLevelFunctionOwner(this.functionElement);
// }

class OtherOwner extends Owner with MaybeElementBasedNode {
  @override
  final Element? element;
  final String description;

  OtherOwner(this.element, this.description);

  factory OtherOwner.fromNode(AstNode node) {
    Element? closestResolvedElement;
    final description = node.toSource() +
        ' > ' +
        node.ancestors
            .map<String?>((e) {
              if (e is FunctionDeclaration) {
                closestResolvedElement ??= e.declaredElement;
                return e.name.name;
              }
              if (e is VariableDeclaration) {
                closestResolvedElement ??= e.declaredElement;
                return e.name.name;
              }
              if (e is NamedCompilationUnitMember) {
                closestResolvedElement ??= e.declaredElement;
                return e.name.name;
              }
              return null;
            })
            .whereNotNull()
            .toList()
            .reversed
            .join(' > ');
    return OtherOwner(closestResolvedElement, description);
  }

  // FIXME use a counter here, or maybe something else unique like source location.
  @override
  String get fallbackId => 'other__$description';

  @override
  String get fallbackName => description;
}

abstract class ComponentReference implements Node {}

String sanitizeId(String id) {
  var sanitized = id.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
  if (sanitized.startsWith(RegExp('r\d'))) {
    sanitized = '_$sanitized';
  }
  return sanitized;
}

String elementId(Element e) => sanitizeId('${e.name}_${e.id}');

class ResolvedComponentReference extends ComponentReference with ElementBasedNode {
  final VariableElement factory;

  ResolvedComponentReference({required this.factory});

  @override
  Element get element => factory;
}

class UnresolvableComponentReference extends ComponentReference {
  static int _unresolvedReferenceCounter = 0;

  final int _unresolvedReferenceId;

  final String builder;

  UnresolvableComponentReference(this.builder) : _unresolvedReferenceId = _unresolvedReferenceCounter++;

  @override
  String get id => sanitizeId('${builder}_unresolved_$_unresolvedReferenceId');

  @override
  String get label => '(Unresolved) $builder';

  @override
  String get shape => 'ellipse';
}

abstract class Destination {}

class OtherDestination extends Destination {}

class RenderReturnDestination extends Destination {}

class PropDestination extends Destination {
  final ComponentReference component;
  final String propName;

  PropDestination(this.component, this.propName);

  PropDestination.children(this.component) : propName = 'children';

  bool get isChildren => propName == 'children';
}

enum UsageType {
  render,
  mapView,
  props,
}

class PackageUriToPermalinkConverter {
  /// This implementation may change to be non-static-const, so make it an instance
  /// field from the get-go.
  final packageToRepoLookup = const <String, String>{
    'cerebral_ui': 'cerebral-ui',
    'copy_ui': 'copy-ui',
    'dart_permissions_editor': 'dart-permissions-editor',
    'tasker': 'tasker-ui',
    'w_sox': 'graph_app',
    'xbrl_module': 'xbrl-module',
  };
}
