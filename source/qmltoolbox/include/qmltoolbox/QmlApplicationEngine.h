
#pragma once


#include <QQmlApplicationEngine>
#include <QString>

#include <qmltoolbox/qmltoolbox_api.h>


namespace qmltoolbox
{


/**
*  @brief
*    Qml engine with qmltoolbox integration
*
*    This is an extended QML engine that automatically adds
*    the search paths for qmltoolbox qml files.
*/
class QMLTOOLBOX_API QmlApplicationEngine : public QQmlApplicationEngine
{
public:
    /**
    *  @brief
    *    Constructor
    */
    QmlApplicationEngine();

    /**
    *  @brief
    *    Destructor
    */
    virtual ~QmlApplicationEngine();

    /**
    *  @brief
    *    Get path to qmltoolbox module
    *
    *  @return
    *    Path to qmltoolbox module
    */
    QString qmlToolboxModulePath() const;


protected:
    QString m_qmlToolboxPath;  ///< Path to qmltoolbox module
};


} // namespace qmltoolbox
