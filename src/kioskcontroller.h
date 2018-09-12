#pragma once

#include <QObject>

class NodeClient;

class KioskController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString exchangeRate READ exchangeRate NOTIFY exchangeRateChanged)
    Q_PROPERTY(QString destinationAddress READ destinationAddress NOTIFY destinationAddressChanged)
    Q_PROPERTY(QString deposited READ deposited NOTIFY depositedChanged)
    Q_PROPERTY(QString purchased READ purchased NOTIFY purchasedChanged)
    Q_PROPERTY(QString lastTransactionId READ lastTransactionId NOTIFY lastTransactionIdChanged)

public:
    explicit KioskController(QObject *parent = nullptr);
    ~KioskController();

    Q_INVOKABLE bool setDestinationAddress(const QString &address);
    Q_INVOKABLE void deposit(double value);
    Q_INVOKABLE bool send();

    QString exchangeRate() const;
    QString destinationAddress() const;
    QString deposited() const;
    QString purchased() const;
    QString lastTransactionId() const;

signals:
    void exchangeRateChanged();
    void destinationAddressChanged();
    void depositedChanged();
    void purchasedChanged();
    void transferCompleted();
    void lastTransactionIdChanged();

private:
    void getWalletBalance();
    void resetPurchase();
    void setLastTransactionId(const QString &lastTransactionId);

    double m_exchangeRate = 27005; // fiat to crypto
    double m_deposited = 0.; // in fiat
    double m_walletBalance  = 0.; // in crypto
    QString m_destinationAddress;
    QString m_lastTransactionId;
    NodeClient *m_nodeClient = nullptr;
};
