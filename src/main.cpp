#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>

#include "qrcodevideofilter.h"
#include "kioskcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QRCodeVideoFilter>("QRCode", 1, 0, "QRCodeVideoFilter");

    KioskController controller;

    QQuickView view;
    view.engine()->rootContext()->setContextProperty(QStringLiteral("controller"), &controller);
    view.setSource(QUrl("qrc:/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    return app.exec();
}
