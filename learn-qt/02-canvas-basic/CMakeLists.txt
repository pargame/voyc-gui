cmake_minimum_required(VERSION 3.16)
project(canvas-basic LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(canvas-basic
    main.cpp
)

qt_add_qml_module(canvas-basic
    URI CanvasBasic
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(canvas-basic PRIVATE Qt6::Quick)
