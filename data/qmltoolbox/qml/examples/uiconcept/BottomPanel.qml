
import QmlToolbox.Controls 1.0
import QmlToolbox.Components 1.0

Panel
{
    position:    'bottom'
    minimumSize: 150

    readonly property alias scriptConsole: scriptConsole

    ScriptConsole
    {
        id: scriptConsole

        anchors.fill: parent

        keywords: ["console", "Math", "Date", "if", "for", "while", "function", "exit"]

        onSubmitted:
        {
            scriptConsole.output("> " + command + "\n");
            var res = eval(command);

            if (res !== undefined)
            {
                console.log(scriptConsole.prettyPrint(res));
            }
        }
    }

    ToolButton
    {
        anchors.right: parent.right
        anchors.top: parent.top

        contentItem: Image
        {
            source: "icons/icon_close_sidebar.svg"
        }

        background.visible: hovered

        onClicked: bottomPanel.setVisible(false)
    }
}
