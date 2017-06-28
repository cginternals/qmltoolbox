
import QtQuick 2.4
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Text input with optional dropdown menu, can also display a list of images
*
*  Default implementation of ComboBox using Controls 2.0
*/
ComboBox 
{
    id: item

    property var pixmaps: null ///< List of image URLs for each element (must match the length of model)

    contentItem: pixmaps !== null ? pixmapContent  : defaultContent
    delegate:    pixmaps !== null ? pixmapDelegate : defaultDelegate

    DebugItem
    {
    }

    property Item pixmapContent: Image
    {
        source: item.pixmaps !== null ? item.pixmaps[item.currentIndex] : ''
    }

    property Item defaultContent: Text
    {
        text:                item.displayText
        font:                item.font
        horizontalAlignment: Text.AlignLeft
        verticalAlignment:   Text.AlignVCenter
        elide:               Text.ElideRight
    }

    Component
    {
        id: pixmapDelegate

        ItemDelegate
        {
            width: item.width

            contentItem: Image
            {
                width:  item.width
                height: item.height
                source: item.pixmaps[index]
            }

            highlighted: item.highlightedIndex === item.index
        }
    }

    Component
    {
        id: defaultDelegate

        ItemDelegate
        {
            width: item.width

            contentItem: Text
            {
                text: modelData
                font: item.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

            highlighted: item.highlightedIndex === index
        }
    }
}
