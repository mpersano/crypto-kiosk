import QtQuick 2.0
import QtQuick.Layouts 1.3
import "utils"

Rectangle {
    id: root
    color: Style.colorBackground

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
            color: Style.colorText
            font.pointSize: Style.fontSizeS
        }
    }
}
