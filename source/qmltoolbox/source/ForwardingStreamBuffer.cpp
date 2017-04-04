
#include <qmltoolbox/ForwardingStreamBuffer.h>

#include <QString>

#include <qmltoolbox/MessageHandler.h>


namespace qmltoolbox
{


ForwardingStreamBuffer::ForwardingStreamBuffer(std::ostream & stream, qmltoolbox::MessageHandler & handler, QtMsgType msgType)
: m_handler(handler)
, m_msgType(msgType)
, m_stream(stream)
{
    m_prevBuffer = m_stream.rdbuf();
    m_stream.rdbuf(this);
}

ForwardingStreamBuffer::~ForwardingStreamBuffer()
{
    m_stream.rdbuf(m_prevBuffer);
}

std::streambuf * ForwardingStreamBuffer::redirected() const
{
    return m_prevBuffer;
}

ForwardingStreamBuffer::int_type ForwardingStreamBuffer::overflow(int_type value)
{
    // temporary fix: std::endl doesn't lead to xsputn being called.
    // TODO: find real fix
    static const auto linebreak = "\n";
    xsputn(linebreak, strlen(linebreak));
    return value;
}

std::streamsize ForwardingStreamBuffer::xsputn(const char * buffer, std::streamsize size)
{
    m_handler.handleMessage(m_msgType, QMessageLogContext(), qPrintable(QString(buffer)));
    return size;
}

int ForwardingStreamBuffer::sync()
{
    return m_prevBuffer->pubsync();
}


} // namespace qmltoolbox
