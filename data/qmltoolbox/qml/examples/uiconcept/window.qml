
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane
{
    id: root

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