
#pragma once


#include <QGuiApplication>
#include <QString>

#include <qmltoolbox/QmlApplicationEngine.h>


namespace qmltoolbox
{


/**
*  @brief
*    Qt application object that initializes QmlToolbox automatically
*
*  @remarks
*    At the beginning of your application, call Application::initialize().
*    This is important to initialize e.g. high DPI scaling and message
*    redirection. Then, instanciate the Application and load a Qml file
*    using loadQml(), or access the Qml engine via qmlEngine().
*    Call Application::exec() to run the main loop.
*/
class QMLTOOLBOX_API Application : public QGuiApplication
{
public:
    /**
    *  @brief
    *    Initialize QmlToolbox
    *
    *  @remarks
    *    This must be called BEFORE creating an instance of Application!
    */
    static void initialize();


public:
    /**
    *  @brief
    *    Constructor
    *
    *  @param[in] argc
    *    Number of command line arguments
    *  @param[in] argv
    *    Command line arguments
    */
    Application(int & argc, char ** argv);

    /**
    *  @brief
    *    Destructor
    */
    virtual ~Application();

    /**
    *  @brief
    *    Load QML file
    *
    *  @param[in] path
    *    Local path
    */
    void loadQml(const QString & path);

    /**
    *  @brief
    *    Get QML engine
    *
    *  @return
    *    QML engine
    */
    const QmlApplicationEngine & qmlEngine() const;

    /**
    *  @brief
    *    Get QML engine
    *
    *  @return
    *    QML engine
    */
    QmlApplicationEngine & qmlEngine();


protected:
    QmlApplicationEngine m_qmlEngine; ///< Spezialied QML engine for QmlToolbox
};


} // namespace qmltoolbox
