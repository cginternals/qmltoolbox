
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    default property alias contentItems: contentWrapper.data
    property alias background: background_loader.sourceComponent

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

    Loader {
        id: background_loader

        anchors.fill: parent

        sourceComponent: Rectangle {
        }
    }

    Item {
        id: contentWrapper

        anchors {
            fill: parent
            bottomMargin: parent.bottomPadding
            leftMargin: parent.leftPadding
            rightMargin: parent.rightPadding  
            topMargin: parent.topPadding
        }
    }
}