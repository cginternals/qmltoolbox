
import QtQuick 2.0

import QmlToolbox.Base 1.0

StyleDefault
{
    property color headlineColor: '#1d1f21'
    property color dimHeadlineColor: '#c4ccd5'
    property color textSignalColor: '#c0015d'
    property color backgroundSignalColor: '#0ef3f9'

    property font mainFont: Qt.font({
        pixelSize: Ui.style.fontSizeSmall,
        capitalization: Font.AllUppercase,
        letterSpacing: 1.2,
        family: "Montserrat Regular",
    });

    property font headlineFont: Qt.font({
        pixelSize: Ui.style.fontSizeLarge,
        letterSpacing: 1.2,
        family: "Montserrat Light"
    });

    property font labelFont: Qt.font({
        pixelSize: Ui.style.fontSizeSmall,
        capitalization: Font.Uppercase,
        letterSpacing: 1.2,
        family: "Roboto"
    });
    
    property font buttonFont: Qt.font({
        pixelSize: 11,
        letterSpacing: 1.1,
        family: "Roboto Medium"
    });
    
    property font dialogOptionFont: Qt.font({
        pixelSize: 14,
        capitalization: Font.AllUppercase,
        letterSpacing: 1.4,
        family: "Roboto",
        weight: Font.DemiBold
    });

    //load fonts
    //FontLoader { source: "./fonts/Inconsolata-Regular.ttf" }
    //FontLoader { source: "./fonts/Inconsolata-Bold.ttf" }

    FontLoader { source: "./fonts/Roboto-Regular.ttf" }
    FontLoader { source: "./fonts/Roboto-Medium.ttf" }

    FontLoader { source: "./fonts/Montserrat-Regular.ttf" }
    FontLoader { source: "./fonts/Montserrat-Light.ttf" }
}
