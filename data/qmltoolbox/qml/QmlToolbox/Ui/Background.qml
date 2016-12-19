
import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Background
*
*  Single-colored background.
*
*  If custom OpenGL rendering is used in a pre-render step,
*  a background element would overdraw the whole scene.
*  In such case, renderBackground should be set to false and
*  the property backgroundColor can be used by the custom
*  rendering implementation to clean the screen with the
*  desired color. For this to work, the Background item
*  must be the root item of the scene.
*/
BaseItem
{
    id: item

    property color backgroundColor:  Ui.style.backgroundColor
    property bool renderBackground: true


    Rectangle
    {
        id: background

        anchors.fill: parent

        visible: item.renderBackground
        color:   item.backgroundColor
    }
}
