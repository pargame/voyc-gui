cmake_minimum_required(VERSION 3.16)
project(voyc-gui LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(voyc-gui
    main.cpp
)

qt_add_qml_module(voyc-gui
    URI VoycGui
    VERSION 1.0
    QML_FILES main.qml Config.qml MenuButton.qml UiButton.qml
)

target_link_libraries(voyc-gui PRIVATE Qt6::Quick)
