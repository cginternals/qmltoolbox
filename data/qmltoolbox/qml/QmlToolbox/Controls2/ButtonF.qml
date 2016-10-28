
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias text: button.text

    implicitHeight: button.implicitHeight
    implicitWidth: button.implicitWidth

    Button {
        id: button

        anchors.fill: parent
    }
}