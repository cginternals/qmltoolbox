
#include <qmltoolbox/QmlApplicationEngine.h>

#include <QtQml>
#include <QQmlContext>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/QmlUtils.h>
#include <qmltoolbox/QmlMessageForwarder.h>

    
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

    qmlRegisterType<QmlMessageForwarder>("com.cginternals.qmltoolbox", 1, 0, "MessageForwarder");
}

QmlApplicationEngine::~QmlApplicationEngine()
{
}

QString QmlApplicationEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
