
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0

Flickable {
    id: root

    property var scrollBarColor: null

    property bool verticalScrollbar: false
    property bool horizontalScrollbar: false

    onScrollBarColorChanged: {
        if (root.ScrollBar.vertical !== null)
            root.ScrollBar.vertical.color = scrollBarColor;

        if (root.ScrollBar.horizontal !== null)
            root.ScrollBar.horizontal.color = scrollBarColor;
    }
    
    onVerticalScrollbarChanged: {
        if (verticalScrollbar) {
            root.ScrollBar.vertical = scrollBar.createObject(root, { color: scrollBarColor });
        } else {
            root.ScrollBar.vertical = null;
        }
    }

    onHorizontalScrollbarChanged: {
        if (horizontalScrollbar) {
            root.ScrollBar.horizontal = scrollBar.createObject(root, { color: scrollBarColor });
        } else {
            root.ScrollBar.horizontal = null;
        }
    }

    Component {
        id: scrollBar

        ScrollBar {
            property var defaultColor: null
            property var color: null

            onColorChanged: {
                if (defaultColor === null)
                    defaultColor = contentItem.color;

                if (color !== null) {
                    contentItem.color = color;
                } else {
                    contentItem.color = defaultColor;
                }
            }
        }
    }
}