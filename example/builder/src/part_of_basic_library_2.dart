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

// ignore_for_file: deprecated_member_use_from_same_package
part of basic.library;

mixin SuperPartOfLibPropsMixin on UiProps {
  String superProp;
}

abstract class SuperPartOfLibComponent<T extends SuperPartOfLibPropsMixin> extends UiComponent2<T> {
  @override
  get defaultProps => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('SuperPartOfLib', {
      'props.superProp': props.superProp,
    }.toString());
  }
}

UiFactory<SubPartOfLibProps> SubPartOfLib = castUiFactory(_$SubPartOfLib); // ignore: undefined_identifier

mixin SubPartOfLibPropsMixin on UiProps, SuperPartOfLibPropsMixin {
  String subProp;
}

class SubPartOfLibProps = UiProps with SuperPartOfLibPropsMixin, SubPartOfLibPropsMixin;

class SubPartOfLibComponent extends SuperPartOfLibComponent<SubPartOfLibProps> {
  @override
  get defaultProps => newProps()..id = 'sub';

  @override
  render() {
    return Dom.div()('SubPartOfLib', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString());
  }
}
