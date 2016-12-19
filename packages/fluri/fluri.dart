// Copyright 2015 Workiva Inc.
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

/// A fluent URI mutation library.
///
/// # Importing
///
/// Once installed, import the fluri package:
///
///     import 'package:fluri/fluri.dart';
///
/// # Usage
///
/// The fluri library can be used in two different ways. You can
/// use the [Fluri] class directly as a replacement for [Uri],
/// or you can extend or mix in [FluriMixin] to add the fluent
/// mutation API to your own class.
///
/// ## Using [Fluri] Directly
///
///     import 'package:fluri/fluri.dart';
///
///     void main() {
///       Fluri fluri = new Fluri()
///         ..host = 'example.com'
///         ..scheme = 'https'
///         ..path = 'path/to/resource'
///         ..queryParameters = {'limit': '10', 'format': 'json'};
///
///       print(fluri.toString());
///       // https://example.com/path/to/resource?limit=10&format=json
///     }
///
/// ## Extending/Mixing [FluriMixin]
///
///     import 'package:fluri/fluri.dart';
///
///     // Option 1: Extending
///     class Request extends FluriMixin {}
///
///     // Option 2: Using as a Mixin
///     class Request extends Object with FluriMixin {}
///
///     void main() {
///       Request req = new Request()
///         ..host = 'example.com'
///         ..scheme = 'https'
///         ..path = 'path/to/resource'
///         ..queryParameters = {'limit': '10', 'format': 'json'};
///
///       print(req.uri.toString());
///       // https://example.com/path/to/resource?limit=10&format=json
///     }
library fluri;

/// A fluent URI mutation API built on top of [Uri].
///
/// [Fluri] can be used as a replacement for [Uri] and
/// gives you the benefit of easily and incrementally
/// mutating a URI.
///
///     import 'package:fluri/fluri.dart';
///
///     void main() {
///       Fluri fluri = new Fluri()
///         ..host = 'example.com'
///         ..scheme = 'https'
///         ..path = 'path/to/resource'
///         ..queryParameters = {'limit': '10', 'format': 'json'};
///
///       print(fluri.toString());
///       // https://example.com/path/to/resource?limit=10&format=json
///     }
///
/// If you need access to the underlying `Uri` instance, you
/// can access it via the `uri` property:
///
///     import 'package:fluri/fluri.dart';
///
///     void main() {
///       Fluri fluri = new Fluri();
///       Uri uri = fluri.uri;
///     }
class Fluri extends FluriMixin {
  /// Construct a new [Fluri] instance.
  ///
  /// A starting [uri] may be supplied which will be parsed
  /// by [Uri].[Uri.parse].
  Fluri([String uri]) {
    this.uri = Uri.parse(uri != null ? uri : '');
  }

  /// Construct a new [Fluri] instance from another [Fluri] instance.
  Fluri.from(Fluri fluri) : this.fromUri(fluri.uri);

  /// Construct a new [Fluri] instance from a [Uri] instance.
  Fluri.fromUri(Uri uri) {
    this.uri = uri;
  }

  @override
  String toString() => uri.toString();
}

/// A fluent URI mutation API built on top of [Uri] that
/// can be easily extended or mixed in.
///
/// Useful for classes that deal with URI-based actions,
/// like HTTP requests or WebSocket connections.
///
///     import 'package:fluri/fluri.dart';
///
///     // Option 1: Extending
///     class Request extends FluriMixin {}
///
///     // Option 2: Using as a Mixin
///     class Request extends Object with FluriMixin {}
///
///     void main() {
///       Request req = new Request()
///         ..host = 'example.com'
///         ..scheme = 'https'
///         ..path = 'path/to/resource'
///         ..queryParameters = {'limit': '10', 'format': 'json'};
///
///       print(req.uri.toString);
///       // https://example.com/path/to/resource?limit=10&format=json
///     }
class FluriMixin {
  /// The underlying [Uri] instance. All other URI mutations use this.
  Uri _uri = Uri.parse('');

  /// The full URI.
  Uri get uri => _uri;
  set uri(Uri uri) {
    _uri = uri ?? Uri.parse('');
  }

  /// The URI scheme or protocol. Examples: `http`, `https`, `ws`.
  String get scheme => _uri.scheme;
  set scheme(String scheme) {
    _uri = _uri.replace(scheme: scheme);
  }

