// @dart=2.11
// Copyright 2019 Workiva Inc.
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

import 'package:over_react/over_react.dart';

const EVEN_UPDATES = 1 << 2;
const ODD_UPDATES = 1 << 3;

int calculateChangedBits(int currentValue, int nextValue) {
  int result = 0;
  if (nextValue % 2 == 0) {
    // Bit for even values
    result |= EVEN_UPDATES;
  }
  if (nextValue % 3 == 0) {
    // Bit for odd values
    result |= ODD_UPDATES;
  }
  return result;
}

Context<int> counterContext = createContextInit(1, calculateChangedBits);
