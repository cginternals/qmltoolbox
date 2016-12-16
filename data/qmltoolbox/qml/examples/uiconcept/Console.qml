
import QtQuick 2.7
import QtQuick.Layouts 1.3

import QtQuick.Controls 2.0
import QmlToolBox.Controls2 1.0 as Controls

Controls.Pane {
    id: root

    property color defaultColor: "#C5C8C6";
    property color backgroundColor: "#1D1F21";
    property color selectionColor: "#3F4042"

    property var highlightingColors: {
        "Debug": "#81A2BE",
        "Warning": "#DE935F",
        "Critical": "#808080",
        "Fatal": "#808080",
        "Command": "#B4E15E"
    }

    function append(text, type) {
        var lines = text.split("\n");

        for (var i = 0; i < lines.length - 1; i++) {
            text_edit.insert(text_edit.length, coloredText(lines[i], type));
            text_edit.insert(text_edit.length, "<br>")
        }

        text_edit.insert(text_edit.length, coloredText(lines[lines.length - 1], type));

        flickable.positionAtEnd();
    }

    function colorForType(type) {
        if (type in highlightingColors)
            return highlightingColors[type];
        return defaultColor;
    }

    function coloredText(text, type) { 
        return "<font color='" + colorForType(type) + "'>" + text + "</font>"
    }
    
    background: Rectangle {
        color: root.backgroundColor;
    }

    Flickable {
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

        function positionAtEnd() {
            if (contentHeight > height)
                contentY = contentHeight - height;
        }

        anchors.fill: parent
        contentHeight: text_edit.height

        clip: true
        boundsBehavior: Flickable.StopAtBounds

        TextEdit {
            id: text_edit

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

        ScrollBar.vertical: ScrollBar {
            Component.onCompleted: {
                contentItem.color = "#3F4042"
            }
        }
    }
}