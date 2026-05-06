cmake_minimum_required(VERSION 3.16)
project(mouse-event LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(mouse-event
    main.cpp
)

qt_add_qml_module(mouse-event
    URI MouseEvent
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(mouse-event PRIVATE Qt6::Quick)
