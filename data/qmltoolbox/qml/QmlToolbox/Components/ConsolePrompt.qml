
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  ConsolePrompt
*
*  A multi-line command line including autocompletion and history.
*  Controls:
*  - Shift+Enter inserts new line
*  - Shift+[Up|Down] navigate through history
*  - Tab opens autocompletion
*/
Control
{
    id: item

    // Called when a command has been entered
    signal submitted(string command)

    // List of auto-completion words (array of strings)
    property alias keywords: autocomplete.model

    // Height of the text element
    property real textHeight: input.height

    implicitWidth:  input.implicitWidth
    implicitHeight: input.implicitHeight

    TextArea
    {
        id: input

        anchors.fill: parent

        signal submitted(string command);

        property var    commandHistory:  []
        property int    historyIndex:    -1
        property string lastUnsavedText: ''

        placeholderText: qsTr("Enter Javascript code ...")
        wrapMode:        TextEdit.Wrap
        textFormat:      TextEdit.PlainText
        selectByMouse:   true

        // Workaround for default theme: TextArea not visible (probably bug)
        text: '_'
        Component.onCompleted: clear()

        // Keyboard handling
        Keys.forwardTo: [ autocomplete.listItem ]

        Keys.onUpPressed:
        {
            moveUpInHistory();
        }

        Keys.onDownPressed:
        {
            moveDownInHistory();
        }

        Keys.onTabPressed:
        {
            autocomplete.open();
        }

        Keys.onEnterPressed:
        {
            submit();
        }

        Keys.onReturnPressed:
        {
            if ((event.modifiers & Qt.ShiftModifier) == 0)
            {
                submit();
            }
            else
            {
                event.accepted = false;
            }
        }

        function submit()
        {
            if (!isEmpty())
            {
                item.submitted(text);

                commandHistory.unshift(text);
                historyIndex = -1;

                input.clear();
            }
        }

        function moveUpInHistory()
        {
            if (historyIndex == -1) {
                lastUnsavedText = text;
            }

            if (historyIndex < commandHistory.length - 1) {
                historyIndex += 1;
            }

            updateText();
        }

        function moveDownInHistory()
        {
            if (historyIndex == -1) {
                lastUnsavedText = text;
            }

            if (historyIndex >= 0) {
                historyIndex -= 1;
            }

            updateText();
        }

        function updateText()
        {
            if (historyIndex < 0) {
                text = lastUnsavedText;
                return;
            }

            text = commandHistory[historyIndex];
            input.cursorPosition = length;
        }

        function isEmpty()
        {
            return (text.length == 0 || !text.trim());
        }
    }

    SelectionPopup
    {
        id: autocomplete

        parent: item

        y:     input.y - (height + Ui.style.largePadding)
        width: 200

        onSelected:
        {
            input.insert(input.length, model[index]);
            input.forceActiveFocus();
        }
    }
}
