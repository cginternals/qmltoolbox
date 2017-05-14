
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

void MessageHandler::qtMessageHandler(QtMsgType type, const QMessageLogContext & context, const QString & message)
{
    // Qt messages are always entire lines, but do not contain a newline, so add one
    MessageHandler::instance().handleOutput(type, context, message + "\n");
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
    m_cout.reset(new ForwardingStreamBuffer(std::cout, *this, QtDebugMsg));
    m_cerr.reset(new ForwardingStreamBuffer(std::cerr, *this, QtFatalMsg));

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

void MessageHandler::handleOutput(QtMsgType type, const QMessageLogContext & context, const QString & message)
{
    // Get current time
    const auto timestamp = QDateTime::currentDateTime();

    // Process message
    QString msg = message;

    // Forward message to all receivers
    for (auto receiver : m_receivers) {
        receiver->print(type, context, timestamp, msg);
    }

    // Output message also to standard streams
    std::string stdMsg = msg.toStdString();

    switch (type)
    {
        case QtWarningMsg:
        case QtCriticalMsg:
        case QtFatalMsg:
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
