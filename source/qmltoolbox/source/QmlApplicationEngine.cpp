
#include <qmltoolbox/QmlApplicationEngine.h>

#include <QQmlContext>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/QmlUtils.h>

    
namespace qmltoolbox
{


QmlApplicationEngine::QmlApplicationEngine()
{
    // Get data path
    QString dataPath = QString::fromStdString(qmltoolbox::dataPath());
    m_qmlToolboxPath = dataPath + "/qmltoolbox/qml";

    // Import qmltoolbox module
    addImportPath(m_qmlToolboxPath);

    QmlUtils * qmlUtils = new QmlUtils(this);
    rootContext()->setContextProperty("QmlUtils", qmlUtils);
}

QmlApplicationEngine::~QmlApplicationEngine()
{
}

QString QmlApplicationEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
