import QtQuick 2.6

Text {

    text: "label"

    //make sure we have an 8-grid alignment
    lineHeight: 24 - bottomPadding
    lineHeightMode: Text.FixedHeight

    verticalAlignment: Text.AlignBottom

    bottomPadding: -3

    color: "#606060"
    font.family: "Roboto"
    font.pixelSize: 13
}
