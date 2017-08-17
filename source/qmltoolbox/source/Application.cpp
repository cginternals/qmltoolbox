
#include <qmltoolbox/Application.h>

#include <QUrl>

#include <qmltoolbox/MessageHandler.h>

    
namespace qmltoolbox
{


void Application::initialize()
{
    // Redirect output to message handler
    qmltoolbox::MessageHandler::instance().installMessageHandlers();

    // Enable high DPI (if available)
#if defined(QMLTOOLBOX_QT57) || defined(QMLTOOLBOX_QT59)
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
}

Application::Application(int & argc, char ** argv)
: QGuiApplication(argc, argv)
{
}

Application::~Application()
{
}

void Application::loadQml(const QString & path)
{
    m_qmlEngine.load(QUrl::fromLocalFile(path));
}

const QmlApplicationEngine & Application::qmlEngine() const
{
    return m_qmlEngine;
}

QmlApplicationEngine & Application::qmlEngine()
{
    return m_qmlEngine;
}


} // namespace qmltoolbox
