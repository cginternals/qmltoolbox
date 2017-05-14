
#pragma once


#include <QObject>
#include <QString>

#include <qmltoolbox/AbstractMessageReceiver.h>


namespace qmltoolbox
{


/**
*  @brief
*    Message receiver to forward output messages to a QML item
*/
class QMLTOOLBOX_API QmlMessageForwarder : public QObject, public AbstractMessageReceiver
{
    Q_OBJECT


public:
    /**
    *  @brief
    *    Message type
    */
    enum MessageType 
    {
        Debug,
        Warning,
        Critical,
        Fatal
    };

#if (QT_VERSION < QT_VERSION_CHECK(5, 5, 0))
    Q_ENUMS(MessageType)
#else
    Q_ENUM(MessageType)
#endif


signals:
    /**
    *  @brief
    *    Emitted whenever a message was received
    *
    *  @param[in] type
    *    Message type
    *  @param[in] timestamp
    *    Timestamp when message was received
    *  @param[in] message
    *    Message string
    */
    void messageReceived(qmltoolbox::QmlMessageForwarder::MessageType type, const QDateTime & timestamp, const QString & message);


public:
    /**
    *  @brief
    *    Constructor
    */
    QmlMessageForwarder();

    /**
    *  @brief
    *    Destructor
    */
    virtual ~QmlMessageForwarder();

    /**
    *  @brief
    *    Attach to message handler
    */
    Q_INVOKABLE void attach();

    /**
    *  @brief
    *    Detach from message handler
    */
    Q_INVOKABLE void detach();

    // Virtual AbstractMessageReceiver interface
    virtual void print(QtMsgType type, const QMessageLogContext & context, const QDateTime & timestamp, const QString & message) override;
};


} // namespace qmltoolbox
