cmake_minimum_required(VERSION 3.14)
project(Ramo3D VERSION 0.1.0 LANGUAGES CXX)

# C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Create main directory for all dependencies
set(DEPS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external)

# Enable FetchContent module
include(FetchContent)

# ========== SDL3 Setup ==========
FetchContent_Declare(
    SDL3
    GIT_REPOSITORY https://github.com/libsdl-org/SDL
    GIT_TAG release-3.2.4
    GIT_SUBMODULES ""
)
 
# ========== ASSIMP Setup ==========
FetchContent_Declare(
    assimp
    GIT_REPOSITORY https://github.com/assimp/assimp
    GIT_TAG v5.4.3  # Recommended stable version
    GIT_SUBMODULES ""
)
 
# ========== ImGui Setup ==========
FetchContent_Declare(
    imgui
    GIT_REPOSITORY https://github.com/ocornut/imgui
    GIT_TAG v1.91.8-docking
)
 
FetchContent_MakeAvailable(SDL3 assimp imgui)

# ========== Assimp Configuration ==========
# Disable unnecessary Assimp components
set(ASSIMP_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(ASSIMP_INSTALL OFF CACHE BOOL "" FORCE)
set(ASSIMP_BUILD_ASSIMP_TOOLS OFF CACHE BOOL "" FORCE)

# ========== OpenGL Setup ==========
find_package(OpenGL REQUIRED)

# ========== GLAD Setup ==========
set(GLAD_DIR ${DEPS_DIR}/glad)
set(GLAD_SOURCES ${GLAD_DIR}/src/glad.c)
set(GLAD_INCLUDES ${GLAD_DIR}/include)

add_library(glad STATIC ${GLAD_SOURCES})

target_include_directories(glad PUBLIC ${GLAD_INCLUDES})

target_link_libraries(glad PRIVATE OpenGL::GL)

# Create ImGui library with SDL3 + OpenGL3 backend
add_library(imgui STATIC
    ${imgui_SOURCE_DIR}/imgui.cpp
    ${imgui_SOURCE_DIR}/imgui_demo.cpp
    ${imgui_SOURCE_DIR}/imgui_draw.cpp
    ${imgui_SOURCE_DIR}/imgui_tables.cpp
    ${imgui_SOURCE_DIR}/imgui_widgets.cpp
    ${imgui_SOURCE_DIR}/backends/imgui_impl_sdl3.cpp
    ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
)
 
target_include_directories(imgui PUBLIC
    ${imgui_SOURCE_DIR}
    ${imgui_SOURCE_DIR}/backends
    ${GLAD_INCLUDES}
)
 
target_link_libraries(imgui PRIVATE
    SDL3::SDL3
    OpenGL::GL
)

# ========== raylib Setup ==========
set(RAYLIB_INCLUDE ${DEPS_DIR}/raylib/include)

set(CORE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/core)
set(RENDERER_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/renderer)
set(EDITOR_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/editor)
set(RESOURCES_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/resources)
set(SCENE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/scene)
set(PLATFORM_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/platform)

# Gather all source files
 file(GLOB_RECURSE SOURCE_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    #${RENDERER_SOURCE_DIR}/*.cpp
    #${CORE_SOURCE_DIR}/*.cpp
    #${EDITOR_SOURCE_DIR}/*.cpp
    #${RESOURCES_SOURCE_DIR}/*.cpp
    #${SCENE_SOURCE_DIR}/*.cpp
    #${PLATFORM_SOURCE_DIR}/*.cpp
    ${GLAD_SOURCES}
)
 
set(CORE_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/core)
set(RENDERER_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/renderer)
set(EDITOR_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/editor)
set(RESOURCES_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/resources)
set(SCENE_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/scene)
set(PLATFORM_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/platform)

# Gather all header files (for IDE organization)
file(GLOB_RECURSE HEADER_FILES
    #${RENDERER_SOURCE_DIR}/*.h
    #${CORE_SOURCE_DIR}/*.h
    #${EDITOR_SOURCE_DIR}/*.h
    #${RESOURCES_SOURCE_DIR}/*.h
    #${SCENE_SOURCE_DIR}/*.h
    #${PLATFORM_SOURCE_DIR}/*.h
    ${GLAD_INCLUDES}/glad/glad.h
    ${GLAD_INCLUDES}/KHR/khrplatform.h
    ${RAYLIB_INCLUDE}/*.h
)
 
# Include directories
include_directories(
    ${GLAD_INCLUDES}
    ${imgui_SOURCE_DIR}
    ${imgui_SOURCE_DIR}/backends
    ${RAYLIB_INCLUDE}
)

# Create executable
add_executable(${PROJECT_NAME} 
    ${SOURCE_FILES}
    ${HEADER_FILES}
)

# Link against SDL3, ImGui, Glad and assimp
target_link_libraries(Ramo3D PRIVATE 
    SDL3::SDL3
    imgui
    glad
    assimp::assimp
)

# Set main project as startup project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
 
# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/external
    ${CMAKE_CURRENT_SOURCE_DIR}/lib
)
 
# Windows DLL handling
if(WIN32)
    # Configure debug/release paths
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(SDL3_DLL_NAME "SDL3d.dll")
    else()
        set(SDL3_DLL_NAME "SDL3.dll")
    endif()
 
    # Auto-copy DLL
    add_custom_command(TARGET Ramo3D POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
            "${sdl3_BINARY_DIR}/$<CONFIG>/${SDL3_DLL_NAME}"
            "$<TARGET_FILE_DIR:Ramo3D>"
        COMMENT "Copying SDL3 DLL to output directory"
    )
endif()
 
# Set C++ standard if needed
set_target_properties(Ramo3D PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
)