#include "kioskcontroller.h"

#include "nodeclient.h"
#include "utils.h"

#include <QSettings>
#include <QDebug>

#include <cmath>

namespace
{
QString AddressPrefix()
{
    return QStringLiteral("bitcoin:");
}
}

KioskController::KioskController(QObject *parent)
    : QObject{parent}
{
    QSettings settings{"settings.ini", QSettings::IniFormat};

    const auto nodePort = settings.value("nodePort").toInt();
    const auto nodeRpcUsername = settings.value("nodeRpcUsername").toString();
    const auto nodeRpcPassword = settings.value("nodeRpcPassword").toString();

    const auto endPoint = QStringLiteral("http://127.0.0.1:%1").arg(nodePort);
    m_nodeClient = new NodeClient{endPoint, this};
    m_nodeClient->setUsername(nodeRpcUsername);
    m_nodeClient->setPassword(nodeRpcPassword);

    getWalletBalance();
}

KioskController::~KioskController() = default;

QString KioskController::exchangeRate() const
{
    return formatMoney(m_exchangeRate);
}

QString KioskController::deposited() const
{
    return formatMoney(m_deposited);
}

QString KioskController::purchased() const
{
    Q_ASSERT(m_exchangeRate);
    return formatCrypto(m_deposited / m_exchangeRate);
}

bool KioskController::setDestinationAddress(const QString &address)
{
    if (!address.startsWith(AddressPrefix()))
        return false;
    m_destinationAddress = address.mid(AddressPrefix().length());
    m_deposited = 0.0;
    emit destinationAddressChanged();
    return true;
}

QString KioskController::destinationAddress() const
{
    return m_destinationAddress;
}

QString KioskController::lastTxId() const
{
    return m_lastTxId;
}

void KioskController::deposit(double value)
{
    // TODO refuse deposit if amount purchased exceeds wallet balance
    m_deposited += value;
    emit depositedChanged();
    emit purchasedChanged();
}

void KioskController::getWalletBalance()
{
    auto *reply = m_nodeClient->invokeRemoteMethod(QStringLiteral("getbalance"));
    connect(reply, &QJsonRpcServiceReply::finished, this, [this, reply] {
        const auto message = reply->response();
        if (message.type() == QJsonRpcMessage::Error) {
            qDebug() << "RPC error:" << message.errorData();
            return;
        }
        m_walletBalance = message.result().toDouble();
        qDebug() << "balance:" << m_walletBalance;
    });
}

bool KioskController::send()
{
    if (m_destinationAddress.isNull() || m_deposited == 0.0)
        return false;
    Q_ASSERT(m_exchangeRate);
    // XXX check if wallet balance is enough for this transfer
    const auto amount = QString::number(m_deposited / m_exchangeRate, 'f', 8);
    qDebug() << "sending" << amount << "to" << m_destinationAddress;
    auto *reply = m_nodeClient->invokeRemoteMethod(QStringLiteral("sendtoaddress"), m_destinationAddress, amount);
    connect(reply, &QJsonRpcServiceReply::finished, this, [this, reply] {
        const auto message = reply->response();
        if (message.type() == QJsonRpcMessage::Error) {
            qDebug() << "RPC error:" << message.errorData();
            return;
        }
        setLastTxId(message.result().toString());
        qDebug() << "transfer successful, txid:" << m_lastTxId;
        emit transferCompleted();
        getWalletBalance();
    });
    return true;
}

void KioskController::setLastTxId(const QString &lastTxId)
{
    m_lastTxId = lastTxId;
    emit lastTxIdChanged();
}
