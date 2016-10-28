
import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    property alias from: slider.minimumValue
    property alias to: slider.maximumValue
    property alias value: slider.value
    property alias stepSize: slider.stepSize

    implicitHeight: slider.implicitHeight
    implicitWidth: slider.implicitWidth

    Slider {
        id: slider

        anchors.fill: parent
        updateValueWhileDragging: false
    }
}