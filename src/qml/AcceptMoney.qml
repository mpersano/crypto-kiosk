import QtQuick 2.3
import QtQuick.Layouts 1.3
import "utils"

Rectangle {
    id: root
    color: Style.colorBackground

    signal sendClicked()

    RowLayout {
        anchors.centerIn: parent
        spacing: 64

        ColumnLayout {
            CircleButton {
                Layout.alignment: Qt.AlignHCenter
                text: "Send"
                onClicked: root.sendClicked()
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Tap to complete purchase"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
        }

        ColumnLayout {
            Text {
                text: controller.deposited
                color: Style.colorTitle
                font.pointSize: Style.fontSizeM
            }

            Text {
                text: "deposited so far"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
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
                text: "Your bitcoin will be sent to:"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
            Text {
                text: controller.destinationAddress
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
        }
    }
}
