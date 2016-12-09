#include <qmltoolbox/MessageHandler.h>

#include <cassert>

#include <QString>
#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QDateTime>
#include <QTextStream>

#include <qmltoolbox/AbstractMessageReceiver.h>


namespace qmltoolbox
{

void globalMessageHandler(
    QtMsgType type
,   const QMessageLogContext & context
,   const QString & message)
{
    MessageHandler::instance().handle(type, context, message);
}

MessageHandler & MessageHandler::instance()
{
    static MessageHandler instance;
    return instance;
}

MessageHandler::MessageHandler(QObject * parent)
:    QObject(parent)
{
}

MessageHandler::~MessageHandler() = default;

void MessageHandler::handle(
    QtMsgType type
,   const QMessageLogContext & context
,   const QString & message)
{
    const auto timestamp = QDateTime::currentDateTime();

    for (auto receiver : m_receivers)
        receiver->print(type, context, timestamp, message);
}

void MessageHandler::attach(AbstractMessageReceiver & receiver)
{
    m_receivers.insert(&receiver);
}

void MessageHandler::detach(AbstractMessageReceiver & receiver)
{
    m_receivers.remove(&receiver);
}

} // namespace qmltoolbox
