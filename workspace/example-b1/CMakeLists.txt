cmake_minimum_required(VERSION 3.16)
project(B1)

find_package(Geant4 REQUIRED ui_all vis_all)

add_executable(exampleB1 exampleB1.cc)
target_link_libraries(exampleB1 ${Geant4_LIBRARIES})
