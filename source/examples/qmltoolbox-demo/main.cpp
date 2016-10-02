
#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>

#include <qmltoolbox/qmltoolbox.h>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Create QtQuick window
    QQuickWindow::setDefaultAlphaBuffer(true);
    QQuickView * window = new QQuickView;

    // Get data path
    QString dataPath = QString::fromStdString(qmltoolbox::dataPath());

    // Load and show QML
    window->setResizeMode(QQuickView::SizeRootObjectToView);
    window->engine()->addImportPath(dataPath + "/qmltoolbox/qml");
    window->setSource(QUrl::fromLocalFile(dataPath + "/qmltoolbox/qml/demos/Demo.qml"));
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
