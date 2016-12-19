
import QtQml.Models 2.2

import QtQuick 2.7
import QtQuick.Layouts 1.3 

import QmlToolBox.Controls 1.0
import QmlToolBox.Components 1.0


ApplicationWindow
{
    id: window

    width: 800
    height: 600

    visible: true

    header: ToolBar 
    {
        id: toolbar

        Button 
        {
            id: button

            text: "button"
            onClicked: { autocomplete.open() }

            Keys.forwardTo: [ autocomplete.list ]
        }
    }

    AutocompletePopup
    {
        id: autocomplete

        y: toolbar.y + toolbar.height

        model: [ "item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8" ]
    }
}
