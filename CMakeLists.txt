cmake_minimum_required(VERSION 3.14)
project(Ramo3D)

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
add_library(glad STATIC
    thirdparty/glad/src/glad.c
)
target_include_directories(glad PUBLIC
    thirdparty/glad/include
)
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
)

target_link_libraries(imgui PRIVATE
    SDL3::SDL3
    OpenGL::GL
)

# Gather all source files
file(GLOB_RECURSE SOURCE_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    #src/core/*.cpp
    #src/renderer/*.cpp
    #src/renderer/opengl/*.cpp
    #src/renderer/directx11/*.cpp
    #src/renderer/pipeline/*.cpp
    #src/renderer/post_process/*.cpp
    #src/scene/*.cpp
    #src/resources/*.cpp
    #src/materials/*.cpp
    #src/animation/*.cpp
    #src/ui/*.cpp
    #src/utils/*.cpp
    thirdparty/glad/src/glad.c
)

# Gather all header files (for IDE organization)
file(GLOB_RECURSE HEADER_FILES
    #src/core/*.hpp
    #src/renderer/*.hpp
    #src/renderer/opengl/*.hpp
    #src/renderer/directx11/*.hpp
    #src/renderer/pipeline/*.hpp
    #src/renderer/post_process/*.hpp
    #src/scene/*.hpp
    #src/resources/*.hpp
    #src/materials/*.hpp
    #src/animation/*.hpp
    #src/ui/*.hpp
    #src/utils/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/glad/include/glad/glad.h
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/glad/include/KHR/khrplatform.h
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/reasings.h
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/rmem.h
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/rres.h
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/raylib/include/raymath.h
)

# Create executable
add_executable(${PROJECT_NAME} 
    ${SOURCE_FILES}
    ${HEADER_FILES}
)

# Link against SDL3
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
    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty
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