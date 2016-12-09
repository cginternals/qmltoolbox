
#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QStringList>
#include <QTranslator>
#include <QDebug>

#include <qmltoolbox/QmlApplicationEngine.h>
#include <qmltoolbox/MessageHandler.h>
#include <qmltoolbox/qmltoolbox-version.h>


int main(int argc, char *argv[])
{
    qInstallMessageHandler(qmltoolbox::globalMessageHandler);
    
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
    QGuiApplication app(argc, argv);
    app.setOrganizationName(QMLTOOLBOX_AUTHOR_ORGANIZATION);
    app.setOrganizationDomain("cginternals.com");
    app.setApplicationName(QString(QMLTOOLBOX_PROJECT_NAME) + "_uiconcept");

    // Create QtQuick engine
    qmltoolbox::QmlApplicationEngine engine;
    
    // Setup Localization
    QTranslator translator;
    const auto result = translator.load(QLocale::system(), "uiconcept", ".", engine.qmlToolboxModulePath() + "/examples/uiconcept/i18n");
    app.installTranslator(&translator);
    
#ifdef QML_FALLBACK
    auto fileSelector = QQmlFileSelector::get(&engine);
    fileSelector->setExtraSelectors(QStringList{"fallback"});
#endif
    
    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uiconcept/window.qml"));
    

    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
