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

class Action {
  Action({this.type, this.value});

  final String type;
  final dynamic value;

  toJson() {
    return {'value': this.value};
  }
}

class IncrementAction extends Action {
  IncrementAction([value]) : super(type: 'INCREMENT', value: value);
}

class DecrementAction extends Action {
  DecrementAction([value]) : super(type: 'DECREMENT', value: value);
}

class ResetAction extends Action {
  ResetAction() : super(type: 'RESET');
}

class MutateStoreDirectlyAction extends Action {
  MutateStoreDirectlyAction() : super(type: 'RESET_STORE_DIRECTLY');
}
