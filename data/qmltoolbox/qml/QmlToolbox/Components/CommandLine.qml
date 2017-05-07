
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import QmlToolbox.Controls 1.0


/**
*  CommandLine
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
    property alias autocompleteModel: autocomplete.model

    // Height of the text element
    property real textHeight: flickable.contentHeight

    implicitWidth:  flickable.implicitWidth
    implicitHeight: flickable.implicitHeight

    Flickable
    {
        id: flickable

        anchors.fill:   parent
        implicitHeight: contentHeight

        boundsBehavior: Flickable.StopAtBounds
        clip:           true

        ScrollIndicator.vertical: ScrollIndicator
        {
        }

        TextArea.flickable: TextArea
        {
            id: input

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

            /**
             * Without this code, the editor respects the original distinction between Return
             * and Enter: Return creates a new line, while Enter executes the code.
             * However, this behaviour may be unfamiliar to most user. Uncomment this to
             * enable the alternative mapping: Shift-Return creates a new line, Return and Enter
             * execute the code.
             */
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
                cursorPosition = length;
            }

            function isEmpty()
            {
                return (text.length == 0 || !text.trim());
            }
        }
    }

    AutocompletePopup
    {
        id: autocomplete

        y:     flickable.y - (height + 12)
        width: 200

        onSelected:
        {
            input.insert(input.length, model[index]);
        }
    }
}
