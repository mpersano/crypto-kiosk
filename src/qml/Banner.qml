import QtQuick 2.3
import "utils"

Rectangle {
    id: banner
    height: 80
    color: Style.colorBannerBackground

    Text {
        text: bannerText()
        color: Style.colorBannerText
        font.pointSize: Style.fontSizeS
        anchors.left: banner.left
        anchors.leftMargin: 32
        anchors.verticalCenter: banner.verticalCenter
    }

    function bannerText() {
        return "Current bitcoin price is " + controller.exchangeRate
    }
}
