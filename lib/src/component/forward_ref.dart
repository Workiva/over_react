//// Copyright 2019 Workiva Inc.
////
//// Licensed under the Apache License, Version 2.0 (the "License");
//// you may not use this file except in compliance with the License.
//// You may obtain a copy of the License at
////
////     http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing, software
//// distributed under the License is distributed on an "AS IS" BASIS,
//// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//// See the License for the specific language governing permissions and
//// limitations under the License.

import 'package:react/react_client.dart';
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/component_base.dart';

UiFactory<TProps> Function(UiFactory<TProps>) forwardRef<TProps extends UiProps>(
    Function(TProps props, dynamic ref) wrapperFunction) {

  UiFactory<TProps> wrapWithForwardRef(UiFactory<TProps> factory) {
    wrapProps(Map props, ref) {
      return wrapperFunction(factory(props), ref);
    }
    ReactComponentFactoryProxy hoc = react_client.forwardRef(wrapProps);

    TProps forwardedFactory([Map props]) {
      return factory(props)..componentFactory = hoc;
    }

    return forwardedFactory;
  }

  return wrapWithForwardRef;
}
