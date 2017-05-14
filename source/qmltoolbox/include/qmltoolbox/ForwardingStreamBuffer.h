
#pragma once


#include <streambuf>
#include <ostream>

#include <QtCore/qglobal.h>

#include <qmltoolbox/MessageHandler.h>


namespace qmltoolbox
{


class MessageHandler;


/**
*  @brief
*    Stream buffer implementation that forwards messages to MessageHandler
*/
class QMLTOOLBOX_API ForwardingStreamBuffer : public std::streambuf
{
public:
    /**
    *  @brief
    *    Constructor
    *
    *  @param[in] stream
    *    Standard stream that is redirected
    *  @param[in] handler
    *    Message handler
    *  @param[in] msgType
    *    Message type
    */
    ForwardingStreamBuffer(std::ostream & stream, MessageHandler & handler, MessageHandler::MessageType msgType);

    /**
    *  @brief
    *    Destructor
    */
    virtual ~ForwardingStreamBuffer();

    /**
    *  @brief
    *    Get pointer to the redirected stream buffer
    *
    *  @return
    *    Stream buffer
    */
    std::streambuf * redirected() const;


protected:
    // Virtual std::streambuf interface
    virtual int_type overflow(int_type value) override;
    virtual std::streamsize xsputn(const char * buffer, std::streamsize size) override;
    virtual int sync() override;


private:
    qmltoolbox::MessageHandler  & m_handler;    ///< Message handler to which the messages are forwarded
    MessageHandler::MessageType   m_msgType;    ///< Message type
    std::ostream                & m_stream;     ///< Standard stream that is redirected
    std::streambuf              * m_prevBuffer; ///< Stream buffer of the stream that has been replaced
};


} // namespace qmltoolbox
