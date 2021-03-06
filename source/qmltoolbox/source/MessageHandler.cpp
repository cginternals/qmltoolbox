
#include <qmltoolbox/MessageHandler.h>

#include <iostream>

#include <QString>
#include <QDateTime>

#include <qmltoolbox/ForwardingStreamBuffer.h>
#include <qmltoolbox/AbstractMessageReceiver.h>


namespace qmltoolbox
{


MessageHandler & MessageHandler::instance()
{
    static MessageHandler instance;
    return instance;
}

void MessageHandler::qtMessageHandler(QtMsgType msgType, const QMessageLogContext & context, const QString & message)
{
    // Convert message type
    MessageType type = Info;
         if (msgType == QtWarningMsg)  type = Warning;
    else if (msgType == QtCriticalMsg) type = Error;
    else if (msgType == QtFatalMsg)    type = Critical;

    // Get context
    QString contextCategory = context.category;

    // Qt messages are always entire lines, but do not contain a newline, so add one
    MessageHandler::instance().handleOutput(type, contextCategory, message + "\n");
}

MessageHandler::MessageHandler()
{
}

MessageHandler::~MessageHandler()
{
}

void MessageHandler::installMessageHandlers()
{
    // Redirect std streams to MessageHandler
    m_cout.reset(new ForwardingStreamBuffer(std::cout, *this, Info));
    m_cerr.reset(new ForwardingStreamBuffer(std::cerr, *this, Error));

    // Redirect Qt messages to MessageHandler
    qInstallMessageHandler(MessageHandler::qtMessageHandler);
}

void MessageHandler::deinstallMessageHandlers()
{
    // Remove redirections
    m_cout = nullptr;
    m_cerr = nullptr;
}

void MessageHandler::attach(AbstractMessageReceiver & receiver)
{
    // Add message handler
    m_receivers.insert(&receiver);
}

void MessageHandler::detach(AbstractMessageReceiver & receiver)
{
    // Remove message handler
    m_receivers.erase(&receiver);
}

void MessageHandler::handleOutput(MessageType type, const QString & context, const QString & message)
{
    // Get current time
    const auto timestamp = QDateTime::currentDateTime();

    // Forward message to all receivers
    for (auto receiver : m_receivers) {
        receiver->print(type, timestamp, context, message);
    }

    // Output message also to standard streams
    std::string stdMsg = message.toStdString();

    switch (type)
    {
        case Critical:
        case Error:
        case Warning:
        {
            m_cerr->redirected()->sputn(stdMsg.c_str(), stdMsg.size());
            break;
        }

        default:
        {
            m_cout->redirected()->sputn(stdMsg.c_str(), stdMsg.size());
            break;
        }
    }
}


} // namespace qmltoolbox
