
#pragma once

#include <memory>

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
class ForwardingStreamBuffer;


void QMLTOOLBOX_API globalMessageHandler(
    QtMsgType type
,   const QMessageLogContext & context
,   const QString & message);


class QMLTOOLBOX_API MessageHandler : public QObject
{
public:
    static MessageHandler & instance();

public:
    explicit MessageHandler(QObject * parent = nullptr);
    virtual ~MessageHandler();
    
    void attach(AbstractMessageReceiver & receiver);
    void detach(AbstractMessageReceiver & receiver);
    
    void installStdHandlers();
    void deinstallStdHandlers();
    
    void handleStd(QtMsgType type, const QString & message);

    void handle(
        QtMsgType type,
        const QMessageLogContext & context,
        const QString & message);

private:
    QSet<AbstractMessageReceiver *> m_receivers;
    
    std::unique_ptr<ForwardingStreamBuffer> m_coutBuffer;
    std::unique_ptr<ForwardingStreamBuffer> m_cerrBuffer;
};


} // namespace qmltoolbox
