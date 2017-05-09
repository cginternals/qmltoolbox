
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


/**
*  ScrollArea
*
*  Item with scrollable content and scroll bars
*/
Flickable
{
    id: item

    Component
    {
        id: scrollBar

        ScrollBar
        {
        }
    }

    Component.onCompleted:
    {
        item.ScrollBar.horizontal = scrollBar.createObject(item, {} );
        item.ScrollBar.vertical   = scrollBar.createObject(item, {} );
    }
}
