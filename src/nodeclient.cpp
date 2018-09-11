#include "nodeclient.h"

#include <QNetworkReply>
#include <QAuthenticator>

NodeClient::NodeClient(const QString &endPoint, QObject *parent)
    : QJsonRpcHttpClient{endPoint, parent}
{
}

void NodeClient::setUsername(const QString &username)
{
    m_username = username;
}

void NodeClient::setPassword(const QString &password)
{
    m_password = password;
}

void NodeClient::handleAuthenticationRequired(QNetworkReply *reply, QAuthenticator *authenticator)
{
    Q_UNUSED(reply);
    authenticator->setUser(m_username);
    authenticator->setPassword(m_password);
}
