// Copyright 2016 Workiva Inc.
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

library over_react.dummy_component;

import 'package:react/react.dart' as react;

export 'dummy_component2.dart';

/// Dummy component useful for:
///
/// - Allowing sub-typing of components.
// ignore: deprecated_member_use
class DummyComponent extends react.Component {
  @override
  render() => false;
}
