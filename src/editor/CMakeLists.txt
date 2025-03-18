# Editor component CMakeLists.txt

# Collect source files
# file(GLOB_RECURSE EDITOR_SOURCES "*.cpp")
# file(GLOB_RECURSE EDITOR_HEADERS "${CMAKE_SOURCE_DIR}/include/editor/*.h")

# Editor library
# add_library(Editor STATIC ${EDITOR_SOURCES} ${EDITOR_HEADERS})

# Set include directories
# target_include_directories(Editor
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# Add compiler definitions
# target_compile_definitions(Editor
#     PRIVATE
#         EDITOR_EXPORTS
# )

# Link dependencies
# target_link_libraries(Editor
#     PUBLIC
#         Core
#         Platform
#         Renderer
#         Scene
#         imgui
# )

# Install rules
# install(TARGETS Editor
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")