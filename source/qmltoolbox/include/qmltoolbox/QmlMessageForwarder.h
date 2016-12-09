
#pragma once


#include <QObject>
#include <QString>

#include <qmltoolbox/AbstractMessageReceiver.h>
#include <qmltoolbox/qmltoolbox_api.h>


namespace qmltoolbox
{

class QMLTOOLBOX_API QmlMessageForwarder : public QObject, public AbstractMessageReceiver
{
    Q_OBJECT

public:
    enum MessageType {
        Debug,
        Warning,
        Critical,
        Fatal
    };
    Q_ENUM(MessageType)

public:
    QmlMessageForwarder();
    ~QmlMessageForwarder();

    void print(
        QtMsgType type, 
        const QMessageLogContext & context, 
        const QDateTime & timestamp, 
        const QString & message) override;

signals:
    void messageReceived(
        MessageType type, 
        const QDateTime & timestamp, 
        const QString & message);
};

} // namespace qmltoolbox
