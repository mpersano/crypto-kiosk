#pragma once

#include <QAbstractVideoFilter>

class QRCodeVideoFilter : public QAbstractVideoFilter
{
    Q_OBJECT

public:
    explicit QRCodeVideoFilter(QObject *parent = nullptr);

    QVideoFilterRunnable *createFilterRunnable() override;

signals:
    void codeDetected(const QString &code);
};
