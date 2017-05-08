
#include <qmltoolbox/QmlApplicationEngine.h>

#include <QtQml>
#include <QQmlContext>
#include <QQmlFileSelector>

#include <qmltoolbox/qmltoolbox.h>
#include <qmltoolbox/qmltoolbox-version.h>
#include <qmltoolbox/QmlUtils.h>
#include <qmltoolbox/QmlMessageForwarder.h>
#include <qmltoolbox/Settings.h>

    
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

    qmlRegisterType<QmlMessageForwarder>("QmlToolbox.Base", 1, 0, "MessageForwarder");
    qmlRegisterType<Settings>           ("QmlToolbox.Base", 1, 0, "Settings");

#ifdef QMLTOOLBOX_QT54
    auto fileSelector = QQmlFileSelector::get(this);
    if (!fileSelector) fileSelector = new QQmlFileSelector(this);
    fileSelector->setExtraSelectors(QStringList{ QMLTOOLBOX_QT54 });
#endif
}

QmlApplicationEngine::~QmlApplicationEngine()
{
}

QString QmlApplicationEngine::qmlToolboxModulePath() const
{
    return m_qmlToolboxPath;
}


} // namespace qmltoolbox
