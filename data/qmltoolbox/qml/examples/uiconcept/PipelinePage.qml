
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Page {
    id: page

    header: Controls.ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent

            Controls.ToolButton {
                text: "Back"

                onClicked: page.StackView.view.pop()
            }

            Item { Layout.fillWidth: true }
        }
    }

    Controls.Pane {
        Controls.Label {
            text: "New Page!"
        }
    }
}