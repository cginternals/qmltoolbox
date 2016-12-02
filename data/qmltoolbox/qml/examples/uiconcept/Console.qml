
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
        "Warning": "#81A2BE",
        "Error": "#DE935F",
        "Info": "#808080",
        "Command": "#B4E15E"
    }

    function addLine(text, type) {
        var lines = text.split("\n");

        for (var line in lines) {
            text_edit.append(coloredText(lines[line], type));
        }

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

    property var model: ConsoleModel {}
    
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
            contentY = contentHeight - height
        }

        anchors.fill: parent
        contentHeight: text_edit.height

        clip: true
        boundsBehavior: Flickable.StopAtBounds

        TextEdit {
            id: text_edit

            readOnly: true
            selectByMouse: true 
            selectionColor: root.selectionColor

            color: defaultColor
            textFormat: TextEdit.RichText
            font.family: "Menlo"

            onCursorRectangleChanged: flickable.ensureVisible(cursorRectangle)

            Component.onCompleted: {
                for (var j = 0; j < 1; ++j) {
                    for (var i = 0; i < model.count; ++i) {
                        var element = model.get(i);

                        root.addLine(element.text, element.type);
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            Component.onCompleted: {
                contentItem.color = "#3F4042"
            }
        }
    }
}