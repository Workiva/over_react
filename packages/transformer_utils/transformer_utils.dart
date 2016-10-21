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

library transformer_utils;

export 'package:transformer_utils/src/analyzer_helpers.dart'
    show
        copyClassMember,
        getDeclarationsAnnotatedBy,
        getLiteralValue,
        instantiateAnnotation;
export 'package:transformer_utils/src/barback_utils.dart'
    show assetIdToPackageUri, getSpanForNode;
export 'package:transformer_utils/src/jet_brains_friendly_logger.dart'
    show JetBrainsFriendlyLogger;
export 'package:transformer_utils/src/node_with_meta.dart' show NodeWithMeta;
export 'package:transformer_utils/src/transformed_source_file.dart'
    show TransformedSourceFile;
