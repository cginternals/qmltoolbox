
#include <qmltoolbox/QmlEngine.h>

#include <QtQml>
#include <QQmlContext>
#include <QQmlFileSelector>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/qmltoolbox-version.h>
#include <qmltoolbox/QmlUtils.h>
#include <qmltoolbox/QmlMessageForwarder.h>

    
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

    qmlRegisterType<QmlMessageForwarder>("com.cginternals.qmltoolbox", 1, 0, "MessageForwarder");

#ifdef QMLTOOLBOX_QT54
    auto fileSelector = QQmlFileSelector::get(this);
    if (!fileSelector) fileSelector = new QQmlFileSelector(this);
    fileSelector->setExtraSelectors(QStringList{ QMLTOOLBOX_QT54 });
#endif
}

QmlEngine::~QmlEngine()
{
}

QString QmlEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
