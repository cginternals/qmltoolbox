
#include <QGuiApplication>

#include <qmltoolbox/QmlApplicationEngine.h>


int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Create QtQuick engine
    qmltoolbox::QmlApplicationEngine engine;

    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uiconcept/window.qml"));
    
    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
