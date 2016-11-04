
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    default property alias contentItem: contentWrapper.children
    property alias color: background.color

    property double padding: 0
    property double bottomPadding: 0
    property double leftPadding: 0
    property double rightPadding: 0
    property double topPadding: 0

    Rectangle {
        anchors.fill: parent
        id: background
        color: "#FFFFFF"
    }

    Item {
        id: contentWrapper

        anchors {
            fill: parent
            margins: parent.padding
            bottom: parent.bottomPadding
            left: parent.leftPadding
            right: parent.rightPadding  
            top: parent.topPadding
        }
    }
}