
import QtQuick 2.0
import QtQuick.Layouts 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0
import QmlToolbox.Components 1.0


/**
*  ScriptConsole
*
*  A scripting console
*/
ColumnLayout
{
    id: item

    // Called when a command has been entered
    signal submitted(string command)

    // List of auto-completion words (array of strings)
    property alias keywords: prompt.keywords

    spacing: 0

    ConsoleLog
    {
        id: log

        anchors.left:  parent.left
        anchors.right: parent.right

        Layout.minimumHeight: 50
        Layout.fillHeight:    true
        rightPadding:         0
    }

    ConsolePrompt
    {
        id: prompt

        anchors.left:  parent.left
        anchors.right: parent.right

        onSubmitted:
        {
            item.submitted(command);
        }
    }

    // Output text to the scripting console
    function output(text, type)
    {
        log.output(text, type);
    }

    // Transform anything into a nice representation
    function prettyPrint(something)
    {
        if (something === null)
        {
            return null;
        }

        if (typeof something === 'object')
        {
            return JSON.stringify(something);
        }

        return something.toString();
    }
}
