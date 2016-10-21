#!/usr/bin/env bash

pub build --mode=debug


# Generate html includes that can be passed in as jekyll include parameters for demo-code-example.html

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
# Tag
#
cp -r web/src/demo_components/tag.dart docs/_includes/component-demo-code-ex/tag.dart.html

cp -r web/demos/tag/tag-basic.dart docs/_includes/component-demo-code-ex/tag-basic.dart.html
cp -r web/demos/tag/tag-contextual.dart docs/_includes/component-demo-code-ex/tag-contextual.dart.html
cp -r web/demos/tag/tag-pills.dart docs/_includes/component-demo-code-ex/tag-pills.dart.html
