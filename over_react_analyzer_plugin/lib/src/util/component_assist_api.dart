import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:source_span/source_span.dart';

// ignore_for_file: implementation_imports
import 'package:over_react/src/builder/parsing/declarations.dart';
import 'package:over_react/src/builder/parsing/declarations_from_members.dart';
import 'package:over_react/src/builder/parsing/error_collection.dart';
import 'package:over_react/src/builder/parsing/member_association.dart';
import 'package:over_react/src/builder/parsing/members.dart';
import 'package:over_react/src/builder/parsing/members_from_ast.dart';
import 'package:over_react/src/builder/parsing/version.dart';

/// A mixin that allows easy access to common APIs needed when writing assists
/// that manipulate component boilerplate.
///
/// Important Usage Guidelines:
/// 1. Only to be used to identify new boilerplate components. Future work may be
/// able to change this to be more version agnostic, but currently its usage is
/// tailored to be for the new boilerplate syntax.
/// 2. This mixin is only intended to be used when the assist trigger node is the
/// component name.
///
/// Example:
///     ```
///     import 'package:over_react/over_react.dart';
///
///     part 'test.over_react.g.dart';
///
///     // The assist should trigger off of the `TestComponent` name node and nothing
///     // else.
///     class TestComponent extends UiComponent2<TestProps> {
///       ...
///     }
///     ```
/// 3. The assist declaration should call `initializeAssistApi` before any instance
/// specific logic is implemented. See 'initializeAssistApi' below for an example.
mixin ComponentDeclarationAssistApi on AssistContributorBase {
  SourceFile componentSourceFile;
  BoilerplateMembers members;
  List<BoilerplateDeclaration> declarations;
  ClassComponentDeclaration component;

  ErrorCollector errorCollector;

  bool _isAValidComponentDeclaration = false;

  /// Checks the context of the assist node and returns if it is an appropriate
  /// context to suggest a component level assist.
  bool get isAValidComponentDeclaration => _isAValidComponentDeclaration;

  String get normalizedComponentName => normalizeNameAndRemoveSuffix(component.component);

  NamedType get componentType {
    final typedComponent = component?.component?.node as ClassDeclaration;

    return typedComponent?.extendsClause?.childEntities?.whereType<TypeName>()?.first;
  }

  BoilerplatePropsMixin get propsMixin => component.props?.b;

  BoilerplateStateMixin get stateMixin => component.state?.b;

  bool _isAValidComponentClass(CompilationUnit unit) {
    if (node.parent is! ClassDeclaration) return false;
    ClassDeclaration parent = node.parent;

    members = detectBoilerplateMembers(unit);
    declarations = getBoilerplateDeclarations(members, errorCollector).toList();

    component = declarations.whereType<ClassComponentDeclaration>()?.where((c) {
      return c.component.name.name == parent.name.name;
    })?.first;

    _isAValidComponentDeclaration = component != null && component.version == Version.v4_mixinBased;
    return isAValidComponentDeclaration;
  }

  /// Returns whether the selected unit is in the correct context to show a component
  /// assist after initializing important instance fields.
  ///
  /// Should be called right after finishing the assist setup.
  ///
  /// Example:
  ///     ```
  ///     import 'package:analyzer_plugin/utilities/assist/assist.dart';
  ///
  ///     import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
  ///     import 'package:over_react_analyzer_plugin/src/util/component_assist_api.dart';
  ///
  ///     class ExampleAssist extends AssistContributorBase with ComponentDeclarationAssistApi {
  ///       @override
  ///       Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
  ///         await super.computeAssists(request, collector);
  ///         if (!setupCompute()) return;
  ///
  ///         initializeAssistApi(request.result.unit, request.result.content);
  ///         // Then, `isAValidComponentDeclaration` getter can be used to check if this
  ///         // assist abides by the API expectations.
  ///         if (!isAValidComponentDeclaration) return;
  ///
  ///         // Or, because `initializeAssistApi` mutates the instance fields but
  ///         // returns the validity of the `unit` context, it can be wrapped in
  ///         // the if statement itself:
  ///         // if (!initializeAssistApi(request.result.unit, request.result.content)) return;
  ///
  ///         ... // custom implementation details
  ///       }
  ///     }
  ///     ```
  bool initializeAssistApi(CompilationUnit unit, String sourceFileContent) {
    componentSourceFile = SourceFile.fromString(sourceFileContent);
    errorCollector = ErrorCollector.print(componentSourceFile);
    return _isAValidComponentClass(unit);
  }
}
