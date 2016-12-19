
import QtQml.Models 2.2

import QtQuick 2.7
import QtQuick.Layouts 1.3 
//import QtQuick.Controls 2.0 

import QmlToolbox.Base 1.0
import QmlToolBox.Controls 1.0
import QmlToolBox.Components 1.0


ApplicationWindow
{
    id: window

    width: 800
    height: 600

    visible: true

    GridLayout 
    {
        columns: 2

        Layout.fillWidth: true


        Text { text: "Button" }

        Button 
        {
            text: "button"
            property int numClicked: 0

            onClicked: 
            { 
                if(numClicked < 4)
                    text += " clicked";
                if(numClicked == 4)
                    text += " ... enough you fool!"
                numClicked++;
            }
        }


        Text { text: "CheckBox" }

        CheckBox
        {
            checked: Ui.debugMode

            text: "enable Debug Mode"

            onClicked: Ui.debugMode = !Ui.debugMode;
        }


        Text { text: "Label" }

        Label
        {
            text: "Some relevant Text here?"
        }

        
        Text { text: "Menu" }

        Button
        {
            id: menuButton

            text: "Button to trigger Menu"
            onClicked: menu.open()

            Menu 
            {
                id: menu
                y: menuButton.height

                MenuItem { text: "item 1" }
                MenuItem { text: "item 2" }
            }
        }


        Text { text: "Pane" }

        Pane
        {
            Text { text: "Life is panefull." }
        }

    }

/*  

Button 
        {
            id: buttonAutoComplete

            text: "button to auto complete [popup]"
            onClicked: { autocomplete.open() }

            Keys.forwardTo: [ autocomplete.list ]
        }

          ToolButton 
            {
                text: "tool button to menu"
                onClicked: menu.open()

                Menu 
                {
                    id: menu
                    y: toolbar.height

                    MenuItem { text: "item 1" }
                    MenuItem { text: "item 2" }
                }
            }


            Item { Layout.fillWidth: true }

            Label
            {
                text: "label"
            }

            Item { Layout.fillWidth: true }

            RadioButton 
            {
                text: "enabled"
            }


        }
    }



    AutocompletePopup
    {
        id: autocomplete

        y: buttonAutoComplete.y + buttonAutoComplete.height
        x: buttonAutoComplete.x

        model: [ "item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8" ]
    }

    */
}
