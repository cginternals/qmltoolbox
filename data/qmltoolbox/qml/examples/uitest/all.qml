
import QtQml.Models 2.2

import QtQuick 2.7
import QtQuick.Layouts 1.3 
//import QtQuick.Controls 2.0 

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

        RowLayout
        {
            anchors.fill: parent

            ToolButton 
            {
                text: "tool button"
                onClicked: menu.open()

                Menu 
                {
                    id: menu
                    y: toolbar.height

                    MenuItem { text: "item 1" }
                    MenuItem { text: "item 2" }
                }
            }

            Button 
            {
                id: buttonAutoComplete

                text: "auto complete"
                onClicked: { autocomplete.open() }

                Keys.forwardTo: [ autocomplete.list ]
            }

            Item { Layout.fillWidth: true }

            RadioButton 
            {
                text: "enabled"
            }

            CheckBox
            {
              text: "foo"
            }
        }
    }

    AutocompletePopup
    {
        id: autocomplete

        y: toolbar.y + toolbar.height
        x: buttonAutoComplete.x

        model: [ "item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8" ]
    }
}
