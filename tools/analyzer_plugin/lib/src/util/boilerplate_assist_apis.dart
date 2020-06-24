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
import 'package:over_react/src/builder/parsing/util.dart';
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

  /// A context variable representing the component being targeted by the assist.
  ///
  /// After triggering the assist off of the component class name, the mixin initialization
  /// will detect the related boilerplate and set this as the entrypoint. This process
  /// will occur for the relevant component every time the assist is triggered.
  ClassComponentDeclaration componentDeclaration;

  ErrorCollector errorCollector;

  bool _isAValidComponentDeclaration;

  /// Checks the context of the assist node and returns if it is an appropriate
  /// context to suggest a component level assist.
  bool get isAValidComponentDeclaration {
    if (_isAValidComponentDeclaration == null) {
      throw StateError('API not initialized. Call `initializeAssistApi` before accessible API members.');
    }

    return _isAValidComponentDeclaration;
  }

  String get normalizedComponentName => normalizeNameAndRemoveSuffix(componentDeclaration.component);

  NamedType get componentSupertypeNode => componentDeclaration.component.nodeHelper.superclass;

  Union<BoilerplateProps, BoilerplatePropsMixin> get props => componentDeclaration.props;

  Union<BoilerplateState, BoilerplateStateMixin> get state => componentDeclaration.state;

  bool _validateAndDetectBoilerplate() {
    if (node is! SimpleIdentifier || node.parent is! ClassDeclaration) return false;
    ClassDeclaration parent = node.parent;

    final members = detectBoilerplateMembers(node.thisOrAncestorOfType<CompilationUnit>());
    final declarations = getBoilerplateDeclarations(members, errorCollector).toList();

    componentDeclaration = declarations.whereType<ClassComponentDeclaration>().firstWhere((c) {
      return c.component.node == parent;
    }, orElse: () => null);

    _isAValidComponentDeclaration =
        componentDeclaration != null && componentDeclaration.version == Version.v4_mixinBased;
    return isAValidComponentDeclaration;
  }

  /// Returns whether the node under the cursor is the correct context to show a component
  /// assist after initializing important instance fields.
  ///
  /// Should be called right after finishing the assist setup.
  ///
  /// Example:
  ///     ```
  ///     import 'package:analyzer_plugin/utilities/assist/assist.dart';
  ///
  ///     import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
  ///     import 'package:over_react_analyzer_plugin/src/util/boilerplate_assist_apis.dart';
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
  ///         // the same if statement as `setupCompute`:
  ///         // if (!setupCompute() || !initializeAssistApi(request.result.content)) return;
  ///
  ///         ... // custom implementation details
  ///       }
  ///     }
  ///     ```
  bool initializeAssistApi(String sourceFileContent) {
    componentSourceFile = SourceFile.fromString(sourceFileContent);
    errorCollector = ErrorCollector.print(componentSourceFile);
    return _validateAndDetectBoilerplate();
  }
}
