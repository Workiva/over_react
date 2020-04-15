// Copyright 2020 Workiva Inc.
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

import 'package:over_react/src/component_declaration/component_base.dart';

/// Returns a typed view into the unmodifiable default props map for the
/// component associated with [factory].
///
///     // Component Declaration
///     UiFactory<FooProps> Foo;
///
///     mixin FooProps on UiProps {
///       String bar;
///     }
///
///     class FooComponent extends UiComponent<FooProps> {
///       @override
///       get defaultProps => newProps()..bar = 'baz';
///     }
///
///     // Example Usage
///     final defaultFooProps = typedDefaultPropsFor(Foo);
///     print(defaultFooProps.bar); // "baz"
T typedDefaultPropsFor<T extends UiProps>(UiFactory<T> factory) =>
    factory(factory().componentDefaultProps);
