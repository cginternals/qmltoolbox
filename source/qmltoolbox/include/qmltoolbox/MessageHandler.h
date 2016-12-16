
#pragma once

#include <memory>

#include <QSet>

#include <qmltoolbox/qmltoolbox_api.h>


namespace qmltoolbox
{


class AbstractMessageReceiver;
class ForwardingStreamBuffer;


/**
 *  @brief
 *    Interface required by qInstallMessageHandler()
 */
void QMLTOOLBOX_API globalMessageHandler(
    QtMsgType type,
    const QMessageLogContext & context,
    const QString & message);


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

public:
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
    *    Replace standard stream buffers of std::cout and std::cerr with
    *    custom stream buffers that forward incoming input
    */
    void installStdHandlers();

    /**
    *  @brief
    *    Restore standard stream buffers of std::cout and std::cerr
    */
    void deinstallStdHandlers();
    
private:
    /**
    *  @brief
    *    Constructor
    */
    MessageHandler() = default;

    /**
    *  @brief
    *    Destructor
    */
    ~MessageHandler() = default;

public:
    /**
    *  @brief
    *    Handle std messages by forwarding them to registered message receivers
    *
    *  param[in] type
    *    Message type
    *
    *  param[in] message
    *    Message string
    */
    void handleStd(QtMsgType type, const QString & message);

    /**
    *  @brief
    *    Handle Qt messages by forwarding them to registered message receivers
    *
    *  param[in] type
    *    Message type
    *
    *  param[in] context
    *    Message context
    *
    *  param[in] message
    *    Message string
    */
    void handle(
        QtMsgType type,
        const QMessageLogContext & context,
        const QString & message);

private:
    QSet<AbstractMessageReceiver *> m_receivers; ///< List of registered message receivers
    
    std::unique_ptr<ForwardingStreamBuffer> m_coutBuffer; ///< Stream buffer forwarding std::cout output
    std::unique_ptr<ForwardingStreamBuffer> m_cerrBuffer; ///< Stream buffer forwarding std::cerr output
};


} // namespace qmltoolbox
