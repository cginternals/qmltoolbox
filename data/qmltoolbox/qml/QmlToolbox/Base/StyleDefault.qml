
import QtQuick 2.0


/**
*  Style
*
*  Defines the visual style for the application (e.g., colors, and sizes)
*/
Item
{
    //
    // General
    //

    property real  paddingTiny:          2         // Tiny padding (e.g., inside controls)
    property real  paddingSmall:         4         // Small padding
    property real  paddingMedium:        8         // Default padding
    property real  paddingLarge:         12        // Large padding

    property int   fontSizeSmall:        12        // Small text size
    property int   fontSizeMedium:       16        // Default text size
    property int   fontSizeLarge:        20        // Large text size

    property color backgroundColor:      '#ffffff' // Background color of the main window
    property color disabledColor:        '#777777' // Color of disabled texts

    property color controlColor:         '#888888' // Color of controls (e.g., scroll bar)
    property color controlColorHovered:  '#aaaaaa' // Color of controls when hovered
    property color textAreaColor:        '#ffffff' // Background color of text input fields

    property real  scrollBarSize:        10        // Size of scrollbars
    property real  scrollBarRadius:      2         // Edge radius of scrollbars

    property color itemColor:            '#ffffff' // Color of menu items
    property color itemColorHighlighted: '#dddddd' // Color of menu items when highlighted

    property color debugColor:           '#ff00aa' // Color of debug outline


    //
    // Scripting Console
    //

    property string consoleFontFamily:        'Menlo'   // Font used in scripting console
    property color  consoleBackgroundColor:   '#1d1f21' // Background color
    property color  consoleTextColor:         '#c5c8c6' // Default text color
    property color  consoleSelectionColor:    '#3f4042' // Color of selected text
    property color  consoleTextColorCritical: '#ff5e58' // Text color for critical errors
    property color  consoleTextColorError:    '#ff5e58' // Text color for errors
    property color  consoleTextColorWarning:  '#ecc674' // Text color for warnings


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

    property color pipelineLineColorDefault:     '#000000' // Color of connections
    property color pipelineLineColorHighlighted: '#6688c8' // Color of connections when highlighted
    property color pipelineLineColorSelected:    '#c83366' // Color of connections when selected
}
