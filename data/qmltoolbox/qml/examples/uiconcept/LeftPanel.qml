
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    id: leftPanel

    function toggle() {
        state = (state == "visible") ? "hidden" : "visible";
    }  

    padding: 0.0
    state: "visible"
    Layout.minimumWidth: 240

    states: [
        State { 
            name: "visible"
            PropertyChanges {
                target: leftPanel
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges { target: leftPanel; width: 0; Layout.minimumWidth: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"; to: "visible" 

            SequentialAnimation {
                PropertyAction { properties: "visible" }
                NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                PropertyAction { properties: "Layout.minimumWidth" }
            }
        },
        Transition {
            from: "visible"; to: "hidden"

            SequentialAnimation {
                NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                PropertyAction { properties: "visible" }
            }
        }
    ]
}