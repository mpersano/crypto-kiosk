import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.Layouts 1.11

Rectangle {
    id: mainRect
    focus: true
    width: 1024
    height: 768

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
       
        StackLayout {
            id: root
            currentIndex: 0
            Layout.fillHeight: true
            Layout.fillWidth: true

            Start {
                width: root.width
                height: root.height
                onStartClicked: {
                    root.currentIndex = 1
                }
            }

            AddressScan {
                width: root.width
                height: root.height
                onCloseClicked: {
                    root.currentIndex = 0
                }
                onCodeDetected: {
                    if (controller.setDestinationAddress(code))
                        root.currentIndex = 2
                }
            }

            AcceptMoney {
                width: root.width
                height: root.height
                onSendClicked: {
                    console.log("send!")
                }
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
