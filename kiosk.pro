TEMPLATE = app

QT += qml quick multimedia
CONFIG += c++14

CONFIG += debug

CONFIG += link_pkgconfig
PKGCONFIG += zbar

qjsonrpc_dir = 3rdParty/qjsonrpc/src

QJSONRPC_HEADERS += \
    $${qjsonrpc_dir}/qjsonrpcabstractserver.h \
    $${qjsonrpc_dir}/qjsonrpcabstractserver_p.h \
    $${qjsonrpc_dir}/qjsonrpcglobal.h \
    $${qjsonrpc_dir}/qjsonrpcmessage.h \
    $${qjsonrpc_dir}/qjsonrpcmetatype.h \
    $${qjsonrpc_dir}/qjsonrpcservice.h \
    $${qjsonrpc_dir}/qjsonrpcservice_p.h \
    $${qjsonrpc_dir}/qjsonrpcserviceprovider.h \
    $${qjsonrpc_dir}/qjsonrpcservicereply.h \
    $${qjsonrpc_dir}/qjsonrpcservicereply_p.h \
    $${qjsonrpc_dir}/qjsonrpcsocket.h \
    $${qjsonrpc_dir}/qjsonrpcsocket_p.h \
    $${qjsonrpc_dir}/qjsonrpchttpclient.h

QJSONRPC_SOURCES += \
    $${qjsonrpc_dir}/qjsonrpcabstractserver.cpp \
    $${qjsonrpc_dir}/qjsonrpcmessage.cpp \
    $${qjsonrpc_dir}/qjsonrpcservice.cpp \
    $${qjsonrpc_dir}/qjsonrpcserviceprovider.cpp \
    $${qjsonrpc_dir}/qjsonrpcservicereply.cpp \
    $${qjsonrpc_dir}/qjsonrpcsocket.cpp \
    $${qjsonrpc_dir}/qjsonrpchttpclient.cpp

qrcodegenerator_dir = 3rdParty/QR-Code-generator/cpp

QRCODEGENERATOR_HEADERS += \
    $${qrcodegenerator_dir}/QrCode.hpp \
    $${qrcodegenerator_dir}/QrSegment.hpp \
    $${qrcodegenerator_dir}/BitBuffer.hpp

QRCODEGENERATOR_SOURCES += \
    $${qrcodegenerator_dir}/BitBuffer.cpp \
    $${qrcodegenerator_dir}/QrCode.cpp \
    $${qrcodegenerator_dir}/QrSegment.cpp

HEADERS += \
    $${QJSONRPC_HEADERS} \
    $${QRCODEGENERATOR_HEADERS} \
    src/kioskcontroller.h \
    src/qrcodevideofilter.h \
    src/nodeclient.h \
    src/qrcodeimageprovider.h \
    src/utils.h

SOURCES += \
    $${QJSONRPC_SOURCES} \
    $${QRCODEGENERATOR_SOURCES} \
    src/main.cpp \
    src/kioskcontroller.cpp \
    src/qrcodevideofilter.cpp \
    src/nodeclient.cpp \
    src/qrcodeimageprovider.cpp \
    src/utils.cpp

RESOURCES += \
    src/qml/qml.qrc \
    src/images/images.qrc

INCLUDEPATH += \
    $${qjsonrpc_dir} \
    $${qrcodegenerator_dir} \
    src
