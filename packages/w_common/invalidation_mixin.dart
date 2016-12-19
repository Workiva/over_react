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

import 'dart:async';
import 'dart:html';

/// A mixin providing a simple validation lifecycle.
///
/// Call [invalidate] to mark class as needing to be validated.  Implement
/// [validate] to specify logic that should happen when the class is validated.
/// Validation is scheduled using animationFrame on [window].
abstract class InvalidationMixin {
  /// A boolean reflection of the current validity.
  bool get invalid => _onValidate != null && !_onValidate.isCompleted;

  /// Used to complete or error the validation
  Completer _onValidate;

  /// Mark this as invalid to be validated at a later time.
  ///
  /// Schedule a call to [validate] to occur at the next frame. Multiple calls
  /// to invalidate will not enqueue multiple validations. The [Future] returned
  /// will complete with [ValidationStatus.complete] when the class is validated
  /// and [ValidationStatus.cancelled] if invalidation is cancelled.
  Future invalidate() {
    if (invalid) return _onValidate.future;

    _onValidate = new Completer();

    window.animationFrame.then((_) {
      if (invalid) {
        validate();
        _onValidate.complete(ValidationStatus.complete);
      }
    });

    return _onValidate.future;
  }

  /// Abstract method to be implemented as means of performing validation.
  void validate();

  /// Cancels the current validation attempt.
  ///
  /// The future returned by [invalidate] will receive an
  /// [ValidationStatus.cancelled] as a result of calling this method.
  void cancelInvalidation() {
    if (invalid) {
      _onValidate.complete(ValidationStatus.cancelled);
    }
  }
}

/// An object representing the reason for the validation .
///
/// A validation can be completed or it can be cancelled.
enum ValidationStatus { complete, cancelled }
