
#pragma once


#include <qglobal.h>

#include <qmltoolbox/qmltoolbox_api.h>


class QDateTime;
class QMessageContext;
class QString;


namespace qmltoolbox
{


class QMLTOOLBOX_API AbstractMessageReceiver
{
public:
    virtual void print(
        QtMsgType type
    ,   const QMessageLogContext & context
    ,   const QDateTime & timestamp
    ,   const QString & message) = 0;
};


} // namespace qmltoolbox
