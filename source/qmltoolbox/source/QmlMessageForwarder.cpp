
#include <qmltoolbox/QmlMessageForwarder.h>

#include <qmltoolbox/MessageHandler.h>


namespace qmltoolbox
{


QmlMessageForwarder::QmlMessageForwarder()
{
    qRegisterMetaType<qmltoolbox::QmlMessageForwarder::MessageType>();

    attach();
}

QmlMessageForwarder::~QmlMessageForwarder()
{
    detach();
}

void QmlMessageForwarder::attach()
{
    MessageHandler::instance().attach(*this);
}

void QmlMessageForwarder::detach()
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
