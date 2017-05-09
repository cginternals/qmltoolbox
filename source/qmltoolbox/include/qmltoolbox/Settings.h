
#pragma once


#include <QObject>
#include <QList>
#include <QString>

#include <qmltoolbox/qmltoolbox_api.h>


namespace qmltoolbox
{


/**
*  @brief
*    QML object that automatically saves and loads its properties from the settings
*/
class QMLTOOLBOX_API Settings : public QObject
{
    Q_OBJECT


public:
    /**
    *  @brief
    *    Constructor
    */
    Settings();

    /**
    *  @brief
    *    Destructor
    */
    virtual ~Settings();

    /**
    *  @brief
    *    Load settings
    */
    Q_INVOKABLE void load();

    /**
    *  @brief
    *    Save settings
    */
    Q_INVOKABLE void save();


protected:
    /**
    *  @brief
    *    Initialize settings (connect to signals)
    */
    void initialize();


protected slots:
    void onQmlPropertyChanged();


protected:
    bool           m_initialized; ///< Has the object been initialized?
    QList<QString> m_properties;  ///< List of properties that are restored from settings
};


} // namespace qmltoolbox
