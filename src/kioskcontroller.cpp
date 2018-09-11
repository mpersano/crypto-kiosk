#include "kioskcontroller.h"

#include "utils.h"

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
