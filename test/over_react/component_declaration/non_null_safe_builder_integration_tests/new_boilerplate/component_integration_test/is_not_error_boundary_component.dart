// @dart=2.11
// This file is a copy of the test file in ./builder_integration_tests to make sure the builder still works on non-null safe Dart versions.

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

part of '../component_integration_test.dart';

UiFactory<IsNotErrorBoundaryProps> IsNotErrorBoundary = _$IsNotErrorBoundary; // ignore: undefined_identifier, invalid_assignment

mixin IsNotErrorBoundaryProps on UiProps {}

class IsNotErrorBoundaryComponent extends UiComponent2<IsNotErrorBoundaryProps> {
  static var calls = [];

  @override
  Map getDerivedStateFromError(_) {
    calls.add('getDerivedStateFromError');
    return null;
  }

  @override
  void componentDidCatch(_, __) {
    calls.add('componentDidCatch');
  }

  @override
  render() => props.children;
}
