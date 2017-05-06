
import QtQuick 2.4

import QmlToolbox.Base 1.0


/**
*  Control
*
*  Abstract base type providing functionality common to all controls
*
*  Implementation of Control using QtQuick 2.4
*
*  The following parts of Control as it is realized 
*  in QtQuick Controls 2 have been implemented:
*  - Content Item
*  - Paddings
*  - Background
*/
Item 
{
    id: item

    // Padding sizes
    property real padding:       0       ///< Padding between background and content item (all sides)
    property real leftPadding:   padding ///< Padding between background and content item (left side)
    property real rightPadding:  padding ///< Padding between background and content item (right side)
    property real topPadding:    padding ///< Padding between background and content item (top side)
    property real bottomPadding: padding ///< Padding between background and content item (bottom side)

    // Background item
    property Item background: null

    // Content item
    readonly property Item contentItem: content

    // Put child items into content item
    default property alias data: content.data

    implicitWidth:  contentItem.implicitWidth  + leftPadding + rightPadding
    implicitHeight: contentItem.implicitHeight + topPadding  + bottomPadding

    Item
    {
        id: content

        anchors.fill:         parent
        anchors.bottomMargin: parent.bottomPadding
        anchors.leftMargin:   parent.leftPadding
        anchors.rightMargin:  parent.rightPadding
        anchors.topMargin:    parent.topPadding

        z: 1

        onChildrenChanged:
        {
            implicitWidth = Qt.binding(function() {
                return children[0].implicitWidth;
            } );

            implicitHeight = Qt.binding(function() {
                return children[0].implicitHeight;
            } );
        }
    }

    DebugItem
    {
        z: 2
    }

    onBackgroundChanged: 
    {
        if (background !== null) 
        {
            // Reparent background item and make it fill the control's size
            background.parent       = item;
            background.anchors.fill = item;
            background.z            = 0;
        }
    }
}
