
#include <qmltoolbox/qmltoolbox.h>

#include <cpplocate/cpplocate.h>


namespace
{


std::string determineDataPath()
{
    std::string path = cpplocate::locatePath("data/qmltoolbox", "share/qmltoolbox", reinterpret_cast<void *>(&qmltoolbox::dataPath));
    if (path.empty()) path = "./data";
    else              path = path + "/data";

    return path;
}


} // namespace


namespace qmltoolbox
{


const std::string & dataPath()
{
    static const auto path = determineDataPath();

    return path;
}


} // qmltoolbox
