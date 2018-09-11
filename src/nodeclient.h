#pragma once

#include <qjsonrpchttpclient.h>

class QNetworkReply;
class QAuthenticator;

class NodeClient : public QJsonRpcHttpClient
{
    Q_OBJECT
public:
    explicit NodeClient(const QString &endPoint, QObject *parent = nullptr);

    void setUsername(const QString &username);
    void setPassword(const QString &password);

private:
    void handleAuthenticationRequired(QNetworkReply *reply, QAuthenticator *authenticator) override;

    QString m_username;
    QString m_password;
};
