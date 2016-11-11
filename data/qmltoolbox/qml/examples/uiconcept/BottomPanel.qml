
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    id: bottomPanel

    function toggle() {
        state = (state == "visible") ? "hidden" : "visible";
    }

    padding: 0.0
    state: "visible"
    Layout.minimumHeight: 150

    states: [
        State { 
            name: "visible"
            PropertyChanges {
                target: bottomPanel
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges { 
                target: bottomPanel
                height: 0
                Layout.minimumHeight: 0
                visible: false 
            }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "visible" 

            SequentialAnimation {
                PropertyAction { properties: "visible" }
                NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                PropertyAction { properties: "Layout.minimumHeight" }
            }
        },
        Transition {
            from: "visible"; to: "hidden"

            SequentialAnimation {
                NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
                PropertyAction { properties: "visible" }
            }
        }
    ]
}