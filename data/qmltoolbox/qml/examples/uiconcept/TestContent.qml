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
            text: "Settings"
        }
        Controls.Slider {
            value: 0.5
        }
        Controls.Button {
            text: "Save"
        }
    }
}