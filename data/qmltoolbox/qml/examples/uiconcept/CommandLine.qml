
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    id: root

    property real textHeight: flickable.contentHeight

    signal submitted(string command)

    topPadding: 0
    bottomPadding: 0
    leftPadding: 12
    rightPadding: 12

    RowLayout {
        anchors.fill: parent

        Flickable {
            id: flickable

            clip: true
            boundsBehavior: Flickable.StopAtBounds

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillWidth: true

            TextArea.flickable: TextArea {
                id: command_line

                signal submitted(string command);

                function submit() {
                    if (!isEmpty()) {
                        root.submitted(text);
                        command_line.clear();
                    }
                }

                function isEmpty() {
                    return (text.length === 0 || !text.trim());
                }

                placeholderText: qsTr("Enter Javascript code ...")
                selectByMouse: true
                wrapMode: TextEdit.Wrap
                textFormat: TextEdit.PlainText
                font.family: "Menlo"

                Keys.onEnterPressed: submit()

                /*
                  Without this code, the editor respects the original distinction between Return
                  and Enter: Return creates a new line, while Enter executes the code.
                  However, this behaviour may be unfamiliar to most user. Uncomment this to
                  enable the alternative mapping: Shift-Return creates a new line, Return and Enter
                  execute the code.
                */
                Keys.onReturnPressed: {
                    if ((event.modifiers & Qt.ShiftModifier) == 0) {
                        submit();
                    } else {
                        event.accepted = false;
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }

        Controls.Button {
            id: button

            text: qsTr("Enter")
            flat: true
            highlighted: true
            onClicked: command_line.submit()
        }           
    }
}