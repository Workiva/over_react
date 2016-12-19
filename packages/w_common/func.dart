// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Generic callback function type that expects a certain return type.
///
/// This is useful, for example, when you want a simple callback function
/// in a single location and creating a separate typedef seems heavy handed.
/// Instead you can use this type:
///
///     class MyClass {
///       Func<Model> modelGetter;
///
///       MyClass(Func<Model> this.modelGetter);
///
///       onLoad() async {
///         Model model = modelGetter();
///       }
///     }
typedef T Func<T>();
