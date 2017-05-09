
#pragma once


#include <QObject>

#include <qmltoolbox/qmltoolbox_api.h>


class QUrl;


namespace qmltoolbox
{


/**
*  @brief
*    Qml utility functions
*
*    This object is available in qml as the global property 'QmlUtils'.
*    For this to work, you have to use the QmlEngine class of this project.
*/
class QMLTOOLBOX_API QmlUtils : public QObject
{
    Q_OBJECT


public:
    /**
    *  @brief
    *    Constructor
    *
    *  @param[in] parent
    *    Parent object (can be nullptr)
    */
    QmlUtils(QObject * parent = nullptr);

    /**
    *  @brief
    *    Destructor
    */
    virtual ~QmlUtils();

    /**
    *  @brief
    *    Convert URL to local file
    *
    *  @param[in] url
    *    Url
    *
    *  @return
    *    Local file path (if url points to a local file), else URL string representation
    */
    Q_INVOKABLE QString urlToLocalFile(const QUrl & url) const;
};


} // namespace qmltoolbox
