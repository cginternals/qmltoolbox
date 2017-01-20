
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolBox.Base 1.0
import QmlToolBox.Controls 1.0 as Controls

Controls.Pane {
    id: root

    property real textHeight: flickable.contentHeight
    property var autocompleteModel: null

    signal submitted(string command)

    RowLayout {
        anchors.fill: parent

        Flickable {
            id: flickable

            clip: true
            boundsBehavior: Flickable.StopAtBounds

            implicitHeight: contentHeight
            Layout.maximumHeight: 100
            Layout.fillWidth: true

            contentHeight: command_line.paintedHeight

            TextEdit {
                id: command_line

                property var commandHistory: []
                property int historyIndex: -1
                property string lastUnsavedText

                signal submitted(string command);

                function submit() {
                    if (!isEmpty()) {
                        root.submitted(text);
                        commandHistory.unshift(text);
                        historyIndex = -1;
                        command_line.clear();
                    }
                }

                function moveUpInHistory() {
                    if (historyIndex == -1)
                        lastUnsavedText = text;

                    if (historyIndex < commandHistory.length - 1)
                        historyIndex += 1;

                    updateText();
                }

                function moveDownInHistory() {
                    if (historyIndex == -1)
                        lastUnsavedText = text;

                    if (historyIndex >= 0)
                        historyIndex -= 1;

                    updateText();
                }

                function updateText() {
                    if (historyIndex < 0) {
                        text = lastUnsavedText;
                        return;
                    }

                    text = commandHistory[historyIndex];
                    cursorPosition = length;
                }

                function isEmpty() {
                    return (text.length === 0 || !text.trim());
                }

                selectByMouse: true
                wrapMode: TextEdit.Wrap
                textFormat: TextEdit.PlainText
                font.family: "Menlo"
                width: flickable.width

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

                Keys.onUpPressed: {
                    if ((event.modifiers & Qt.ShiftModifier)) {
                        moveUpInHistory();
                    } else {
                        event.accepted = false;
                    }
                }

                Keys.onDownPressed: {
                    if ((event.modifiers & Qt.ShiftModifier)) {
                        moveDownInHistory();
                    } else {
                        event.accepted = false;
                    }
                }

                // Work around for default theme: TextArea not visible (probably bug)
                text: "_"
                Component.onCompleted: clear()
            }

            DebugItem { }
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