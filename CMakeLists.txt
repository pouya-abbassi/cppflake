cmake_minimum_required(VERSION 3.28.3)
set(CMAKE_BUILD_TYPE Release)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
#set(BUILD_SHARED_LIBS OFF)

project(main
  LANGUAGES CXX
  VERSION 1.0.1
  DESCRIPTION "Bildigo telemetry"
  HOMEPAGE_URL "https://app.bildigo.com")

#option(QRCODEGEN_DIR "orcodegen directory" STRING)
set(QRCODEGEN_DIR "" CACHE STRING "Some user-specified option")
message(STATUS "......> ${QRCODEGEN_DIR}")
#find_package(qrcodegen REQUIRED)

#add_library(qrcodegen STATIC
#  ${QRCODEGEN_DIR}/include/qrcodegen.hpp
#  ${QRCODEGEN_DIR}/include/qrcodegen.cpp)
#find_package(qrcodegen REQUIRED)
#find_package(PkgConfig REQUIRED)
#pkg_check_modules(qrcodegen REQUIRED qrcodegen)

add_executable(main main.cpp)
target_include_directories(main PRIVATE "${QRCODEGEN_DIR}/include/")
target_link_libraries(main PRIVATE)
#target_link_libraries(main PRIVATE qrcodegen::qrcodegen)

add_custom_command(TARGET main POST_BUILD
  COMMAND ${CMAKE_STRIP} main)

include(GNUInstallDirs)
install(TARGETS main)
