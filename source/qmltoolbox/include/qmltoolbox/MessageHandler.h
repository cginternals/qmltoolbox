#pragma once

#include <QObject>
#include <QMap>
#include <QSet>
#include <QFile>

#include <qmltoolbox/qmltoolbox_api.h>


class QTextStream;
class QDateTime;

namespace qmltoolbox
{

class AbstractMessageReceiver;

void QMLTOOLBOX_API globalMessageHandler(
    QtMsgType type
,   const QMessageLogContext & context
,   const QString & message);

class QMLTOOLBOX_API MessageHandler : public QObject
{
public:
    static MessageHandler & instance();

    explicit MessageHandler(QObject * parent = nullptr);
    virtual ~MessageHandler();
    
    void attach(AbstractMessageReceiver & receiver);
    void detach(AbstractMessageReceiver & receiver);

    void handle(
        QtMsgType type,
        const QMessageLogContext & context,
        const QString & message);

private:
    QSet<AbstractMessageReceiver *> m_receivers;
};

} // namespace qmltoolbox
