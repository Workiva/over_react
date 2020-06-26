import 'dart:collection';

import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';

/// An iterable of metadata about registered contributors like assists / diagnostics (lints).
abstract class ContributorMetaRegistry<T extends DocumentedContributorMetaBase> extends IterableMixin<T> {
  /// A table mapping contributor names to contributor metadata.
  final _metaMap = <String, T>{};

  @override
  Iterator<T> get iterator => _metaMap.values.iterator;

  /// Returns a list of contributor metadata.
  Iterable<T> get meta => _metaMap.values;

  /// Return the contributor metadata with the given [name].
  T operator [](String name) => _metaMap[name];

  /// Adds the [meta] to this registry, keyed by the [DocumentedContributorMetaBase.name] found in the provided [meta].
  void register(T meta) {
    _metaMap[meta.name] = meta;
  }
}

class AssistMetaRegistry extends ContributorMetaRegistry<DocumentedAssistContributorMeta> {
  /// Metadata about assists registered for inclusion in the documentation for this analyzer plugin.
  static final AssistMetaRegistry assistRegistry = AssistMetaRegistry();
}

class DiagnosticMetaRegistry extends ContributorMetaRegistry<DocumentedDiagnosticContributorMeta> {
  /// Metadata about diagnostics _(lints / "rules")_ registered for inclusion in the documentation for this analyzer plugin.
  static final DiagnosticMetaRegistry diagnosticRegistry = DiagnosticMetaRegistry();
}
