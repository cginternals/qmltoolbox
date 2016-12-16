import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4 as Controls1
import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Controls.Label {
            text: qsTr("Settings")
            font.pointSize: 20
        }

        Controls.Slider {
            id: slider
        }

        Controls.Label {
            id: sliderLabel

            text: qsTr("Slider set to %1").arg(slider.value.toFixed(2));
        }

        Controls.Button {
            text: qsTr("Save")
        }
    }
}