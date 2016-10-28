
#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>

#include <qmltoolbox/QmlEngine.h>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Create QtQuick engine
    qmltoolbox::QmlEngine engine;

    // Create QtQuick window
    QQuickWindow::setDefaultAlphaBuffer(true);
    QQuickView * window = new QQuickView(&engine, nullptr);

    // Load and show QML
    window->setResizeMode(QQuickView::SizeRootObjectToView);
    window->setSource(QUrl::fromLocalFile(engine.qmlToolboxModulePath() + "/examples/demo/Demo.qml"));
    #ifdef JOLLA
        window->showFullScreen();
    #else
        window->show();
    #endif

    // Run application
    int res = app.exec();

    // Stop application
    return res;
}
