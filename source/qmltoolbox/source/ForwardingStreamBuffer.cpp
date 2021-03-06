
#include <qmltoolbox/ForwardingStreamBuffer.h>

#include <QByteArray>
#include <QString>

#include <qmltoolbox/MessageHandler.h>


namespace qmltoolbox
{


ForwardingStreamBuffer::ForwardingStreamBuffer(std::ostream & stream, MessageHandler & handler, MessageHandler::MessageType msgType)
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
    // We have no buffer, so just output each character directly
    const char buf = value;
    xsputn(&buf, 1);

    return value;
}

std::streamsize ForwardingStreamBuffer::xsputn(const char * buffer, std::streamsize size)
{
    QString str(QByteArray(buffer, size));

    m_handler.handleOutput(m_msgType, "", qPrintable(str));
    return size;
}

int ForwardingStreamBuffer::sync()
{
    // Nothing to sync, we have no buffer
    return 0;
}


} // namespace qmltoolbox
