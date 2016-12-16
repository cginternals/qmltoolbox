
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
        id: toolBar
    }

    ColumnLayout
    {
        spacing: 2

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

        y: button.y + button.height

        model: [ "moep", "foo", "bar" ]
    }
}
