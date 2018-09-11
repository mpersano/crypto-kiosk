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
    QSettings settings("settings.ini", QSettings::IniFormat);

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
    emit destinationAddressChanged();
    return true;
}

QString KioskController::destinationAddress() const
{
    return m_destinationAddress;
}

void KioskController::deposit(double value)
{
    m_deposited += value;
    emit depositedChanged();
    emit purchasedChanged();
}

void KioskController::getWalletBalance()
{
    const auto request = QJsonRpcMessage::createRequest("getbalance");
    auto *reply = m_nodeClient->sendMessage(request);
    connect(reply, &QJsonRpcServiceReply::finished, this, &KioskController::getWalletBalanceFinished);
}

void KioskController::getWalletBalanceFinished()
{
    auto *reply = static_cast<QJsonRpcServiceReply *>(sender());
    reply->disconnect(this);
    const auto message = reply->response();

    if (message.type() == QJsonRpcMessage::Error) {
        qDebug() << "RPC error:" << message.errorData();
        return;
    }

    m_walletBalance = message.result().toDouble();

    qDebug() << "balance:" << m_walletBalance;
}