  /// The URI host, including sub-domains and the tld.
  String get host => _uri.host;
  set host(String host) {
    _uri = _uri.replace(host: host);
  }

  /// The URI port number.
  int get port => _uri.port;
  set port(int port) {
    _uri = _uri.replace(port: port);
  }

  /// The URI path.
  String get path => _uri.path;
  set path(String path) {
    _uri = _uri.replace(path: path);
  }

  /// The URI path segments.
  Iterable<String> get pathSegments => _uri.pathSegments;
  set pathSegments(Iterable<String> pathSegments) {
    _uri = _uri.replace(pathSegments: pathSegments);
  }

  /// Append to the current path.
  void appendToPath(String path) {
    if (this.path.endsWith('/') && path.startsWith('/')) {
      path = path.substring(1);
    }
    this.path = this.path + path;
  }

  /// Add a single path segment to the end of the current path.
  void addPathSegment(String pathSegment) {
    pathSegments = pathSegments.toList()..add(pathSegment);
  }

  /// The URI query string.
  String get query => _uri.query;
  set query(String query) {
    _uri = _uri.replace(query: query);
  }

  /// The URI query parameters.
  Map<String, String> get queryParameters => _uri.queryParameters;
  set queryParameters(Map<String, String> queryParameters) {
    _uri = _uri.replace(queryParameters: queryParameters);
  }

  /// The URI query parameters with support for multi-value params.
  Map<String, List<String>> get queryParametersAll => _uri.queryParametersAll;
  set queryParametersAll(Map<String, Iterable<String>> queryParameters) {
    _uri = _uri.replace(queryParameters: queryParameters);
  }

  /// Set a single query parameter.
  ///
  /// If the given query parameter name is already set, it will be completely
  /// replaced with the given [value].
  ///
  /// Throws an [ArgumentError] if [value] is not a `String` or an
  /// `Iterable<String>`.
  void setQueryParam(String param, dynamic /*String|Iterable<String>*/ value) {
    if (value is! String && value is! Iterable<String>) {
      throw new ArgumentError.value(
          value,
          'value',
          'Must be a String or '
          'Iterable<String>');
    }

    updateQuery({param: value});
  }

  /// Update the URI query parameters, merging the given map with the
  /// current query parameters map instead of overwriting it.
  ///
  /// Throws an [ArgumentError] if any value in the given
  /// [queryParametersToUpdate] map is not a `String` or an `Iterable<String>`.
  ///
  /// If [mergeValues] is `false`, each parameter in [queryParametersToUpdate]
  /// will be completely replaced with the new value.
  ///
  /// If [mergeValues] is `true`, the values for each parameter in
  /// [queryParametersToUpdate] will be merged into the existing list of values
  /// for that parameter. Duplicate values will be discarded.
  void updateQuery(
      Map<String, dynamic /*String|Iterable<String>*/ > queryParametersToUpdate,
      {bool mergeValues: false}) {
    final newQueryParameters = <String, List<String>>{};

    // Copy the current query param values.
    queryParametersAll.forEach((key, value) {
      newQueryParameters[key] = new List.from(value);
    });

    // Update the query using the given params.
    queryParametersToUpdate.forEach((key, value) {
      // Initialize or reset the value list if it either does not already exist,
      // or if we're not merging values.
      if (!mergeValues || !newQueryParameters.containsKey(key)) {
        newQueryParameters[key] = [];
      }

      // Add the param value(s) while eliminating duplicates.
      // Throw an ArgumentError if any value is invalid.
      if (value is String && !newQueryParameters.containsValue(value)) {
        newQueryParameters[key].add(value);
      } else if (value is Iterable<String>) {
        for (var v in value) {
          if (!newQueryParameters[key].contains(v)) {
            newQueryParameters[key].add(v);
          }
        }
      } else {
        throw new ArgumentError('Query parameter "$key" has value "$value" '
            'which is not a String or an Iterable<String>.');
      }
    });

    _uri = _uri.replace(queryParameters: newQueryParameters);
  }

  /// The URI fragment or hash.
  String get fragment => _uri.fragment;
  set fragment(String fragment) {
    _uri = _uri.replace(fragment: fragment);
  }
}
