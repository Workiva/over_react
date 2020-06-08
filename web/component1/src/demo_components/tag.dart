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
import 'package:over_react/over_react.dart';
part 'tag.over_react.g.dart';

/// Bootstrap's `Tag` component renders a small and adaptive tag
/// for adding context to just about any content.
///
/// See: <http://v4-alpha.getbootstrap.com/components/tag/>
@Factory()
UiFactory<TagProps> Tag = _$Tag;

@Props()
class _$TagProps extends UiProps {
  /// The skin / "context" for the [Tag].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#contextual-variations>.
  ///
  /// Default: [TagSkin.DEFAULT]
  TagSkin skin;

  /// Whether to render the [Tag] with rounded corners that make it look
  /// more like a "pill" (a.k.a Bootstrap v3 "badge")
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#pill-tags>.
  ///
  /// Default: false
  bool isPill;
}

@Component()
class TagComponent extends UiComponent<TagProps> {
  @override
  Map getDefaultProps() => (newProps()
    ..skin = TagSkin.DEFAULT
    ..isPill = false
  );

  @override
  render() {
    var classes = forwardingClassNameBuilder()
      ..add('tag')
      ..add('tag-pill', props.isPill)
      ..add(props.skin.className);

    return (Dom.span()
      ..addProps(copyUnconsumedDomProps())
      ..className = classes.toClassName()
    )(props.children);
  }
}

/// Contextual skin options for a [Tag] component.
class TagSkin extends ClassNameConstant {
  const TagSkin._(String name, String className) : super(name, className);

  /// [className] value: 'tag-default'
  static const TagSkin DEFAULT =
      TagSkin._('DEFAULT', 'tag-default');

  /// [className] value: 'tag-primary'
  static const TagSkin PRIMARY =
      TagSkin._('PRIMARY', 'tag-primary');

  /// [className] value: 'tag-danger'
  static const TagSkin DANGER =
      TagSkin._('DANGER', 'tag-danger');

  /// [className] value: 'tag-success'
  static const TagSkin SUCCESS =
      TagSkin._('SUCCESS', 'tag-success');

  /// [className] value: 'tag-warning'
  static const TagSkin WARNING =
      TagSkin._('WARNING', 'tag-warning');

  /// [className] value: 'tag-info'
  static const TagSkin INFO =
      TagSkin._('INFO', 'tag-info');
}

