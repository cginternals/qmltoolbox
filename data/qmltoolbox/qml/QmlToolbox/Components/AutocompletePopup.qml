
import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import QmlToolBox.Controls 1.0 as Controls
import QmlToolBox.Base 1.0


/**
*  AutocompletePopup
*
*  This item shows a list of configurable labels within 
*  a popup intended for autocompletion.
*/
Controls.Popup 
{
    id: root

    signal selected(int index)

    // Maximum number of visible list elements
    property int maxVisibleElements: 4

    // Access to the list view model
    property alias model: list_view.model

    // Access to the list view
    property alias list: list_view

    width: 200
    height: calculateHeight()

    padding: 0
    closePolicy: Popup.CloseOnPressOutside


    Label 
    { 
        id: font_label 
    }

    ListView 
    {
        id: list_view

        anchors.fill: parent

        verticalLayoutDirection: ListView.BottomToTop
        boundsBehavior: Flickable.StopAtBounds
        clip: true


        ScrollIndicator.vertical: ScrollIndicator { }

        delegate: ItemDelegate 
        {
            width: parent.width
            height: root.rowHeight()
            topPadding: 0
            bottomPadding: 0

            text: modelData
            highlighted: ListView.isCurrentItem

            onClicked: list_view.select(index)

            DebugItem { }
        }

        Keys.onReturnPressed: 
        {
            select(currentIndex);
            event.accepted = true;
        }

        Keys.onEscapePressed: 
        {
            root.close();
        }

        function select(index) 
        {
            root.selected(index);
            root.close();
        }
    }


    /**
    *  Retrieve height of single row in pixels
    */
    function rowHeight() 
    {
        return font_label.font.pixelSize * 2.0;
    }

    /**
    *  Calculate height of this popup based on number of currently visible or
    *  maximum visible items.
    */
    function calculateHeight()
    {
        var count = Math.min(model.length, maxVisibleElements);
        return count * rowHeight();
    }
}
