
import QtQuick 2.4

import QmlToolBox.Base 1.0

Item {
    id: root

    default property alias content: content_item.data
    
    readonly property Item contentItem: Item {
        id: content_item

        z: 2

        anchors {
            fill: parent
            bottomMargin: parent.bottomPadding
            leftMargin: parent.leftPadding
            rightMargin: parent.rightPadding  
            topMargin: parent.topPadding
        }
    }

    property Item background

    property real bottomPadding: 0
    property real leftPadding: 0
    property real rightPadding: 0
    property real topPadding: 0
    property real padding: 0

    implicitWidth: { leftPadding + rightPadding + contentItem.implicitWidth }
    implicitHeight: { topPadding + bottomPadding + contentItem.implicitHeight }

    onPaddingChanged: { 
        bottomPadding = padding
        leftPadding = padding
        rightPadding = padding
        topPadding = padding
    }

    onBackgroundChanged: {
        if (background !== null) {
            background.parent = root;
            background.anchors.fill = root;
        }
    }

    Component.onCompleted: {
        content_item.parent = root;
    }

    DebugItem { 
        z: 1
    }
}