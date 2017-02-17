
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolBox.Base 1.0
import QmlToolBox.Controls 1.0 as Controls

/**
*  Console
*
*  A console designed to be used with QmlMessageForwarder.
*  It supports pre-defined as well as custom highlighting colors.
*/
Controls.Pane 
{
    id: root

    property color defaultColor: "#C5C8C6";
    property color backgroundColor: "#1D1F21"
    property color selectionColor: "#3F4042"

    property var highlightingColors: 
    {
        "Debug": "#C5C8C6",
        "Warning": "#ECC674",
        "Critical": "#FF5E58",
        "Fatal": "#FF5E58",
        "Command": "#C5C8C6"
    }

    function append(text, type) 
    {
        var lines = text.split("\n");

        for (var i = 0; i < lines.length - 1; i++) 
        {
            textEdit.insert(textEdit.length, coloredText(lines[i], type));
            textEdit.insert(textEdit.length, "<br>")
        }

        textEdit.insert(textEdit.length, coloredText(lines[lines.length - 1], type));

        flickable.positionAtEnd();
    }

    function colorForType(type) 
    {
        if (type in highlightingColors)
            return highlightingColors[type];
        return defaultColor;
    }

    function coloredText(text, type) 
    { 
        return "<font color='" + colorForType(type) + "'>" + text + "</font>"
    }
    
    background: Rectangle 
    {
        color: root.backgroundColor;
    }

    ScrollableFlickable 
    {
        id: flickable

        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }

        function positionAtEnd() 
        {
            if (contentHeight > height)
                contentY = contentHeight - height;
        }

        anchors.fill: parent

        contentHeight: textEdit.paintedHeight

        clip: true
        boundsBehavior: Flickable.StopAtBounds

        scrollBarColor: "#3F4042"
        verticalScrollbar: true
        horizontalScrollbar: false

        TextEdit 
        {
            id: textEdit

            width: flickable.width

            readOnly: true
            selectByMouse: true 
            selectionColor: root.selectionColor

            color: defaultColor
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.RichText
            font.family: "Menlo"

            onCursorRectangleChanged: flickable.ensureVisible(cursorRectangle)
        }
    }
}