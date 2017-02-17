
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QtQuick.Controls 1.3

ScrollView 
{
    id: root

    // TODO: Should be list<Item>
    default property Item content

    property alias boundsBehavior: flickable.boundsBehavior
    property alias contentHeight: flickable.contentHeight
    property alias contentWidth: flickable.contentWidth
    property alias contentX: flickable.contentX
    property alias contentY: flickable.contentY
    property alias flickableDirection: flickable.flickableDirection

    property var scrollBarColor: null

    property bool verticalScrollbar
    property bool horizontalScrollbar

    // vertical and horizontal scrollbar means something different in Controls 1 and Controls 2 ...
    onVerticalScrollbarChanged: 
    {
        root.horizontalScrollBarPolicy = verticalScrollbar ? Qt.ScrollBarAlwaysOn : Qt.ScrollBarAlwaysOff;
    }

    onHorizontalScrollbarChanged: 
    {
        root.verticalScrollBarPolicy = horizontalScrollbar ? Qt.ScrollBarAlwaysOn : Qt.ScrollBarAlwaysOff;
    }

    onContentChanged: 
    {
        if (content !== null) 
        {
            content.parent = flickable.contentItem;
        }
    }

    Flickable { id: flickable }

    Component.onCompleted: 
    {
        verticalScrollbar = false;
        horizontalScrollbar = false;
    }
}