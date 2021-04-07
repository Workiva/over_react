// Adapted from https://github.com/dart-lang/sdk/blob/d45a6ec893fe4facd1fbae6764dd7a474c6bee93/pkg/analyzer_plugin/lib/plugin/assist_mixin.dart
//
// Copyright 2017, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/generator.dart';

/// A concrete implementation of [AssistCollector].
class _AssistCollectorImpl implements AssistCollector {
  /// The list of assists that have been collected.
  final List<PrioritizedSourceChange> assists = <PrioritizedSourceChange>[];

  @override
  void addAssist(PrioritizedSourceChange assist) {
    assists.add(assist);
  }
}

/// An object used to produce assists.
///
/// Clients may implement this class when implementing plugins.
abstract class AsyncAssistContributor {
  /// Contribute assists for the location in the file specified by the given
  /// [request] into the given [collector].
  Future<void> computeAssists(covariant AssistRequest request, AssistCollector collector);
}

/// A generator that will generate an 'edit.getAssists' response.
///
/// Clients may not extend, implement or mix-in this class.
class _AsyncAssistGenerator {
  /// Initialize a newly created assists generator to use the given
  /// [contributors].
  _AsyncAssistGenerator(this.contributors);

  /// The contributors to be used to generate the assists.
  final List<AsyncAssistContributor> contributors;

  /// Create an 'edit.getAssists' response for the location in the file specified
  /// by the given [request]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<GeneratorResult<EditGetAssistsResult>> generateAssistsResponse(AssistRequest request) async {
    final notifications = <Notification>[];
    final collector = _AssistCollectorImpl();
    for (final contributor in contributors) {
      try {
        await contributor.computeAssists(request, collector);
      } catch (exception, stackTrace) {
        notifications.add(PluginErrorParams(false, exception.toString(), stackTrace.toString()).toNotification());
      }
    }
    final result = EditGetAssistsResult(collector.assists);
    return GeneratorResult(result, notifications);
  }
}

/// A mixin that can be used when creating a subclass of [ServerPlugin] to
/// provide most of the implementation for handling assist requests.
///
/// Clients may not extend or implement this class, but are allowed to use it as
/// a mix-in when creating a subclass of [ServerPlugin].
mixin AsyncAssistsMixin on ServerPlugin {
  /// Return a list containing the assist contributors that should be used to
  /// create assists for the file with the given [path].
  List<AsyncAssistContributor> getAssistContributors(String path);

  /// Return the assist request that should be passes to the contributors
  /// returned from [getAssistContributors].
  ///
  /// Throw a [RequestFailure] if the request could not be created.
  Future<AssistRequest> getAssistRequest(EditGetAssistsParams parameters);

  @override
  Future<EditGetAssistsResult> handleEditGetAssists(EditGetAssistsParams parameters) async {
    final path = parameters.file;
    final request = await getAssistRequest(parameters);
    final generator = _AsyncAssistGenerator(getAssistContributors(path));
    final result = await generator.generateAssistsResponse(request);
    result.sendNotifications(channel);
    return result.result;
  }
}

/// A mixin that can be used when creating a subclass of [ServerPlugin] and
/// mixing in [AsyncAssistsMixin]. This implements the creation of the assists request
/// based on the assumption that the driver being created is an `AnalysisDriver`.
///
/// Clients may not extend or implement this class, but are allowed to use it as
/// a mix-in when creating a subclass of [ServerPlugin] that also uses
/// [AsyncAssistsMixin] as a mix-in.
mixin AsyncDartAssistsMixin on AsyncAssistsMixin {
  @override
  Future<AssistRequest> getAssistRequest(EditGetAssistsParams parameters) async {
    final path = parameters.file;
    final result = await getResolvedUnitResult(path);
    return _DartAssistRequestImpl(resourceProvider, parameters.offset, parameters.length, result);
  }
}

/// A concrete implementation of [DartAssistRequest].
class _DartAssistRequestImpl implements DartAssistRequest {
  /// Initialize a newly create request with the given data.
  _DartAssistRequestImpl(this.resourceProvider, this.offset, this.length, this.result);

  @override
  final ResourceProvider resourceProvider;

  @override
  final int offset;

  @override
  final int length;

  @override
  final ResolvedUnitResult result;
}
