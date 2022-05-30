ARG BASE=cginternals/cpp-base:latest
ARG BASE_DEV=cginternals/cpp-base:dev
ARG CPPLOCATE_DEPENDENCY=cginternals/cpplocate:latest
ARG PROJECT_NAME=qmltoolbox

# DEPENDENCIES

FROM $CPPLOCATE_DEPENDENCY AS cpplocate

# BUILD

FROM $BASE_DEV AS build

ARG PROJECT_NAME
ARG COMPILER_FLAGS="-j 4"

RUN apt install -y \
    qtbase5-dev libqt5qml5 qtdeclarative5-dev qtquickcontrols2-5-dev libqt5quicktemplates2-5 \
    libqt5core5a libqt5qml5 libqt5quick5 libqt5quickwidgets5 libqt5quickcontrols2-5 libqt5quicktemplates2-5 \
    qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-layouts \
    qml-module-qtquick-templates2 qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel \
    libqt5opengl5-dev libqt5opengl5

COPY --from=cpplocate $WORKSPACE/cpplocate $WORKSPACE/cpplocate

ENV cpplocate_DIR="$WORKSPACE/cpplocate"

WORKDIR $WORKSPACE/$PROJECT_NAME

ADD cmake cmake
ADD docs docs
ADD deploy deploy
ADD source source
ADD data data
ADD CMakeLists.txt CMakeLists.txt
ADD configure configure
ADD $PROJECT_NAME-config.cmake $PROJECT_NAME-config.cmake
# ADD $PROJECT_NAME-logo.svg $PROJECT_NAME-logo.svg
# ADD $PROJECT_NAME-logo.png $PROJECT_NAME-logo.png
ADD LICENSE LICENSE
ADD README.md README.md
ADD AUTHORS AUTHORS

RUN ./configure
RUN CMAKE_OPTIONS="-DOPTION_BUILD_TESTS=Off -DOPTION_BUILD_EXAMPLES=On" ./configure
RUN cmake --build build -- $COMPILER_FLAGS

# INSTALL

FROM build as install

ARG PROJECT_NAME

WORKDIR $WORKSPACE/$PROJECT_NAME

RUN CMAKE_OPTIONS="-DCMAKE_INSTALL_PREFIX=$WORKSPACE/$PROJECT_NAME-install" ./configure
RUN cmake --build build --target install

# DEPLOY

FROM $BASE AS deploy

ARG PROJECT_NAME

RUN apt install -y libqt5qml5 libqt5quicktemplates2-5 \
    libqt5core5a libqt5qml5 libqt5quick5 libqt5quickwidgets5 libqt5quickcontrols2-5 libqt5quicktemplates2-5 \
    qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-layouts \
    qml-module-qtquick-templates2 qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel \
    libqt5opengl5

COPY --from=build $WORKSPACE/cpplocate $WORKSPACE/cpplocate

COPY --from=install $WORKSPACE/$PROJECT_NAME-install $WORKSPACE/$PROJECT_NAME

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKSPACE/cpplocate/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKSPACE/$PROJECT_NAME/lib
