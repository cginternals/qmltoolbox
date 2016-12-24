
import QtQml.Models 2.2

import QtQuick 2.7
import QtQuick.Layouts 1.3 

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


        Label { text: "Application Window" }

        Label { text: "This window is an ApplicationWindow." }


        Label { text: "Button" }

        Button 
        {
            text: "Button 1"
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


        Label { text: "Check Box" }

        CheckBox
        {
            checked: Ui.debugMode

            text: "enable Debug Mode"

            onClicked: Ui.debugMode = !Ui.debugMode;
        }


        Label { text: "Combo Box" }

        ComboBox 
        {
            model: [ "First", "Second", "Third" ]
        }


        Label { text: "Label" }

        Label
        {
            text: "Don't label me."
        }


        Label { text: "Label with Link" }

        Label
        { 
            textFormat: Text.RichText 

            text: "<a href=\"https://github.com/cginternals/qmltoolbox\">QML item library</a> for cross-platform graphics applications ..."

            onLinkActivated: console.log(link)
        }

        
        Label { text: "Menu" }

        Button
        {
            id: menuButton

            text: "Button 2 to trigger Menu"
            onClicked: menu.open()

            Menu 
            {
                id: menu
                y: menuButton.height

                MenuItem { text: "item 1" }

                MenuItem { text: "item 2" }
            }
        }


        Label { text: "Radio Buttons" }

        RowLayout
        {
            Label { text: "What happens when you get 'scared half to death' twice?"}
            
            RadioButton { text: "1"; checked: true }
            RadioButton { text: "0" }
        }


        Label { text: "Slider" }

        RowLayout
        {
            Slider { id: slider } 
            
            Label { text: slider.value }
        }
        

        Label { text: "Switch" }

        Switch { text: "Switch 1" }


        Label { text: "Text Field" }

        TextField { placeholderText: "Type in me." }

        
        Label { text: "Toolbar  (not \"Tool Bar\")" }

        ToolBar 
        { 
            RowLayout 
            {
                anchors.fill: parent

                ToolButton { text: "Button 3" }
                ToolButton { text: "Button 4" }

                Switch { text: "Swtich 2"}
            }
        }
    }
}
