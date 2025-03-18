cmake_minimum_required(VERSION 3.14)
project(Ramo3D VERSION 0.1.0 LANGUAGES CXX)

# C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Options
option(WITH_EDITOR "Build with editor support (requires Dear ImGui)" ON)
option(BUILD_SHARED_LIBS "Build as shared library" OFF)
option(BUILD_EXAMPLES "Build example applications" ON)
option(BUILD_TESTS "Build test applications" ON)
option(ENABLE_OPENGL "Enable OpenGL renderer backend" ON)
option(ENABLE_DIRECTX "Enable DirectX 11 renderer backend" OFF)
option(ENABLE_SOFTWARE "Enable software renderer backend" ON)
option(ENABLE_TRACY "Enable Tracy profiler integration" OFF)

# Output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Add compile definitions based on options
if(WITH_EDITOR)
    add_compile_definitions(WITH_EDITOR)
endif()

# Include directories
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# Add compiler warnings
if(MSVC)
    add_compile_options(/W4 /WX)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

# Define build type if not defined
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Add custom platform definitions
if(WIN32)
    add_definitions(-DRAMO3D_PLATFORM_WINDOWS)
elseif(UNIX)
    add_definitions(-DRAMO3D_PLATFORM_LINUX)
endif()

# Debug definitions
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_definitions(-DRAMO3D_DEBUG)
endif()

# Setup external dependencies
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/dependencies.cmake)

# Add engine components
add_subdirectory(src/core)
add_subdirectory(src/platform)
add_subdirectory(src/renderer)
add_subdirectory(src/resources)
add_subdirectory(src/scene)
add_subdirectory(src/editor)

# External dependencies will be added here
add_subdirectory(external)

# Examples
if(BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

# Tests
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# Set Ramo3D project as startup project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

# Create the main engine library target
add_library(Ramo3D INTERFACE
    # Empty for now, will include sources later
)

# Link the engine components
target_link_libraries(Ramo3D 
    INTERFACE
    Core
    Platform
    Renderer
    Resources
    Scene
    Editor
)

# Print configuration summary
message(STATUS "")
message(STATUS "Ramo3D Configuration:")
message(STATUS "  CMake version: ${CMAKE_VERSION}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "  Platform: ${CMAKE_SYSTEM_NAME}")
message(STATUS "  Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  Build examples: ${BUILD_EXAMPLES}")
message(STATUS "  Build tests: ${BUILD_TESTS}")
#message(STATUS "  OpenGL backend: ${RAMO3D_ENABLE_OPENGL}")
#message(STATUS "  DirectX backend: ${RAMO3D_ENABLE_DIRECTX}")
#message(STATUS "  Software backend: ${RAMO3D_ENABLE_SOFTWARE}")
#message(STATUS "  Tracy profiler: ${RAMO3D_ENABLE_TRACY}")
message(STATUS "")

# Create ImGui library with SDL3 + OpenGL3 backend
#add_library(imgui STATIC
#    ${imgui_SOURCE_DIR}/imgui.cpp
#    ${imgui_SOURCE_DIR}/imgui_demo.cpp
#    ${imgui_SOURCE_DIR}/imgui_draw.cpp
#    ${imgui_SOURCE_DIR}/imgui_tables.cpp
#    ${imgui_SOURCE_DIR}/imgui_widgets.cpp
#    ${imgui_SOURCE_DIR}/backends/imgui_impl_sdl3.cpp
#    ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
#)

#target_include_directories(imgui PUBLIC
#    ${imgui_SOURCE_DIR}
#    ${imgui_SOURCE_DIR}/backends
#)

#target_link_libraries(imgui PRIVATE
#    SDL3::SDL3
#    OpenGL::GL
#)

# Gather all source files
#file(GLOB_RECURSE SOURCE_FILES
#    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
#    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/*.cpp
#    #src/renderer/*.cpp
#    #src/renderer/opengl/*.cpp
#    #src/renderer/directx11/*.cpp
#    #src/renderer/pipeline/*.cpp
#    #src/renderer/post_process/*.cpp
#    #src/scene/*.cpp
#    #src/resources/*.cpp
#    #src/materials/*.cpp
#    #src/animation/*.cpp
#    #src/ui/*.cpp
#    #src/utils/*.cpp
#    thirdparty/glad/src/glad.c
#)

# Gather all header files (for IDE organization)
#file(GLOB_RECURSE HEADER_FILES
#    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/*.h
#    #src/renderer/*.hpp
#    #src/renderer/opengl/*.hpp
#    #src/renderer/directx11/*.hpp
#    #src/renderer/pipeline/*.hpp
#    #src/renderer/post_process/*.hpp
#    #src/scene/*.hpp
#    #src/resources/*.hpp
#    #src/materials/*.hpp
#    #src/animation/*.hpp
#    #src/ui/*.hpp
#    #src/utils/*.hpp
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/glad/include/glad/glad.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/glad/include/KHR/khrplatform.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/reasings.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/rmem.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/rres.h
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/raymath.h
#)

# Create executable
#add_executable(${PROJECT_NAME} 
#    ${SOURCE_FILES}
#    ${HEADER_FILES}
#)

# Link against SDL3
#target_link_libraries(Ramo3D PRIVATE 
#    SDL3::SDL3
#    imgui
#    glad
#    assimp::assimp
#)

# Set main project as startup project
#set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

# Include directories
#target_include_directories(${PROJECT_NAME} PRIVATE
#    ${CMAKE_CURRENT_SOURCE_DIR}/src
#    ${CMAKE_CURRENT_SOURCE_DIR}/include
#    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty
#    ${CMAKE_CURRENT_SOURCE_DIR}/lib
#)

# Windows DLL handling
#if(WIN32)
#    # Configure debug/release paths
#    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
#        set(SDL3_DLL_NAME "SDL3d.dll")
#    else()
#        set(SDL3_DLL_NAME "SDL3.dll")
#    endif()
#
#    # Auto-copy DLL
#    add_custom_command(TARGET Ramo3D POST_BUILD
#        COMMAND ${CMAKE_COMMAND} -E copy
#            "${sdl3_BINARY_DIR}/$<CONFIG>/${SDL3_DLL_NAME}"
#            "$<TARGET_FILE_DIR:Ramo3D>"
#        COMMENT "Copying SDL3 DLL to output directory"
#    )
#endif()

# Set C++ standard if needed
#set_target_properties(Ramo3D PROPERTIES
#    CXX_STANDARD 17
#    CXX_STANDARD_REQUIRED YES
#)