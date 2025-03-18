include(FetchContent)

# Set default fetchcontent quiet
set(FETCHCONTENT_QUIET OFF)

# ========== SDL3 Setup ==========
message(STATUS "Configuring SDL3...")
FetchContent_Declare(
    SDL3
    GIT_REPOSITORY https://github.com/libsdl-org/SDL
    GIT_TAG release-3.2.4
    GIT_SUBMODULES ""
)
# ========== SDL3 Configuration ==========
set(SDL_SHARED ON CACHE BOOL "Build a SDL shared library (if available)")
set(SDL_STATIC OFF CACHE BOOL "Build a SDL static library (if available)")
set(SDL_TEST OFF CACHE BOOL "Build the SDL test framework")

# ========== ImGui Setup ==========
message(STATUS "Configuring ImGui...")
FetchContent_Declare(
    imgui
    GIT_REPOSITORY https://github.com/ocornut/imgui
    GIT_TAG v1.91.8-docking
)

# ========== ASSIMP Setup ==========
message(STATUS "Configuring ASSIMP...")
FetchContent_Declare(
    assimp
    GIT_REPOSITORY https://github.com/assimp/assimp
    GIT_TAG v5.4.3  # Recommended stable version
    GIT_SUBMODULES ""
)
# ========== Assimp Configuration ==========
set(ASSIMP_BUILD_ASSIMP_TOOLS OFF CACHE BOOL "Build ASSIMP tools")
set(ASSIMP_BUILD_TESTS OFF CACHE BOOL "Build ASSIMP tests")
set(ASSIMP_NO_EXPORT ON CACHE BOOL "Disable ASSIMP export functionality")
set(ASSIMP_BUILD_ALL_IMPORTERS_BY_DEFAULT OFF CACHE BOOL "Build all importers by default")
set(ASSIMP_BUILD_OBJ_IMPORTER ON CACHE BOOL "Build OBJ importer")
set(ASSIMP_BUILD_FBX_IMPORTER ON CACHE BOOL "Build FBX importer")
set(ASSIMP_BUILD_GLTF_IMPORTER ON CACHE BOOL "Build GLTF importer")

FetchContent_MakeAvailable(SDL3 assimp imgui)

# ========== ImGui Linking ==========
# Create ImGui library target
add_library(imgui STATIC
    ${imgui_SOURCE_DIR}/imgui.cpp
    ${imgui_SOURCE_DIR}/imgui_demo.cpp
    ${imgui_SOURCE_DIR}/imgui_draw.cpp
    ${imgui_SOURCE_DIR}/imgui_tables.cpp
    ${imgui_SOURCE_DIR}/imgui_widgets.cpp
    ${imgui_SOURCE_DIR}/backends/imgui_impl_sdl3.cpp
)

# ImGui include directories
target_include_directories(imgui PUBLIC
    ${imgui_SOURCE_DIR}
    ${imgui_SOURCE_DIR}/backends
)

# Link ImGui with SDL3
target_link_libraries(imgui PUBLIC SDL3::SDL3)

# ========== GLAD Configuration ==========
if(ENABLE_OPENGL)
    message(STATUS "Configuring GLAD...")
    FetchContent_Declare(
        glad
        GIT_REPOSITORY https://github.com/Dav1dde/glad.git
        GIT_TAG master
    )
    FetchContent_GetProperties(glad)
    if(NOT glad_POPULATED)
        FetchContent_Populate(glad)
        set(GLAD_API "gl=4.6" CACHE STRING "API type/version pairs")
        set(GLAD_PROFILE "core" CACHE STRING "OpenGL profile")
        set(GLAD_GENERATOR "c" CACHE STRING "Language to generate the binding for")
        set(GLAD_INSTALL ON)
        add_subdirectory(${glad_SOURCE_DIR} ${glad_BINARY_DIR})
    endif()
endif()

# Add OpenGL ImGui implementation if enabled
if(ENABLE_OPENGL)
    target_sources(imgui PRIVATE
        ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
    )
    target_link_libraries(imgui PUBLIC glad)
endif()


# ========== Tracy Profiler Configuration ==========
if(ENABLE_TRACY)
    message(STATUS "Configuring Tracy profiler...")
    set(TRACY_ENABLE ON)
    FetchContent_Declare(
        tracy
        GIT_REPOSITORY https://github.com/wolfpld/tracy.git
        GIT_TAG master
    )
    FetchContent_MakeAvailable(tracy)
    add_library(tracy INTERFACE)
    target_include_directories(tracy INTERFACE ${tracy_SOURCE_DIR}/public)
    target_compile_definitions(tracy INTERFACE TRACY_ENABLE)
else()
    add_library(tracy INTERFACE)
endif()

# ========== Doctest - Header-only testing framework Configuration ==========
if(BUILD_TESTS)
    message(STATUS "Configuring Doctest...")
    FetchContent_Declare(
        doctest
        GIT_REPOSITORY https://github.com/doctest/doctest.git
        GIT_TAG master
    )
    FetchContent_MakeAvailable(doctest)
    add_library(Doctest INTERFACE)
    target_include_directories(Doctest INTERFACE ${doctest_SOURCE_DIR})
endif()