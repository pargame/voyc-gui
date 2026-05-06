cmake_minimum_required(VERSION 3.16)
project(zoom-pan LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(zoom-pan
    main.cpp
)

qt_add_qml_module(zoom-pan
    URI ZoomPan
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(zoom-pan PRIVATE Qt6::Quick)
