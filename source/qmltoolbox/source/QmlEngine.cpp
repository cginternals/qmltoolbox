
#include <qmltoolbox/QmlEngine.h>

#include <QQmlContext>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/QmlUtils.h>

    
namespace qmltoolbox
{


QmlEngine::QmlEngine()
{
    // Get data path
    QString dataPath = QString::fromStdString(qmltoolbox::dataPath());
    m_qmlToolboxPath = dataPath + "/qmltoolbox/qml";

    // Import qmltoolbox module
    addImportPath(m_qmlToolboxPath);

    QmlUtils * qmlUtils = new QmlUtils(this);
    rootContext()->setContextProperty("QmlUtils", qmlUtils);
}

QmlEngine::~QmlEngine()
{
}

QString QmlEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
