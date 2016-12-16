
#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QStringList>

#include <qmltoolbox/QmlApplicationEngine.h>


int main(int argc, char *argv[])
{
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // Create QtQuick engine
    qmltoolbox::QmlApplicationEngine engine;

#if (QT_VERSION < QT_VERSION_CHECK(5, 7, 0))
    auto fileSelector = QQmlFileSelector::get(&engine);
    fileSelector->setExtraSelectors(QStringList{"fallback"});
#endif

    // Load and show QML
    engine.load(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/uitest/all.qml"));
    

    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
