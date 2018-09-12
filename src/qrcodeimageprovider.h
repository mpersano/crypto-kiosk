#pragma once

#include <QQuickImageProvider>

class QRCodeImageProvider : public QQuickImageProvider
{
public:
    QRCodeImageProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;
};
