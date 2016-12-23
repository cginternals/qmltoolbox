
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    id: root

    default property alias contentItems: contentWrapper.data
    
    property Item background

    property real bottomPadding: 0
    property real leftPadding: 0
    property real rightPadding: 0
    property real topPadding: 0
    property real padding: 0

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

    Item {
        id: contentWrapper

        z: 1

        anchors {
            fill: parent
            bottomMargin: parent.bottomPadding
            leftMargin: parent.leftPadding
            rightMargin: parent.rightPadding  
            topMargin: parent.topPadding
        }
    }
}