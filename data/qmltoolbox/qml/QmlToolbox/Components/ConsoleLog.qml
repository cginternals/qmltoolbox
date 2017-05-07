
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Base 1.0
import QmlToolbox.Controls 1.0


/**
*  ConsoleLog
*
*  A text window that displays a log of messages.
*  It supports pre-defined as well as custom highlighting colors.
*/
Pane
{
    id: item

    background: Rectangle
    {
        color: Ui.style.consoleBackgroundColor
    }

    ScrollArea
    {
        id: scrollArea

        anchors.fill: parent

        clip:           true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight:  textEdit.paintedHeight

        TextEdit
        {
            id: textEdit

            width: parent.width

            readOnly:       true
            color:          Ui.style.consoleTextColor
            wrapMode:       TextEdit.Wrap
            textFormat:     TextEdit.RichText
            font.family:    Ui.style.consoleFontFamily
            selectByMouse:  true
            selectionColor: Ui.style.consoleSelectionColor

            onCursorRectangleChanged:
            {
                scrollArea.ensureVisible(cursorRectangle);
            }
        }

        function ensureVisible(r)
        {
            if (contentX >= r.x) {
                contentX = r.x;
            }
            else if (contentX+width <= r.x+r.width) {
                contentX = r.x+r.width-width;
            }

            if (contentY >= r.y) {
                contentY = r.y;
            }
            else if (contentY+height <= r.y+r.height) {
                contentY = r.y+r.height-height;
            }
        }

        function positionAtEnd()
        {
            if (contentHeight > height) {
                contentY = contentHeight - height;
            }
        }
    }

    function output(text, type)
    {
        var lines = text.split("\n");

        for (var i=0; i<lines.length-1; i++)
        {
            textEdit.insert(textEdit.length, coloredText(lines[i], type));
            textEdit.insert(textEdit.length, "<br>")
        }

        textEdit.insert(textEdit.length, coloredText(lines[lines.length - 1], type));

        scrollArea.positionAtEnd();
    }

    function colorForType(type)
    {
        if (type === 'Fatal')    return Ui.style.consoleTextColorFatal;
        if (type === 'Critical') return Ui.style.consoleTextColorCritical;
        if (type === 'Warning')  return Ui.style.consoleTextColorWarning;
        if (type === 'Debug')    return Ui.style.consoleTextColorDebug;
        if (type === 'Command')  return Ui.style.consoleTextColorCommand;

        return Ui.style.consoleTextColor;
    }

    function coloredText(text, type)
    {
        return "<font color='" + colorForType(type) + "'>" + text + "</font>"
    }
}
