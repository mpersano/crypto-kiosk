import QtQuick 2.3

Image {
    property alias text: titleText.text
    property alias pressed: mouseArea.pressed
    signal clicked()
    source: "circle-button.png"
    Text {
        id: titleText
        anchors.centerIn: parent
        color: "darkblue"
        font.pointSize: 22
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
