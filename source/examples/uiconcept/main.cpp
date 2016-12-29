
#include <iostream>

#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QStringList>
#include <QTranslator>
#include <QDebug>

#include <qmltoolbox/qmltoolbox-version.h>
#include <qmltoolbox/QmlApplicationEngine.h>
#include <qmltoolbox/MessageHandler.h>


int main(int argc, char *argv[])
{
   // qInstallMessageHandler(qmltoolbox::globalMessageHandler);
    qmltoolbox::MessageHandler::instance().installStdHandlers();

#ifndef QMLTOOLBOX_QT57
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

#ifdef QMLTOOLBOX_QT54
    auto fileSelector = QQmlFileSelector::get(&engine);
    fileSelector->setExtraSelectors(QStringList{ QMLTOOLBOX_QT54 });
#endif

    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uiconcept/window.qml"));

    qDebug() << "qDebug() message \n with line break";
    std::cout << "std::cout w/o line break";
    std::cout << std::endl << "hallo";
    std::cout << "std::cerr w/o line break";
    
    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
