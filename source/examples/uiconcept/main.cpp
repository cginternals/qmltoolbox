
#include <QGuiApplication>
#include <QTranslator>

#include <qmltoolbox/qmltoolbox-version.h>
#include <qmltoolbox/QmlApplicationEngine.h>
#include <qmltoolbox/MessageHandler.h>


int main(int argc, char *argv[])
{
    qmltoolbox::MessageHandler::instance().installMessageHandlers();

#ifdef QMLTOOLBOX_QT57
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    app.setOrganizationName(QMLTOOLBOX_AUTHOR_ORGANIZATION);
    app.setOrganizationDomain("cginternals.com");
    app.setApplicationName(QString(QMLTOOLBOX_PROJECT_NAME) + "_uiconcept");

    // Create QtQuick engine
    qmltoolbox::QmlApplicationEngine engine;

    // Setup Localization
    QTranslator translator;
    translator.load(QLocale::system(), "uiconcept", ".", engine.qmlToolboxModulePath() + "/examples/uiconcept/i18n");
    app.installTranslator(&translator);

    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uiconcept/window.qml"));

    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
