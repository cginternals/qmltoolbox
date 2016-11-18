
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias font: text_field.font
    property alias text: text_field.text

    implicitHeight: text_field.implicitHeight
    implicitWidth: text_field.implicitWidth

    signal editingFinished()

    TextField {
        id: text_field

        anchors.fill: parent
    }

    Component.onCompleted: {
        text_field.editingFinished.connect(editingFinished);
    }
}