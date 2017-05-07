
pragma Singleton


import QtQuick 2.0

import QmlToolbox.Base 1.0


/**
*  Ui
*
*  Global options for the UI, e.g., debug mode
*/
Item
{
    id: item

    // Debug mode
    property bool debugMode: false

    // Debug color (e.g., used for outlining items)
    property color debugColor: '#ff00aa'

    property QtObject style: QtObject
    {
        property real mediumPadding: 12

        property real panePadding: 12

        property color panelHandleColor: '#66666666'

        property real  scrollBarSize:       10
        property real  scrollBarPadding:    2
        property real  scrollBarRadius:     2
        property color scrollBarColor:      '#888888'
        property color scrollBarHoverColor: '#aaaaaa'

        property string consoleFontFamily:        'Menlo'
        property color  consoleTextColor:         '#c5c8c6'
        property color  consoleTextColorFatal:    '#ff5e58'
        property color  consoleTextColorCritical: '#ff5e58'
        property color  consoleTextColorWarning:  '#ecc674'
        property color  consoleTextColorDebug:    '#c5c8c6'
        property color  consoleTextColorCommand:  '#c5c8c6'
        property color  consoleBackgroundColor:   '#1d1f21'
        property color  consoleSelectionColor:    '#3f4042'

        property color disabledColor:   '#777777'

        property color textAreaColor:   '#ffffff'
        property int   textAreaPadding: 8

        property color itemColor:            '#ffffff'
        property color itemColorHighlighted: '#dddddd'
        property int   itemPadding:          4
    }
}
