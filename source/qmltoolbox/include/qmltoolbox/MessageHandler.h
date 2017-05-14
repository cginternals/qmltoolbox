
#pragma once


#include <memory>
#include <set>

#include <QtCore/qglobal.h>

#include <qmltoolbox/qmltoolbox_api.h>


namespace qmltoolbox
{


class AbstractMessageReceiver;
class ForwardingStreamBuffer;


/**
*  @brief
*    Forwards Qt and std output streams
*/
class QMLTOOLBOX_API MessageHandler
{
public:
    /**
    *  @brief
    *    Get singleton instance
    *
    *  @return
    *    Singleton instance of MessageHandler
    */
    static MessageHandler & instance();

    /**
    *  @brief
    *    Handle message from Qt
    *
    *  @param[in] type
    *    Message type
    *  @param[in] context
    *    Message context
    *  @param[in] message
    *    Message string
    *
    *  @remarks
    *    Pass this function to qInstallMessageHandler()
    */
    static void qtMessageHandler(QtMsgType type, const QMessageLogContext & context, const QString & message);


private:
    /**
    *  @brief
    *    Constructor
    */
    MessageHandler();

    /**
    *  @brief
    *    Destructor
    */
    ~MessageHandler();


public:
    /**
    *  @brief
    *    Install message handlers
    *
    *  @remarks
    *    This function installs message handlers to intercept all messages
    *    from std::cout, std::cerr, and Qt. The messages are redirected to
    *    the message receivers connected to MessageHandler and additionally
    *    output to the console.
    */
    void installMessageHandlers();

    /**
    *  @brief
    *    Restore standard message handlers
    */
    void deinstallMessageHandlers();

    /**
    *  @brief
    *    Attach a message receiver
    *
    *  @param[in] receiver
    *    Message receiver
    */
    void attach(AbstractMessageReceiver & receiver);

    /**
    *  @brief
    *    Detach a message receiver
    *
    *  @param[in] receiver
    *    Message receiver
    */
    void detach(AbstractMessageReceiver & receiver);

    /**
    *  @brief
    *    Handle output by forwarding it to the registered message receivers
    *
    *  @param[in] type
    *    Message type
    *  @param[in] context
    *    Message context
    *  @param[in] message
    *    Message string
    *
    *  @remarks
    *    It is not guaranteed that message contains a full line of text, it may also
    *    be only a portion of it or several lines at once. So, do not automatically
    *    append newline characters, just pass it on unchanged.
    */
    void handleOutput(QtMsgType type, const QMessageLogContext & context, const QString & message);


private:
    std::set<AbstractMessageReceiver *>     m_receivers; ///< List of registered message receivers    
    std::unique_ptr<ForwardingStreamBuffer> m_cout;      ///< Stream buffer forwarding std::cout output
    std::unique_ptr<ForwardingStreamBuffer> m_cerr;      ///< Stream buffer forwarding std::cerr output
};


} // namespace qmltoolbox
