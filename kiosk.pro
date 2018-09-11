TEMPLATE = app

QT += qml quick multimedia
CONFIG += c++14

CONFIG += debug

CONFIG += link_pkgconfig
PKGCONFIG += zbar

QJSONRPC_HEADERS += \
    3rdParty/qjsonrpc/src/qjsonrpcabstractserver.h \
    3rdParty/qjsonrpc/src/qjsonrpcabstractserver_p.h \
    3rdParty/qjsonrpc/src/qjsonrpcglobal.h \
    3rdParty/qjsonrpc/src/qjsonrpcmessage.h \
    3rdParty/qjsonrpc/src/qjsonrpcmetatype.h \
    3rdParty/qjsonrpc/src/qjsonrpcservice.h \
    3rdParty/qjsonrpc/src/qjsonrpcservice_p.h \
    3rdParty/qjsonrpc/src/qjsonrpcserviceprovider.h \
    3rdParty/qjsonrpc/src/qjsonrpcservicereply.h \
    3rdParty/qjsonrpc/src/qjsonrpcservicereply_p.h \
    3rdParty/qjsonrpc/src/qjsonrpcsocket.h \
    3rdParty/qjsonrpc/src/qjsonrpcsocket_p.h

QJSONRPC_SOURCES += \
    3rdParty/qjsonrpc/src/qjsonrpcabstractserver.cpp \
    3rdParty/qjsonrpc/src/qjsonrpcmessage.cpp \
    3rdParty/qjsonrpc/src/qjsonrpcservice.cpp \
    3rdParty/qjsonrpc/src/qjsonrpcserviceprovider.cpp \
    3rdParty/qjsonrpc/src/qjsonrpcservicereply.cpp \
    3rdParty/qjsonrpc/src/qjsonrpcsocket.cpp \

HEADERS += \
	$${QJSONRPC_HEADERS} \
    src/kioskcontroller.h \
    src/qrcodevideofilter.h \
    src/utils.h

SOURCES += \
	$${QJSONRPC_SOURCES} \
    src/main.cpp \
    src/kioskcontroller.cpp \
    src/qrcodevideofilter.cpp \
    src/utils.cpp

RESOURCES += \
    src/qml/qml.qrc \
    src/images/images.qrc

INCLUDEPATH += src
