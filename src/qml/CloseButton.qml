import QtQuick 2.3

Image {
    signal clicked()
    source: "close-button-background.png"
    Text {
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        color: "darkblue"
        font.pointSize: 22
        font.bold: true
        text: "X"
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
