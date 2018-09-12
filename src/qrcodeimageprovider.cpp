#include "qrcodeimageprovider.h"

#include <QrCode.hpp>

#include <QDebug>

namespace
{
constexpr const auto ZoomFactor = 8;
}

QRCodeImageProvider::QRCodeImageProvider()
    : QQuickImageProvider{QQuickImageProvider::Pixmap}
{
}

QPixmap QRCodeImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(requestedSize);

    auto qr = qrcodegen::QrCode::encodeText(id.toLatin1(), qrcodegen::QrCode::Ecc::MEDIUM);
    const auto qrcodeSize = qr.getSize();

    QImage image{qrcodeSize, qrcodeSize, QImage::Format_Mono};
    for (int y = 0; y < qrcodeSize; ++y) {
        for (int x = 0; x < qrcodeSize; ++x)
            image.setPixel(x, y, qr.getModule(x, y) ^ 1);
    }

    auto pixmap = QPixmap::fromImage(image.scaled(qrcodeSize * ZoomFactor, qrcodeSize * ZoomFactor));

    if (size)
        *size = pixmap.size();

    return pixmap;
}
