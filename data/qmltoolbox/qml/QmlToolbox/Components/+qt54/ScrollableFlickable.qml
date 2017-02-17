
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QtQuick.Controls 1.3


/**
*  Scrollable Flickable
*
*  Implementation of ScrollableFlickable using Controls 1.0
*/
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

    // TODO: react to changes of these properties
    property bool verticalScrollbar
    property bool horizontalScrollbar

    onContentChanged: 
    {
        if (content !== null) 
        {
            content.parent = flickable.contentItem;
        }
    }

    Flickable { id: flickable }
}