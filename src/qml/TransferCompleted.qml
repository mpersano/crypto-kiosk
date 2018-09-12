import QtQuick 2.0
import QtQuick.Layouts 1.11

Rectangle {
    id: root
    color: "deepskyblue"

    RowLayout {
        anchors.centerIn: parent
        width: parent.width

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter

            Text {
                text: "Thank you!"
                color: "white"
                font.pointSize: 32
            }

            Item {
                height: 32
            }

            Text {
                text: controller.purchased
                color: "white"
                font.pointSize: 22
            }

            Text {
                text: "total bitcoin purchased"
                color: "darkblue"
                font.pointSize: 16
            }

            Item {
                height: 32
            }

            Text {
                text: "Your bitcoins are on their way to:"
                color: "darkblue"
                font.pointSize: 16
            }
            Text {
                text: controller.destinationAddress
                color: "darkblue"
                font.pointSize: 16
            }
        }

        ColumnLayout {
            spacing: 16
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 360
                height: 360
                color: "white"

                Image {
                    anchors.centerIn: parent
                    source: "image://QRCode/" + controller.lastTransactionId
                }
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "View your transaction"
                color: "darkblue"
                font.pointSize: 16
            }
        }
    }
}
