
#include <QTranslator>

#include <qmltoolbox/Application.h>
#include <qmltoolbox/qmltoolbox-version.h>


int main(int argc, char *argv[])
{
    // Initialize qmltoolbox
    qmltoolbox::Application::initialize();

    // Create application
    qmltoolbox::Application app(argc, argv);
    app.setOrganizationName(QMLTOOLBOX_AUTHOR_ORGANIZATION);
    app.setOrganizationDomain("cginternals.com");
    app.setApplicationName(QString(QMLTOOLBOX_PROJECT_NAME) + "_uiconcept");

    // Setup Localization
    QTranslator translator;
    translator.load(QLocale::system(), "uiconcept", ".", app.qmlEngine().qmlToolboxModulePath() + "/examples/uiconcept/i18n");
    app.installTranslator(&translator);

    // Load and show QML
    app.loadQml(app.qmlEngine().qmlToolboxModulePath() + "/examples/uiconcept/Main.qml");

    // Run application
    return app.exec();
}
