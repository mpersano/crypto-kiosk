import QtQuick 2.0
import QtQuick.Layouts 1.11

Rectangle {
    id: root
    color: "deepskyblue"

    signal startClicked()

    ColumnLayout {
        anchors.centerIn: parent

        CircleButton {
            Layout.alignment: Qt.AlignHCenter
            text: "Start"
            onClicked: root.startClicked()
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Tap to buy bitcoins"
            color: "darkblue"
            font.pointSize: 16
        }
    }
}
