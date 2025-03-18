# External dependencies

# Enable FetchContent module
#include(FetchContent)

# ========== SDL3 Setup ==========
#FetchContent_Declare(
#    SDL3
#    GIT_REPOSITORY https://github.com/libsdl-org/SDL
#    GIT_TAG release-3.2.4
#    GIT_SUBMODULES ""
#)

# ========== ASSIMP Setup ==========
#FetchContent_Declare(
#    assimp
#    GIT_REPOSITORY https://github.com/assimp/assimp
#    GIT_TAG v5.4.3  # Recommended stable version
#    GIT_SUBMODULES ""
#)

# ========== ImGui Setup ==========
#FetchContent_Declare(
#    imgui
#    GIT_REPOSITORY https://github.com/ocornut/imgui
#    GIT_TAG v1.91.8-docking
#)

#FetchContent_MakeAvailable(SDL3 assimp imgui)

# ========== Assimp Configuration ==========
# Disable unnecessary Assimp components
#set(ASSIMP_BUILD_TESTS OFF CACHE BOOL "" FORCE)
#set(ASSIMP_INSTALL OFF CACHE BOOL "" FORCE)
#set(ASSIMP_BUILD_ASSIMP_TOOLS OFF CACHE BOOL "" FORCE)

# ========== OpenGL Setup ==========
#find_package(OpenGL REQUIRED)

# ========== GLAD Setup ==========
#add_library(glad STATIC
#    ${CMAKE_CURRENT_SOURCE_DIR}/glad/src/glad.c
#)

#target_include_directories(glad PUBLIC 
#    ${CMAKE_CURRENT_SOURCE_DIR}/glad/include
#)

#target_link_libraries(glad PRIVATE OpenGL::GL)

# Raylib headers (header-only libraries)
#add_library(raylib_headers INTERFACE)
#target_include_directories(raylib_headers INTERFACE 
#    ${CMAKE_CURRENT_SOURCE_DIR}/raylib/include
#)

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")