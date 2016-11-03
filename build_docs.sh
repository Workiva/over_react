#!/usr/bin/env bash

rm -rf .pub .packages
find . -name packages | xargs rm -rf
pub get --packages-dir
pub build


# Generate html includes that can be passed in as jekyll include parameters for demo-code-example.html


#
# Button
#
cp -r web/src/demo_components/button.dart docs/_includes/component-demo-code-ex/button.dart.html

cp -r web/demos/button/button-examples.dart docs/_includes/component-demo-code-ex/button-examples.dart.html
cp -r web/demos/button/button-types.dart docs/_includes/component-demo-code-ex/button-types.dart.html
cp -r web/demos/button/button-outline.dart docs/_includes/component-demo-code-ex/button-outline.dart.html
cp -r web/demos/button/button-sizes.dart docs/_includes/component-demo-code-ex/button-sizes.dart.html
cp -r web/demos/button/button-block.dart docs/_includes/component-demo-code-ex/button-block.dart.html
cp -r web/demos/button/button-active.dart docs/_includes/component-demo-code-ex/button-active.dart.html
cp -r web/demos/button/button-disabled.dart docs/_includes/component-demo-code-ex/button-disabled.dart.html


#
# ListGroup / ListGroupItem
#
cp -r web/src/demo_components/list_group.dart docs/_includes/component-demo-code-ex/list_group.dart.html
cp -r web/src/demo_components/list_group_item.dart docs/_includes/component-demo-code-ex/list_group_item.dart.html

cp -r web/demos/list-group/list-group-basic.dart docs/_includes/component-demo-code-ex/list-group-basic.dart.html
cp -r web/demos/list-group/list-group-tags.dart docs/_includes/component-demo-code-ex/list-group-tags.dart.html
cp -r web/demos/list-group/list-group-anchors-and-buttons.dart docs/_includes/component-demo-code-ex/list-group-anchors-and-buttons.dart.html
cp -r web/demos/list-group/list-group-contextual.dart docs/_includes/component-demo-code-ex/list-group-contextual.dart.html
cp -r web/demos/list-group/list-group-header.dart docs/_includes/component-demo-code-ex/list-group-header.dart.html


#
# Progress
#
cp -r web/src/demo_components/progress.dart docs/_includes/component-demo-code-ex/progress.dart.html

cp -r web/demos/progress/progress-basic.dart docs/_includes/component-demo-code-ex/progress-basic.dart.html
cp -r web/demos/progress/progress-contextual.dart docs/_includes/component-demo-code-ex/progress-contextual.dart.html
cp -r web/demos/progress/progress-striped.dart docs/_includes/component-demo-code-ex/progress-striped.dart.html
cp -r web/demos/progress/progress-animated-stripes.dart docs/_includes/component-demo-code-ex/progress-animated-stripes.dart.html


#
# Tag
#
cp -r web/src/demo_components/tag.dart docs/_includes/component-demo-code-ex/tag.dart.html

cp -r web/demos/tag/tag-basic.dart docs/_includes/component-demo-code-ex/tag-basic.dart.html
cp -r web/demos/tag/tag-contextual.dart docs/_includes/component-demo-code-ex/tag-contextual.dart.html
cp -r web/demos/tag/tag-pills.dart docs/_includes/component-demo-code-ex/tag-pills.dart.html


#
# ToggleButtonGroup / ToggleButton
#
cp -r web/src/demo_components/toggle_button_group.dart docs/_includes/component-demo-code-ex/toggle_button_group.dart.html
cp -r web/src/demo_components/toggle_button.dart docs/_includes/component-demo-code-ex/toggle_button.dart.html

cp -r web/demos/toggle-button/toggle-button-checkbox.dart docs/_includes/component-demo-code-ex/toggle-button-checkbox.dart.html
cp -r web/demos/toggle-button/toggle-button-radio.dart docs/_includes/component-demo-code-ex/toggle-button-radio.dart.html


# De-reference the symlinked root packages directory so that github pages can copy them to _site

bundle exec jekyll build

#rm -rf packages
cp -r _site/packages/ packages/
