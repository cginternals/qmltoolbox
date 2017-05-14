
#include <qmltoolbox/QmlMessageForwarder.h>

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

void QmlMessageForwarder::attach()
{
    MessageHandler::instance().attach(*this);
}

void QmlMessageForwarder::detach()
{
    MessageHandler::instance().detach(*this);
}

void QmlMessageForwarder::print(MessageHandler::MessageType type, const QDateTime & timestamp, const QString & context, const QString & message)
{
    emit messageReceived(static_cast<int>(type), timestamp, context, message);
}


} // namespace qmltoolbox
