
import QtQuick 2.4
import QtQuick.Layouts 1.0

import QmlToolbox.Base 1.0
import QmlToolBox.Controls 1.0
import QmlToolBox.Components 1.0


ApplicationWindow
{
    id: window

    width: 640
    height: 512

    visible: true

    ScrollableFlickable 
    {
        anchors.fill: parent

        boundsBehavior: Flickable.StopAtBounds

        contentHeight: pane.height
        contentWidth: pane.width

        verticalScrollbar: true
        horizontalScrollbar: true

        Pane 
        {
            id: pane

            GridLayout 
            {
                id: grid

                anchors.fill: parent

                columns: 2
                columnSpacing: 16
                rowSpacing: 8


                Item
                {
                    Layout.columnSpan: 2
                    Layout.fillHeight: true
                }

                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Button" 
                }

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


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Check Box" 
                }

                CheckBox
                {
                    text: "enable Debug Mode"

                    checked: Ui.debugMode

                    onClicked: Ui.debugMode = !Ui.debugMode;
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Combo Box" 
                }

                ComboBox 
                {
                    model: [ "First", "Second", "Third" ]
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Label" 
                }

                Label
                {
                    text: "Do NOT label me."
                }


                Label 
                { 
                    Layout.alignment: Qt.AlignRight
                    text: "Label with Link" 
                }

                Label
                { 
                    text: "<a href=\"https://github.com/cginternals/qmltoolbox\">QML item library</a> for cross-platform graphics applications ..."
                    
                    textFormat: Text.RichText 

                    onLinkActivated: console.log(link)
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Menu" 
                }

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


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Radio Buttons" 
                }

                RowLayout
                {

                    Label { text: "What happens when you get 'scared half to death' twice?"}
                    
                    RadioButton { text: "1"; checked: true }
                    RadioButton { text: "0" }
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Slider" 
                }

                RowLayout
                {

                    Slider { id: slider } 
                    
                    Label { text: slider.value }
                }
                

                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Switch" 
                }

                Switch 
                {
                    text: "Switch 1" 
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Text Field" 
                }

                TextField 
                {
                    placeholderText: "Type in me." 
                }


                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Toolbar  (not \"Tool Bar\")" 
                }

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

                Label 
                {
                    Layout.alignment: Qt.AlignRight
                    text: "Popup Button" 
                }

                Button
                {
                    text: "Open"

                    onClicked: popup.open()

                    Popup
                    {
                        id: popup

                        width: popupLayout.implicitWidth + leftPadding + rightPadding
                        height: popupLayout.implicitHeight + bottomPadding + topPadding

                        RowLayout
                        {
                            id: popupLayout

                            Label 
                            { 
                                text: "Nice looking popup, isn't it? ;)"
                                wrapMode: Text.WordWrap
                            }

                            Button
                            {
                                text: "Close"
                                onClicked: popup.close()
                            }
                        }
                    }
                }
            }
        }
    }
}
