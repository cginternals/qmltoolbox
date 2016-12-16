
#pragma once


#include <QObject>
#include <QString>

#include <qmltoolbox/AbstractMessageReceiver.h>


namespace qmltoolbox
{


/**
 *  @brief
 *    Message receiver implementation for QML
 */
class QMLTOOLBOX_API QmlMessageForwarder : public QObject, public AbstractMessageReceiver
{
    Q_OBJECT


public:
    /**
     *  @brief
     *    Distinguishes message types in QML
     */
    enum MessageType {
        Debug,
        Warning,
        Critical,
        Fatal
    };

    Q_ENUM(MessageType)


signals:
    /**
     *  @brief
     *    Emitted whenever a message was received
     *
     *  param[in] type
     *    Message type
     *
     *  param[in] timestamp
     *    Timestamp when message was received
     *
     *  param[in] message
     *    Message string
     */
    void messageReceived(
        MessageType type, 
        const QDateTime & timestamp, 
        const QString & message);


public:
    /**
     *  @brief
     *    Constructor
     *
     *  Registers itself with the MessageHandler singleton
     */
    QmlMessageForwarder();

    /**
     *  @brief
     *    Constructor
     *
     *  Deregisters itself with the MessageHandler singleton
     */
    ~QmlMessageForwarder();

    /**
     *  @brief
     *    AbstractMessageReceiver interface
     */
    void print(
        QtMsgType type, 
        const QMessageLogContext & context, 
        const QDateTime & timestamp, 
        const QString & message) override;
};


} // namespace qmltoolbox
