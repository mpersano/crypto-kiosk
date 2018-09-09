import QtQuick 2.3

Rectangle {
    id: banner
    height: 80
    color: "darkblue"

    Text {
        text: bannerText()
        color: "white"
        font.pointSize: 16
        anchors.left: banner.left
        anchors.leftMargin: 32
        anchors.verticalCenter: banner.verticalCenter
    }

    function bannerText() {
        return "Current bitcoin price is " + controller.exchangeRate
    }
}
