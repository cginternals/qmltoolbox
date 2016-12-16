
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias text: button.text
    property bool flat: true
    property bool highlighted: true

    implicitHeight: button.implicitHeight
    implicitWidth: button.implicitWidth

    signal clicked()

    Button {
        id: button

        anchors.fill: parent

        onClicked: parent.clicked()
    }
}