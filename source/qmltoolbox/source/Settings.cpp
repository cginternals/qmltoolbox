
#include <qmltoolbox/Settings.h>

#include <QSettings>
#include <QString>
#include <QVariant>
#include <QMetaProperty>


namespace qmltoolbox
{


Settings::Settings()
: m_initialized(false)
{
}

Settings::~Settings()
{
}

void Settings::load()
{
    // Make sure the object is initialized
    initialize();

    // Load properties
    QSettings settings;
    for (const auto & name : m_properties)
    {
        // Load value
        const auto value = settings.value(name);

        // Set value
        if (value.isValid())
        {
            this->setProperty(name.toStdString().c_str(), value);
        }
    }

    // Object has been initialized
    m_initialized = true;
}

void Settings::save()
{
    // Abort if not initialized
    if (!m_initialized) {
        return;
    }

    // Save properties
    QSettings settings;
    for (const auto & name : m_properties)
    {
        // Get value
        const auto value = this->property(name.toStdString().c_str());

        // Save value
        settings.setValue(name, value);
    }
}

void Settings::forceSave()
{
    initialize();
    m_initialized = true;
    save();
}

void Settings::initialize()
{
    // Abort if already initialized
    if (m_initialized) {
        return;
    }

    // Get meta object
    const QMetaObject * meta = this->metaObject();

    // Enumerate properties
    for (int i = 0; i < meta->propertyCount(); i++)
    {
        // Get property
        const auto property = meta->property(i);
        const auto name = QString(property.name());

        // Ignore 'objectName'
        if (name == "objectName")
        {
            continue;
        }

        // Add property to list
        m_properties.append(name);

        // Connect to property change event
        if (property.hasNotifySignal())
        {
            // Invariant: the metaobject of this is immutable
            static const int propertyChangedIndex = meta->indexOfSlot("onQmlPropertyChanged()");

            QMetaObject::connect(this, property.notifySignalIndex(), this, propertyChangedIndex);
        }
    }
}

void Settings::onQmlPropertyChanged()
{
    save();
}


} // namespace qmltoolbox
