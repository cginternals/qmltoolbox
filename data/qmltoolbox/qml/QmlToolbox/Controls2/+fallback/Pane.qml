
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    id: pane

    default property alias content: contentWrapper.children
    property real padding: 5

    Item {
        id: contentWrapper

        anchors.fill: parent
        anchors.margins: parent.padding
    }
}