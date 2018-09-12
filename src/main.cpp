#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>

#include "qrcodevideofilter.h"
#include "kioskcontroller.h"
#include "qrcodeimageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QRCodeVideoFilter>("QRCode", 1, 0, "QRCodeVideoFilter");

    KioskController controller;

    QQuickView view;
    auto engine = view.engine();
    engine->rootContext()->setContextProperty(QStringLiteral("controller"), &controller);
    engine->addImageProvider(QLatin1String("QRCode"), new QRCodeImageProvider);
    view.setSource(QUrl("qrc:/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    return app.exec();
}
