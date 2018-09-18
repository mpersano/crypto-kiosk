import QtQuick 2.0
import QtQuick.Layouts 1.3
import "utils"

Rectangle {
    id: root
    color: Style.colorBackground

    RowLayout {
        anchors.centerIn: parent
        width: parent.width

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter

            Text {
                text: "Thank you!"
                color: Style.colorTitle
                font.pointSize: Style.fontSizeL
            }

            Item {
                height: 32
            }

            Text {
                text: controller.purchased
                color: Style.colorTitle
                font.pointSize: Style.fontSizeM
            }

            Text {
                text: "total bitcoin purchased"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }

            Item {
                height: 32
            }

            Text {
                text: "Your bitcoins are on their way to:"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
            Text {
                text: controller.destinationAddress
                color: Style.colorText
                font.pointSize: Style.fontSizeS
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
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
        }
    }
}
