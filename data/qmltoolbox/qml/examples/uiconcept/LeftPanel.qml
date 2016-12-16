
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QmlToolBox.Controls2 1.0 as Controls

import Qt.labs.settings 1.0 as Labs

Controls.Pane {
    id: leftPanel

    function toggle() {
        setVisibility(!isVisible());
    }

    function setVisibility(visible) {
        stateWrapper.state = visible ? "visible" : "hidden";
    }

    function isVisible() {
        return (stateWrapper.state == "visible");
    }

    padding: 0.0
    Layout.minimumWidth: 240

    Item {
        id: stateWrapper

        state: "visible"

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
                PropertyChanges { 
                    target: leftPanel
                    width: 0
                    Layout.minimumWidth: 0
                    visible: false 
                }
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
                    ScriptAction { script: settings.width = leftPanel.width }
                    NumberAnimation { properties: "width"; easing.type: Easing.InOutQuad }
                    PropertyAction { properties: "visible" }
                }
            }
        ]
    }

    Labs.Settings {
        id: settings
        category: "leftPanel"
        property bool visible: true
        property int width
    }

    Component.onCompleted: {
        width = settings.width;
        setVisibility(settings.visible);
    }

    Component.onDestruction: {
        settings.visible = isVisible();

        if (isVisible())
            settings.width = width;
    }
}