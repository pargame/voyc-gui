cmake_minimum_required(VERSION 3.16)
project(drag-object LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(drag-object
    main.cpp
)

qt_add_qml_module(drag-object
    URI DragObject
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(drag-object PRIVATE Qt6::Quick)
