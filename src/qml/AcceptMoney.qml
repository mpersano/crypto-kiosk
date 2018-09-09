import QtQuick 2.3
import QtQuick.Layouts 1.11

Rectangle {
    id: root
    color: "deepskyblue"

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
                color: "darkblue"
                font.pointSize: 16
            }
        }

        ColumnLayout {
            Text {
                text: controller.deposited
                color: "white"
                font.pointSize: 22
            }

            Text {
                text: "deposited so far"
                color: "darkblue"
                font.pointSize: 16
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
                text: "Your bitcoin will be sent to:"
                color: "darkblue"
                font.pointSize: 16
            }
            Text {
                text: controller.destinationAddress
                color: "darkblue"
                font.pointSize: 16
            }
        }
    }
}
