
import QtQuick 2.0


/**
*  Style
*
*  Defines the visual style for the application (e.g., colors, and sizes)
*/
Item
{
    //
    // Generic colors (to be reused)
    //

    property color primaryColor:   '#ffffff' // Color used for main text
    property color highlightColor: '#fd971f' // Color used for highlighted text and elements
    property color pressedColor:   '#ffffd9' // Color used for pressed elements
    property color disabledColor:  '#999999' // Color used for disabled elements


    //
    // General
    //

    property color backgroundColor:    '#1a1d23'    // Main window background color

    property color textColor:          primaryColor // Primary text color
    property color linkColor:          '#aaaaff'    // Link color

    property int   fontSizeSmall:      12           // Small text size
    property int   fontSizeMedium:     16           // Default text size
    property int   fontSizeLarge:      20           // Large text size

    property real  iconSizeSmall:      16           // Small icon size
    property real  iconSizeMedium:     20           // Default icon size
    property real  iconSizeLarge:      24           // Large icon size

    property real  paddingSmall:       4            // Small padding
    property real  paddingMedium:      8            // Default padding
    property real  paddingLarge:       12           // Large padding

    property real  spacingSmall:       4            // Small padding
    property real  spacingMedium:      8            // Default padding
    property real  spacingLarge:       12           // Large padding


    //
    // Main Ui
    //

    property int   controlFontSize:            fontSizeMedium   // Control text size
    property int   controlIconSize:            iconSizeSmall    // Control icon size
    property real  controlPadding:             paddingSmall     // Control padding (space between border and items)
    property real  controlSpacing:             paddingSmall     // Control spacing (space between items in the control)
    property int   controlBorderWidth:         0                // Control border width
    property real  controlBorderRadius:        0                // Control border radius

    property color controlColor:               backgroundColor  // Control background color (default)
    property color controlColorDisabled:       backgroundColor  // Control background color (disabled)
    property color controlColorSelected:       backgroundColor  // Control background color (selected)
    property color controlColorHover:          backgroundColor  // Control background color (hovered)
    property color controlColorPressed:        backgroundColor  // Control background color (pressed)

    property color controlBorderColor:         'transparent'    // Control border color (default)
    property color controlBorderColorDisabled: 'transparent'    // Control border color (disabled)
    property color controlBorderColorSelected: 'transparent'    // Control border color (selected)
    property color controlBorderColorHover:    'transparent'    // Control border color (hovered)
    property color controlBorderColorPressed:  'transparent'    // Control border color (pressed)

    property color controlTextColor:           primaryColor     // Control text color (default)
    property color controlTextColorDisabled:   disabledColor    // Control text color (disabled)
    property color controlTextColorSelected:   highlightColor   // Control text color (selected)
    property color controlTextColorHover:      highlightColor   // Control text color (hovered)
    property color controlTextColorPressed:    pressedColor     // Control text color (pressed)

    property color controlIconColor:           highlightColor   // Control icon color (default)
    property color controlIconColorDisabled:   disabledColor    // Control icon color (disabled)
    property color controlIconColorSelected:   highlightColor   // Control icon color (selected)
    property color controlIconColorHover:      highlightColor   // Control icon color (hovered)
    property color controlIconColorPressed:    pressedColor     // Control icon color (pressed)

    property color frameColor:                 '#2a2d33'        // Background color for frames
    property color frameBorderColor:           '#000000'        // Background color for frame borders
    property int   frameBorderWidth:           1                // Size of frame borders
    property int   frameBorderRadius:          2                // Radius of frame borders


    //
    // Controls and Dialogs
    //

    property color windowColor:            backgroundColor // Background color for windows and dialogs
    property color panelColor:             '#2a2d33'       // Background color for panels inside a window
    property color panelColorAlt:          '#2a2d33'       // Alternative background color for panels
    property color buttonTextColor:        '#000000'       // Text color on standard buttons

    property color borderColor:            '#000000'       // Color of borders
    property int   borderWidth:            1               // Size of borders
    property int   borderRadius:           2               // Radius of borders

    property color panelItemColor:         panelColor      // Panel item color (default)
    property color panelItemColorDisabled: panelColor      // Panel item color (disabled)
    property color panelItemColorSelected: '#444444'       // Panel item color (highlighted)
    property color panelItemColorHover:    '#555555'       // Panel item color (hovered)
    property color panelItemColorPressed:  '#444444'       // Panel item color (pressed)


    //
    // Pipeline Editor
    //

    property color pipelineStageColor:           '#b6bfc8' // Background color of stages
    property int   pipelineStageRadius:          4         // Radius of stage rectangle
    property color pipelineStageTextColor:       '#000000' // Color of texts in stages

    property color pipelineTitleColor:           '#4f9e71' // Background color of stage titles
    property color pipelineTitleColor2:          '#fdca00' // Background color of stage titles
    property color pipelineTitleTextColor:       '#ffffff' // Color of texts in titles

    property color pipelineBorderColor:          '#000000' // Border color for stages, slots, etc.
    property int   pipelineBorderWidth:          1         // Border width for stages, slots, etc.

    property real  pipelineSlotSize:             20        // Diameter of slots
    property color pipelineSlotColorIn:          '#ffffff' // Color of input slots
    property color pipelineSlotColorOut:         '#cafd00' // Color of output slots

    property color pipelineLineColorDefault:     '#ffffff' // Color of connections
    property color pipelineLineColorHighlighted: '#6688c8' // Color of connections when highlighted
    property color pipelineLineColorSelected:    '#c83366' // Color of connections when selected


    //
    // Debug
    //

    property color debugColor: '#00ff00' // Color of debug rectangle
}
