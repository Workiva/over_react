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

part of '../annotation_error_integration_test.dart';

@Factory()
UiFactory<AnnotationErrorStatefulProps> AnnotationErrorStateful =
    _$AnnotationErrorStateful; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$AnnotationErrorStatefulProps extends UiProps {}

@State()
class _$AnnotationErrorStatefulState extends UiState {}

// ignore: deprecated_member_use_from_same_package
@Component()
class AnnotationErrorStatefulComponent extends UiStatefulComponent2<
    AnnotationErrorStatefulProps, AnnotationErrorStatefulState> {
  @override
  render() => props.children;
}
