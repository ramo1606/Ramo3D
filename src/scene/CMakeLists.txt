# Scene component CMakeLists.txt

# # Collect source files
# file(GLOB_RECURSE SCENE_SOURCES "*.cpp")
# file(GLOB_RECURSE SCENE_HEADERS "${CMAKE_SOURCE_DIR}/include/scene/*.h")

# # Scene library
# add_library(Scene STATIC ${SCENE_SOURCES} ${SCENE_HEADERS})

# # Set include directories
# target_include_directories(Scene
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/include
#     PRIVATE
#         ${CMAKE_CURRENT_SOURCE_DIR}
# )

# # Add compiler definitions
# target_compile_definitions(Scene
#     PRIVATE
#         SCENE_EXPORTS
# )

# # Link dependencies
# target_link_libraries(Scene
#     PUBLIC
#         Core
#         Resources
#         Renderer
# )

# # Install rules
# install(TARGETS Scene
#     ARCHIVE DESTINATION lib
#     LIBRARY DESTINATION lib
#     RUNTIME DESTINATION bin
# )

# Examples CMakeLists.txt
cmake_minimum_required(VERSION 3.14)

# We'll add actual examples later as we develop the core functionality
message(STATUS "Examples directory - No examples configured yet")