import QtQuick 2.0
import QtQuick.Layouts 1.11

Rectangle {
    id: root
    color: "deepskyblue"

    ColumnLayout {
        anchors.centerIn: parent
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Transfer completed"
            color: "white"
            font.pointSize: 22
        }
        Text {
            text: controller.lastTxId
            color: "darkblue"
            font.pointSize: 16
        }
    }
}
