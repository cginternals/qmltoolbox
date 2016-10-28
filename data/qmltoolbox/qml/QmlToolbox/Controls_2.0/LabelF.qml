
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias text: label.text
    property alias font: label.font

    implicitHeight: label.implicitHeight
    implicitWidth: label.implicitWidth

    Label {
        id: label

        anchors.fill: parent
    }
}