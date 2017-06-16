
import QtQuick 2.0
import QtQuick.Controls 1.1

import QmlToolbox.Base 1.0
    

/**
*  RangeSlider
*
*  Horizontal slider for selecting a minimum and a maximum number
*
*  Fallback implementation of RangeSlider for Qt < 5.7
*/
Item
{
    id: item

    signal valuesChanged(real firstValue, real secondValue);

    property real firstValue:  0.0
    property real secondValue: 1.0
    property real from:        0.0
    property real to:          1.0
    property bool live:        false

    property real  barSize:    8
    property real  handleSize: 18
    property color backgroundColor: '#aaaaaa'
    property color handleColor:     '#dddddd'
    property color borderColor:     '#555555'
    property color selectColor:     '#3388bb'

    Rectangle
    {
        id: bar

        anchors.left:           parent.left
        anchors.right:          parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins:        0.5 * item.handleSize

        height: item.barSize

        color:        item.backgroundColor
        border.color: item.borderColor
        border.width: 1
        radius:       10

        clip: true

        Rectangle
        {
            color: item.selectColor

            x:      parent.width * (item.firstValue - item.from) / (item.to - item.from)
            y:      1
            width:  parent.width * (item.secondValue - item.from) / (item.to - item.from) - x
            height: parent.height - 2
        }

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                if (mouse.x < firstHandle.x)
                {
                    item.firstValue = item.from + (mouse.x / width) * (item.to - item.from);
                }

                else if (mouse.x > secondHandle.x)
                {
                    item.secondValue = item.from + (mouse.x / width) * (item.to - item.from);
                }
            }
        }
    }

    Rectangle
    {
        id: firstHandle

        property real handlePos: firstHandleMA.drag.active ? 0 : ((item.firstValue - item.from) / (item.to - item.from)) * bar.width

        anchors.verticalCenter: parent.verticalCenter

        x:      handlePos
        width:  radius
        height: radius

        color:        item.handleColor
        border.color: item.borderColor
        border.width: 1
        radius:       item.handleSize

        MouseArea
        {
            id: firstHandleMA

            anchors.fill: parent

            drag.target:   firstHandle
            drag.minimumX: 0
            drag.maximumX: secondHandle.handlePos
            drag.minimumY: 0
            drag.maximumY: 0

            onReleased:
            {
                item.promoteValues();
            }
        }

        onXChanged:
        {
            if (firstHandleMA.drag.active)
            {
                item.firstValue = item.from + (x / bar.width) * (item.to - item.from);
                if (item.live) item.promoteValues();
            }
        }
    }

    Rectangle
    {
        id: secondHandle

        property real handlePos: secondHandleMA.drag.active ? 0 : ((item.secondValue - item.from) / (item.to - item.from)) * bar.width

        anchors.verticalCenter: parent.verticalCenter

        x:      handlePos
        width:  radius
        height: radius

        color:        item.handleColor
        border.color: item.borderColor
        border.width: 1
        radius:       item.handleSize

        MouseArea
        {
            id: secondHandleMA

            anchors.fill: parent

            drag.target:   secondHandle
            drag.minimumX: firstHandle.handlePos
            drag.maximumX: bar.width
            drag.minimumY: 0
            drag.maximumY: 0

            onReleased:
            {
                item.promoteValues();
            }
        }

        onXChanged:
        {
            if (secondHandleMA.drag.active)
            {
                item.secondValue = item.from + (x / bar.width) * (item.to - item.from);
                if (item.live) item.promoteValues();
            }
        }
    }

    DebugItem
    {
    }

    function promoteValues()
    {
        item.valuesChanged(item.firstValue, item.secondValue);
    }
}
