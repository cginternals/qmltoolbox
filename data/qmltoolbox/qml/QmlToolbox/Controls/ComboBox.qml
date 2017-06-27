
import QtQuick 2.4
import QtQuick.Controls 2.0

import QmlToolbox.Base 1.0


/**
*  ComboBox
*
*  Text input with optional dropdown menu
*
*  Default implementation of ComboBox using Controls 2.0
*/
ComboBox 
{
    id: item

    property var pixmaps: null;

    function displayPixmaps(pixmapList)
    {
        item.pixmaps = pixmapList;
        item.delegate = delegate;
        item.contentItem = contentItem.createObject(item, {});
    }

    DebugItem
    {
    }

    Component {
        id: delegate;
        ItemDelegate {
            width: item.width
            contentItem: Image {
                width: item.width
                height: item.height
                source: item.pixmaps[index]
            }
            highlighted: item.highlightedIndex === item.index
        }
    }

    Component {
        id: contentItem;
        Image {
            width: item.width
            height: item.height
            source: item.pixmaps[item.currentIndex]
        }
    }

}
