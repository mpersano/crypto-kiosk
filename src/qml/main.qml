import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.Layouts 1.11

Rectangle {
    id: mainRect
    focus: true
    width: 1024
    height: 768

    readonly property int startIndex: 0
    readonly property int addressScanIndex: 1
    readonly property int acceptMoneyIndex: 2
    readonly property int transferCompletedIndex: 3

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
       
        StackLayout {
            id: root
            currentIndex: startIndex
            Layout.fillHeight: true
            Layout.fillWidth: true

            Start {
                width: root.width
                height: root.height
                onStartClicked: {
                    root.currentIndex = addressScanIndex
                }
            }

            AddressScan {
                width: root.width
                height: root.height
                onCloseClicked: {
                    root.currentIndex = startIndex
                }
                onCodeDetected: {
                    if (controller.setDestinationAddress(code))
                        root.currentIndex = acceptMoneyIndex
                }
            }

            AcceptMoney {
                width: root.width
                height: root.height
                onSendClicked: {
                    if (controller.send()) {
                        root.currentIndex = transferCompletedIndex;
                    }
                }
            }

            TransferCompleted {
                width: root.width
                height: root.height
            }
        }

        Banner {
            id: banner
            Layout.fillWidth: true
        }
    }

    // XXX test-only! remove this when we have a working money acceptor interface
    Keys.onPressed: {
        if (event.key == Qt.Key_Z) {
            controller.deposit(50);
        } else if (event.key == Qt.Key_X) {
            controller.deposit(20);
        } else if (event.key == Qt.Key_C) {
            controller.deposit(10);
        } else if (event.key == Qt.Key_V) {
            controller.deposit(5);
        } else if (event.key == Qt.Key_B) {
            controller.deposit(2);
        }
    }
}
