
#include <qmltoolbox/QmlMessageForwarder.h>

#include <QQmlContext>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/QmlUtils.h>
#include <qmltoolbox/MessageHandler.h>

    
namespace qmltoolbox
{


QmlMessageForwarder::QmlMessageForwarder()
{
    MessageHandler::instance().attach(*this);
}

QmlMessageForwarder::~QmlMessageForwarder()
{
    MessageHandler::instance().detach(*this);
}

void QmlMessageForwarder::print(
    QtMsgType type, 
    const QMessageLogContext &, 
    const QDateTime & timestamp, 
    const QString & message)
{
    const auto messageType = static_cast<MessageType>(type);
    emit messageReceived(messageType, timestamp, message);
}


} // namespace qmltoolbox
