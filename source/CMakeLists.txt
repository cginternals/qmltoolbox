
# 
# Configuration for all sub-projects
# 

# External packages
find_package(cpplocate REQUIRED)

# Generate version-header
configure_file(version.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_NAME}/${META_PROJECT_NAME}-version.h)


# 
# Sub-projects
# 

# Libraries
set(IDE_FOLDER "")
add_subdirectory(qmltoolbox)

# Examples
set(IDE_FOLDER "Examples")
add_subdirectory(examples)


# 
# Deployment
# 

# Deploy generated headers
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_NAME} DESTINATION include COMPONENT dev)
