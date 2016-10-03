
#include <qmltoolbox/QmlEngine.h>

#include <qmltoolbox/qmltoolbox.h>

    
namespace qmltoolbox
{


QmlEngine::QmlEngine()
{
    // Get data path
    QString dataPath = QString::fromStdString(qmltoolbox::dataPath());
    m_qmlToolboxPath = dataPath + "/qmltoolbox/qml";

    // Import qmltoolbox module
    addImportPath(m_qmlToolboxPath);
}

QmlEngine::~QmlEngine()
{
}

QString QmlEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
