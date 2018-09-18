import QtQuick 2.3
import "utils"

Image {
    property alias text: titleText.text
    property alias pressed: mouseArea.pressed
    signal clicked()
    source: "circle-button.png"
    Text {
        id: titleText
        anchors.centerIn: parent
        color: Style.colorText
        font.pointSize: Style.fontSizeM
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
