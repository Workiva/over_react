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

library builder_utils;

export 'src/analyzer_helpers.dart'
    show copyClassMember, getDeclarationsAnnotatedBy, instantiateAnnotation;
export 'src/build_utils.dart'
    show assetIdToPackageUri, getSpanForNode, getSpan;
export 'src/node_with_meta.dart' show NodeWithMeta;
export 'src/text_util.dart' show stringLiteral;
