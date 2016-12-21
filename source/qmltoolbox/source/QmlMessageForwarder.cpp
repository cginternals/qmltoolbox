
#include <qmltoolbox/QmlMessageForwarder.h>

#include <QQmlContext>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/QmlUtils.h>
#include <qmltoolbox/MessageHandler.h>

    
namespace qmltoolbox
{


QmlMessageForwarder::QmlMessageForwarder()
{
    attach();
}

QmlMessageForwarder::~QmlMessageForwarder()
{
    detach();
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
    
void QmlMessageForwarder::attach()
{
    MessageHandler::instance().attach(*this);
}

void QmlMessageForwarder::detach()
{
    MessageHandler::instance().detach(*this);
}
    



} // namespace qmltoolbox
