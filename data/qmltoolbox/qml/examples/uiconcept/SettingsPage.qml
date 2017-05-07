
import QtQuick 2.0
import QtQuick.Layouts 1.1

import QmlToolbox.Controls 1.0


Item
{
    ColumnLayout
    {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Label
        {
            text: qsTr("Settings")
            font.pointSize: 20
        }

        Slider
        {
            id: slider
        }

        Label
        {
            id: sliderLabel

            text: qsTr("Slider set to %1").arg(slider.value.toFixed(2));
        }

        Button
        {
            text: qsTr("Save")
        }
    }
}
