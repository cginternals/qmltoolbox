
import QtQuick 2.4

import QmlToolbox.Base 1.0


/**
*  Control
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

    default property alias content: content_item.data
    
    readonly property Item contentItem: Item 
    {
        id: content_item

        anchors.fill:         parent
        anchors.bottomMargin: parent.bottomPadding
        anchors.leftMargin:   parent.leftPadding
        anchors.rightMargin:  parent.rightPadding
        anchors.topMargin:    parent.topPadding

        z: 2
    }

    property Item background
    property real bottomPadding: 0
    property real leftPadding:   0
    property real rightPadding:  0
    property real topPadding:    0
    property real padding:       0

    implicitWidth:  leftPadding + rightPadding + contentItem.implicitWidth
    implicitHeight: topPadding + bottomPadding + contentItem.implicitHeight

    onPaddingChanged: 
    { 
        bottomPadding = padding;
        leftPadding   = padding;
        rightPadding  = padding;
        topPadding    = padding;
    }

    onBackgroundChanged: 
    {
        if (background !== null) 
        {
            background.parent = item;

            // The background item automatically follows the control's size
            background.anchors.fill = item;
        }
    }

    Component.onCompleted:
    {
        content_item.parent = item;
    }

    DebugItem
    {
        z: 1
    }
}
