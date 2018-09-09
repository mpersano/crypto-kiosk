TEMPLATE = app

QT += qml quick multimedia
CONFIG += c++14

CONFIG += debug

CONFIG += link_pkgconfig
PKGCONFIG += zbar

include(src/src.pri)
