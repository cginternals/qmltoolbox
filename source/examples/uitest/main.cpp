
#include <QGuiApplication>

#include <qmltoolbox/QmlApplicationEngine.h>


int main(int argc, char *argv[])
{
#ifdef QMLTOOLBOX_QT57
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // Create QtQuick engine
    qmltoolbox::QmlApplicationEngine engine;

    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uitest/uitest.qml"));

    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
