
#include <qmltoolbox/QmlUtils.h>

#include <QUrl>

#include <qmltoolbox/qmltoolbox.h>

    
namespace qmltoolbox
{


QmlUtils::QmlUtils(QObject * parent)
: QObject(parent)
{
}

QmlUtils::~QmlUtils()
{
}

QString QmlUtils::urlToLocaFile(const QUrl & url) const
{
    if (url.isLocalFile())
    {
        return url.toLocalFile();
    }
    else
    {
        return url.toString();
    }
}


} // namespace qmltoolbox
