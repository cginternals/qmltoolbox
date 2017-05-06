
import QtQuick 2.4
import QtQuick.Layouts 1.1

import QmlToolbox.Controls 1.0


/**
*  Panel
*
*  A resizable side panel
*/
Item
{
    id: item

    default property alias data: content.data

    property string position:    'left'                                    ///< Position of the panel ('left', 'right', 'top', 'bottom')
    property real   size:        200                                       ///< Current size (width/height) of the panel
    property real   minimumSize: 5                                         ///< Mininum size (width/height) of the panel
    property real   maximumSize: horizontal ? parent.width : parent.height ///< Maxinum size (width/height) of the panel

    readonly property bool horizontal: (item.position === 'left' || item.position === 'right')
    readonly property bool vertical:   (item.position === 'top'  || item.position === 'bottom')

    width:  horizontal ? Math.max(Math.min(size, maximumSize), minimumSize) : 0
    height: vertical   ? Math.max(Math.min(size, maximumSize), minimumSize) : 0

    implicitWidth:  content.implicitWidth
    implicitHeight: content.implicitHeight

    clip: true

    function togglePanel()
    {
        item.visible = !item.visible;
    }

    function isPanelVisible()
    {
        return item.visible;
    }

    function setPanelVisibility(visible)
    {
        item.visible = visible;
    }

    Item
    {
        id: content

        anchors.fill: parent

        implicitWidth:  children.length == 1 ? children[0].implicitWidth  : 0
        implicitHeight: children.length == 1 ? children[0].implicitHeight : 0
    }

    MouseArea
    {
        id: handle

        width:  5
        height: 5

        cursorShape: item.vertical ? Qt.SplitVCursor : Qt.SplitHCursor

        property int  lastPos: 0
        property bool pressed: false

        Rectangle
        {
            anchors.fill: parent
            anchors.margins: 2

            color: '#66666666'
        }

        onPressed:
        {
            if (item.horizontal) lastPos = mouse.x;
            else                 lastPos = mouse.y;

            pressed = true;
        }

        onReleased:
        {
            pressed = false;
        }

        onPositionChanged:
        {
            if (pressed)
            {
                var delta = 0;

                if (item.position === 'left')   delta =   (mouse.x - lastPos);
                if (item.position === 'right')  delta = - (mouse.x - lastPos);
                if (item.position === 'top')    delta =   (mouse.y - lastPos);
                if (item.position === 'bottom') delta = - (mouse.y - lastPos);

                item.size = Math.max(Math.min(item.size + delta, item.maximumSize), item.minimumSize);
            }
        }
    }

    Item
    {
        state: item.position

        states: [
            State {
                name: 'left'

                AnchorChanges
                {
                    target: item

                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom
                    anchors.left:   parent.left
                }

                AnchorChanges
                {
                    target: handle

                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom
                    anchors.right:  parent.right
                }
            },

            State {
                name: 'right'

                AnchorChanges
                {
                    target: item

                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom
                    anchors.right:  parent.right
                }

                AnchorChanges
                {
                    target: handle

                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom
                    anchors.left:   parent.left
                }
            },

            State {
                name: 'top'

                AnchorChanges
                {
                    target: item

                    anchors.left:   parent.left
                    anchors.right:  parent.right
                    anchors.top:    parent.top
                }

                AnchorChanges
                {
                    target: handle

                    anchors.bottom: parent.bottom
                    anchors.left:   parent.left
                    anchors.right:  parent.right
                }
            },

            State {
                name: 'bottom'

                AnchorChanges
                {
                    target: item

                    anchors.left:   parent.left
                    anchors.right:  parent.right
                    anchors.bottom: parent.bottom
                }

                AnchorChanges
                {
                    target: handle

                    anchors.top:    parent.top
                    anchors.left:   parent.left
                    anchors.right:  parent.right
                }
            }
        ]
    }
}
