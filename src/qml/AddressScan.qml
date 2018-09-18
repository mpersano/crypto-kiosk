import QtQuick 2.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.6
import QRCode 1.0
import "utils"

Rectangle {
    id: root
    color: Style.colorBackground

    signal closeClicked()
    signal codeDetected(string code)

    onVisibleChanged: {
        // make sure we capture only when this page is visible
        if (visible)
            camera.start()
        else
            camera.stop()
    }

    Camera {
        id: camera
        viewfinder {
            resolution: "320x240"
        }
    }

    QRCodeVideoFilter {
        id: videoFilter
        onCodeDetected: {
            root.codeDetected(code)
        }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 64

        Item {
            width: 320
            height: 240
            VideoOutput {
                anchors.fill: parent
                source: camera
                filters: [ videoFilter ]
            }
        }

        ColumnLayout {
            width: 400
            Text {
                text: "Scan your\nbitcoin address"
                color: Style.colorTitle
                font.pointSize: Style.fontSizeL
            }
            Text {
                text: "Hold your QR code\nup to the scan window\nto proceed"
                color: Style.colorText
                font.pointSize: Style.fontSizeS
            }
        }
    }

    CloseButton {
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked: root.closeClicked()
    }
}
