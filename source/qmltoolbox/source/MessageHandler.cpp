
#include <qmltoolbox/MessageHandler.h>

#include <iostream>

#include <QString>
#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QDateTime>
#include <QTextStream>

#include <qmltoolbox/AbstractMessageReceiver.h>
#include <qmltoolbox/make_unique.h>


namespace qmltoolbox
{

class ForwardingStreamBuffer : public std::streambuf
{
public:
    ForwardingStreamBuffer(qmltoolbox::MessageHandler & handler, QtMsgType msgType, std::ostream & stream)
    :   m_handler(handler)
    ,   m_msgType(msgType)
    ,   m_stream(stream)
    {
        m_prevBuffer = m_stream.rdbuf();
        m_stream.rdbuf(this);
    }
    
    ~ForwardingStreamBuffer()
    {
        m_stream.rdbuf(m_prevBuffer);
    }
    
protected:
    virtual int_type overflow(int_type value) override
    {
        // temporary fix: std::endl doesn't lead to xsputn being called.
        // TODO: find real fix
        static const auto linebreak = "\n";
        xsputn(linebreak, strlen(linebreak));
        return value;
    }
    
    virtual std::streamsize xsputn(const char * buffer, std::streamsize size) override
    {
        m_handler.handleStd(m_msgType, qPrintable(QString(buffer)));
        return size;
    }
    
private:
    qmltoolbox::MessageHandler & m_handler;
    const QtMsgType m_msgType;
    std::ostream & m_stream;
    std::streambuf * m_prevBuffer;
};
    
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

MessageHandler::MessageHandler() = default;

MessageHandler::~MessageHandler() = default;
    
void MessageHandler::handleStd(QtMsgType type, const QString & message)
{
    const auto timestamp = QDateTime::currentDateTime();
    
    for (auto receiver : m_receivers)
        receiver->print(type, QMessageLogContext(), timestamp, message);
}

void MessageHandler::handle(
  QtMsgType type
, const QMessageLogContext & context
, const QString & message)
{
    const auto timestamp = QDateTime::currentDateTime();

    for (auto receiver : m_receivers)
        receiver->print(type, context, timestamp, message + "\n");
}

void MessageHandler::attach(AbstractMessageReceiver & receiver)
{
    m_receivers.insert(&receiver);
}

void MessageHandler::detach(AbstractMessageReceiver & receiver)
{
    m_receivers.erase(&receiver);
}
    
void MessageHandler::installStdHandlers()
{
    m_coutBuffer = std::make_unique<ForwardingStreamBuffer>(*this, QtDebugMsg, std::cout);
    m_cerrBuffer = std::make_unique<ForwardingStreamBuffer>(*this, QtFatalMsg, std::cerr);
}
    
void MessageHandler::deinstallStdHandlers()
{
    m_coutBuffer = nullptr;
    m_cerrBuffer = nullptr;
}


} // namespace qmltoolbox
