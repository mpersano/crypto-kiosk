#include "kioskcontroller.h"

#include <cmath>

namespace
{
constexpr const auto ThousandsSeparator = QChar{','};
constexpr const auto DecimalSeparator = QChar{'.'};

QString CurrencySymbol()
{
    return QStringLiteral("$");
}

QString CryptoCurrencySymbol()
{
    return QStringLiteral("BTC");
}

QString AddressPrefix()
{
    return QStringLiteral("bitcoin:");
}

QString formatInteger(int value)
{
    QString result;
    const auto prependThousands = [&result](const auto &thousands) {
        if (!result.isEmpty())
            result = thousands + ThousandsSeparator + result;
        else
            result = thousands;
    };
    while (value > 1000) {
        prependThousands(QString::number(value % 1000).rightJustified(3, '0'));
        value /= 1000;
    }
    prependThousands(QString::number(value));
    return result;
}

QString formatMoney(double value)
{
    const auto integerValue = static_cast<int>(value);
    const auto fractionalValue = static_cast<int>(std::round(value * 100)) % 100;
    return CurrencySymbol()
           + QChar{' '}
           + formatInteger(integerValue)
           + DecimalSeparator
           + QString::number(fractionalValue).rightJustified(2, '0');
}

QString formatCrypto(double value)
{
    QString prefix;
    if (value < 1.) {
        if (value >= 1e-3) {
            value *= 1e3;
            prefix = QStringLiteral("m");
        } else {
            value *= 1e6;
            prefix = QChar{0x3bc}; // micro character
        }
    }
    const auto integerValue = static_cast<int>(value);
    const auto fractionalValue = static_cast<int>(std::round(value * 1000)) % 1000;
    return formatInteger(integerValue)
           + DecimalSeparator
           + QString::number(fractionalValue).rightJustified(3, '0')
           + QChar{' '}
           + prefix + CryptoCurrencySymbol();
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
